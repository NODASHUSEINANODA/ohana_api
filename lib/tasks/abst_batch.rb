class Tasks::AbstBatch
  def self.logger
    Rails.application.config.batch_logger
  end

  def self.execute(batch_title)
    logger.info "#{batch_title} バッチ開始"

    begin
      yield
      logger.info "#{batch_title} バッチ正常終了"
    rescue StandardError => e
      logger.fatal "#{batch_title} バッチが異常終了しました\n#{e.message}"
      logger.fatal e.backtrace.join("\n")
    end
  end
end