module Enlace
  module Fiscal
    ::EF = Enlace::Fiscal unless defined?(::EF)

    autoload :Blank,  'enlace/fiscal/refinements/blank'
    autoload :Client,  'enlace/fiscal/client'
    autoload :Service,  'enlace/fiscal/service'

    autoload :Format,  'enlace/fiscal/format'

    autoload :Tax,  'enlace/fiscal/tax'
    autoload :Line,  'enlace/fiscal/line'
    autoload :Receptor,  'enlace/fiscal/receptor'
    autoload :Payment,  'enlace/fiscal/payment'
    autoload :Invoice,  'enlace/fiscal/invoice'
    autoload :Entity,  'enlace/fiscal/entity'
    autoload :Version,  'enlace/fiscal/version'
    autoload :PaymentReceipt,  'enlace/fiscal/payment_receipt'
    autoload :RelatedDocument,  'enlace/fiscal/related_document'

    def self.username
      @@username ||= ''
    end

    def self.username=(value)
      @@username = value
    end

    def self.password
      @@password ||= ''
    end

    def self.password=(value)
      @@password = value
    end

    def self.mode
      @@mode ||= 'debug'
    end

    def self.mode=(value)
      @@mode = value
    end

    def self.version=(value)
      @@version = value
    end

    def self.version
      @@version ||= '6.0'
    end
  end
end
