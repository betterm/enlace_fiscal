module Enlace
	module Fiscal
		class PaymentReceipt < Entity

			DECIMALS = 2
			CURRENCY = 'MXN'

			def_attributes :serie, :folio, :date, :rfc

			has_one :payment, :receptor

			def initialize
				super
			end

			def valid?
				@errors = {}

				validate_required *attributes

				validate_rfc_format :rfc
				validate_rfc_length :rfc

				super
			end

			def valid_all?
				valid?

				relations.each do |relation|
					name = relation.to_s
					value = send(relation)

					if value.is_a?(Array)
						value.each_with_index do |val, index|
							add_relation_errors name, val, index
						end
					else
						add_relation_errors name, value
					end
				end

				@errors.empty?
			end

			def to_h
				back = {
					"modo" => EF.mode,
					"versionEF" => EF.version,
				  "serie" => serie,
					"folioInterno" => folio,
					"fechaEmision" => date,
					"rfc" => rfc,
					"Receptor" => receptor.to_payment_receipt_h,
					"ComplementoPago" => payment.to_payment_receipt_h
				}
				back
			end

			private

			def add_relation_errors(relation_name, value, index = nil)
				value.valid?

				value.errors.each_pair do |attr, error|
					attr_error_name = if index.nil?
						                  "#{relation_name}_#{attr.to_s}".to_sym
						                else
							                "#{relation_name}_#{index}_#{attr.to_s}".to_sym
					                  end

					add_error(attr_error_name, error.first)
				end
			end
		end
	end
end
