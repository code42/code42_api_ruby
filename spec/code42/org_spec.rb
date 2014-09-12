require 'spec_helper'

module Code42
  describe Org do
    let(:valid_attributes) do
      {
        "orgId"            => 123,
        "orgUid"           => "ADMIN",
        "orgName"          => "ADMIN",
        "status"           => "Active",
        "active"           => true,
        "blocked"          => false,
        "parentOrgId"      => nil,
        "type"             => "ENTERPRISE",
        "creationDate"     => "2006-05-23T15:11:39.159-05:00",
        "modificationDate" => "2010-03-09T15:06:37.724-06:00"
      }
    end
    let(:org) do
      Org.from_response(valid_attributes)
    end

    describe ".serialize" do
      it "serializes data correctly" do
        data = {
          name: 'Target'
        }
        serialized = Org.serialize(data)
        serialized.should be_a(Hash)
        serialized['orgName'].should eq 'Target'
      end
    end

    describe "#id" do
      it "returns the correct id" do
        org.id.should eq 123
      end
    end

    describe "#created_at" do
      it "returns a DateTime object" do
        org.created_at.should be_a DateTime
      end

      it "returns the correct date" do
        org.created_at.day.should eq 23
        org.created_at.month.should eq 5
        org.created_at.year.should eq 2006
      end
    end

    describe "#updated_at" do
      it "returns a DateTime object" do
        org.updated_at.should be_a DateTime
      end

      it "returns the correct date" do
        org.updated_at.day.should eq 9
        org.updated_at.month.should eq 3
        org.updated_at.year.should eq 2010
      end
    end

    describe 'query methods', :vcr do
      shared_examples 'an org found' do
        it 'returns an org' do
          expect(org).to be_a Org
        end
      end

      describe '.find_by_id' do
        let(:org){ Org.find_by_id org_id }

        shared_examples '.find_by_id' do
          it 'returns the correct org' do
            expect(org.id).to eq org_id
          end

          it_behaves_like 'an org found'
        end

        context 'with an active org' do
          let(:org_id){ 2 }

          it_behaves_like '.find_by_id'
        end

        context 'with an inactive org' do
          let(:org_id){ 190 }

          it_behaves_like '.find_by_id'
        end
      end

      describe '.find_active_by_id' do
        let(:org){ Org.find_active_by_id org_id }

        context 'with the id of an active org' do
          let(:org_id){ 2 }

          it 'returns the org' do
            expect(org.id).to eq org_id
          end

          it_behaves_like 'an org found'
        end

        context 'with the id of an inactive org' do
          let(:org_id){ 190 }

          it 'raises ResourceNotFound' do
            expect { org }.to raise_error Code42::Error::ResourceNotFound
          end
        end
      end

      describe '.find_inactive_by_id' do
        let(:org){ Org.find_inactive_by_id org_id }

        context 'with the id of an active org' do
          let(:org_id){ 2 }

          it 'raises ResourceNotFound' do
            expect { org }.to raise_error Error::ResourceNotFound
          end
        end

        context 'with the id of an inactive org' do
          let(:org_id){ 190 }

          it 'returns the org' do
            expect(org.id).to eq org_id
          end

          it_behaves_like 'an org found'
        end
      end

      describe '.find_by_name' do
        let(:org){ Org.find_by_name org_name }

        shared_examples '.find_by_name' do
          it 'finds the org' do
            expect(org.name).to eq org_name
          end

          it_behaves_like 'an org found'
        end

        context 'with the name of an active org' do
          let(:org_name){ 'PROServer Demo' }

          it_behaves_like '.find_by_name'
        end

        context 'with the name of an inactive org' do
          let(:org_name){ 'Medhurst-Goyette deactivated 2014-09-12 14:13' }

          it_behaves_like '.find_by_name'
        end
      end

      describe '.find_active_by_name' do
        let(:org){ Org.find_active_by_name org_name }

        context 'with the name of an active org' do
          let(:org_name){ 'PROServer Demo' }

          it 'finds the org' do
            expect(org.name).to eq org_name
            expect(org.active).to be_true
          end

          it_behaves_like 'an org found'
        end

        context 'with the name of an inactive org' do
          let(:org_name){ 'Medhurst-Goyette deactivated 2014-09-12 14:13' }

          it 'returns nil' do
            expect(org).to be_nil
          end
        end
      end

      describe '.find_inactive_by_name' do
        let(:org){ Org.find_inactive_by_name org_name }

        context 'with the name of an active org' do
          let(:org_name){ 'PROServer Demo' }

          it 'returns nil' do
            expect(org).to be_nil
          end
        end

        context 'with the name of an inactive org' do
          let(:org_name){ 'Medhurst-Goyette deactivated 2014-09-12 14:13' }

          it 'finds the org' do
            expect(org.name).to eq org_name
            expect(org.active).to be_false
          end

          it_behaves_like 'an org found'
        end
      end

      describe '.find_all_orgs' do
        let(:orgs){ Org.find_all_orgs }

        it 'returns an array of orgs, active or otherwise' do
          expect(orgs.any? &:active).to be_true
          expect(orgs.all? &:active).to be_false
        end
      end

      describe '.find_all_active_orgs' do
        it 'returns an array of active orgs' do
          orgs = Org.find_all_active_orgs
          expect(orgs.all? &:active).to be_true
        end
      end

      describe '.find_all_inactive_orgs' do
        it 'returns an array of inactive orgs' do
          orgs = Org.find_all_inactive_orgs
          expect(orgs.any? &:active).to be_false
        end
      end
    end
  end
end
