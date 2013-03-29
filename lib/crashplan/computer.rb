module Crashplan
  class Computer < Resource

    attribute :id, :from => 'computerId'

    def self.delete
      client.delete_computer_block(id)
    end

    def self.block
      client.create_computer_block(id)
    end

  end
end
