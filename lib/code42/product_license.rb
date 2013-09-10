module Code42
  class ProductLicense < Resource
    attribute :id, from: 'productLicenseId'
    attribute :creation_date, as: DateTime
    attribute :expiration_date, as: DateTime
    attribute :product_license
  end
end
