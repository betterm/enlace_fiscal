module Enlace
  module Fiscal
    class Line < Entity
      def_attributes :quantity, :unit, :sku, :description,
        :unit_price, :total, :vat_rate, :vat_amount

      # UNITS = [:piece, :na]
      # UNIT_LOOKUP = { piece: 'pieza', na: 'No aplica' }

      def initialize
        super

        self.unit = :piece
      end

      def valid?
        @errors = {}

        validate_required *(attributes - [:sku])
        validate_equal_or_less_than_zero :quantity, :unit_price
        # validate_option UNITS, :unit

        super
      end

      def sanitize
        total = total.to_f.round(2)
        unit_price = unit_price.to_f.round(2)
      end

      def to_h
        # {
        #   'cantidad' => quantity,
        #   'unidad' => unit,
        #   'descripcion' => description,
        #   'noIdentificacion' => sku,
        #   'valorUnitario' => format_decimal(unit_price),
        #   'importe' => format_decimal(total)
        # }
        sanitize
        {
          "cantidad" => quantity,
          "claveUnidad" => 'E48',
          "claveProdServ" => "78102200",
          # "claveProdServ" => sku,
          "descripcion" => description,
          "valorUnitario" => format_decimal(unit_price),
          "importe" => format_decimal(total),
          "Impuestos" => [
            {
              "tipo" => "traslado",
              "claveImpuesto" => "IVA",
              "tipoFactor" => "tasa",
              "tasaOCuota" => vat_rate,
              "baseImpuesto" => format_decimal(total),
              "importe" => format_decimal(vat_amount)
            }
          ]
        }
      end
    end
  end
end
