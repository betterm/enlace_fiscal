module Enlace
  module Fiscal
    class Payment < Entity
      using Enlace::Fiscal::Blank

      def_attributes :payment_method, :account_number, :details
      DETAILS_TEXT = 'Pago en una sóla exhibición'
      PAYMENT_METHOD_PUE = 'PUE'
      PAYMENT_METHODS = [:credit, :debit, :electronic_transfer, :cash,
                         :check, :unknown, :services, :other]

      # https://developer.enlacefiscal.com/#forma-de-pago
      PAYMENT_METHODS_LOOKUP = {
        unknown: '99',
        cash: '01',
        electronic_transfer: '03',
        check: '02',
        credit: '04',
        debit: '28',
        services: '29',
        other: '99',
        monedero: '05',
        dinero_electronico: '06',
        vales: '08',
        dacion: '12',
        pago_subrogacion: '13',
        pago_consignacion: '14',
        condonacion: '15', compensacion: '17',
        novacion: '23',
        confusion: '24',
        remision: '25',
        prescripcion: '26',
        satisfaccion_acreedor: '27',
        aplicacion_anticipos: '30'
      }

      def initialize
        super

        self.details = DETAILS_TEXT
      end

      def valid?
        @errors = {}

        validate_required *(attributes - [:account_number])
        validate_option PAYMENT_METHODS, :payment_method

        add_error(:account_number, "can't be blank") if account_number_required?

        super
      end

      def to_h
        back = {
          'metodoDePago' => PAYMENT_METHOD_PUE,
          'formaDePago' => PAYMENT_METHODS_LOOKUP[payment_method]
        }
        back['numeroCuentaPago'] = account_number if account_number.present?
        back
      end

      private
      def account_number_required?
        required = (PAYMENT_METHODS - [:cash]).include?(self.payment_method)
        return true if self.account_number.blank? && required
        false
      end
    end
  end
end
