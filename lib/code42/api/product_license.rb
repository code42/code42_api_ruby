module Code42
  module API
    module ProductLicense
      def product_licenses
        objects_from_response(Code42::ProductLicense, :get, 'productLicense', key: 'products')
      end

      def update_product_license(license_key)
        attrs = {
          product_license: license_key,
          key: 'products'
        }
        objects_from_response(Code42::ProductLicense, :put, 'productLicense', attrs)
      end
    end
  end
end
