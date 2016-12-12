module Enlace
  module Fiscal
    class Receptor < Entity
      def_attributes :name, :rfc, :street, :ext_number, :int_number,
        :neighborhood, :locality, :municipality, :state, :country,
        :postal_code, :emails

      def initialize
        super

        self.country = 'México'
      end

      def valid?
        @errors = {}

        validate_required :name, :rfc, :street, :state, :country
        validate_rfc_format :rfc
        validate_rfc_length :rfc

        super
      end

      def to_h
        back = {
          'rfc' => rfc,
          'nombre' => name,
          'DomicilioFiscal' => {
            'calle' => street,
            'noExterior' => ext_number,
            'colonia' => neighborhood,
            'localidad' => locality,
            'municipio' => municipality,
            'estado' => state,
            'pais' => country,
            'cp' => postal_code
          }
        }
        back['DomicilioFiscal']['noInterior'] = int_number if int_number.present?
        back
      end
    end
  end
end
