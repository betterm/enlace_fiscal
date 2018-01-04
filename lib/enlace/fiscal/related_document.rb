module Enlace
	module Fiscal
		class RelatedDocument < Entity
			using Enlace::Fiscal::Blank

			def_attributes :uuid, :serie, :folio, :payment_method, :parts_number,
			               :currency, :balance_before, :amount, :balance_after, :exchange_rate

			PAYMENT_METHOD_PPD = 'PPD'
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

				@related_documents = []
			end

			def valid?
				@errors = {}

				validate_option PAYMENT_METHODS, :payment_method
				validate_less_than_zero :balance_before, :amount, :balance_after

				super
			end

			def to_h
				back =
					{
						idDocumento: uuid,
						serie: serie,
						folioInterno: folio,
						metodoDePago: PAYMENT_METHOD_PPD,
						numParcialidad: parts_number,
						tipoMoneda: currency,
						saldoAnterior: balance_before,
						importePagado: amount,
						impoSaldoInsoluto: balance_after
					}
				back
			end

			private

		end
	end
end
