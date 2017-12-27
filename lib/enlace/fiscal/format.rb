module Enlace
  module Fiscal
    module Format
      def format_date(date)
        date.strftime('%Y-%m-%d %H:%M:%S')
      end

      def format_decimal(value)
        value ||= 0
        sprintf("%.02f", value)
      end
    end
  end
end
