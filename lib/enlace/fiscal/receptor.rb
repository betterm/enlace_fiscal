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

      def present_required_attrs?
        street.present? && ext_number.present? && neighborhood.present? &&
            locality.present? && municipality.present? && state.present? &&
            country.present? && postal_code.present?
      end

      def to_h
        back = { 'rfc' => rfc, 'nombre' => name, 'usoCfdi' => 'adquisicion_mercancias' }

        if present_required_attrs?
          back['DomicilioFiscal'] = {}
          back['DomicilioFiscal']['calle'] = street if street.present?
          back['DomicilioFiscal']['noExterior'] = ext_number if ext_number.present?
          back['DomicilioFiscal']['colonia'] = neighborhood if neighborhood.present?
          back['DomicilioFiscal']['localidad'] = locality if locality.present?
          back['DomicilioFiscal']['municipio'] = municipality if municipality.present?
          back['DomicilioFiscal']['estado'] = state if state.present?
          back['DomicilioFiscal']['pais'] = country if country.present?
          back['DomicilioFiscal']['cp'] = postal_code if postal_code.present?
          back['DomicilioFiscal']['noInterior'] = int_number if int_number.present?
        end
        back
      end
    end
  end
end
