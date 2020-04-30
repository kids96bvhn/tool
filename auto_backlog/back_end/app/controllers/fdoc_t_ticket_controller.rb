class FdocTTicketController < ApplicationController
  before_action :cors_set_access_control_headers

# CORS resolve
  def cors_set_access_control_headers
    headers['Access-Control-Allow-Origin'] = '*'
    headers['Access-Control-Allow-Methods'] = 'POST, PUT, DELETE, GET, OPTIONS'
    headers['Access-Control-Request-Method'] = '*'
    headers['Access-Control-Allow-Headers'] = 'Origin, X-Requested-With, Content-Type, Accept, Authorization'
  end

# function lấy data từ DB Lupack
  def index
    @ary_param = params[:mile_stone].split('-')
    time = Time.now.strftime("%Y-%m-%d").to_s
    @tickets = FdocTTicket.select(:tik_i_trac_id, :tik_v_field_summary)
    .where(
      tik_i_pro_id: params[:pro_id],
      tik_i_field_milestone: @ary_param,
      tik_i_status: params[:status]
    ).where('tik_dt_updt LIKE ?', "%#{time}%").where.not(tik_i_trac_id: nil)
    render template: 'fdoc_t_ticket/index.json.jbuilder'
  end

  def notify_update
    @trac_update_ids = params[:trac_id].split('-')
    @tickets = FdocTTicket.select(:tik_i_trac_id, :tik_v_field_summary)
    .where(tik_i_trac_id: @trac_update_ids).order(:tik_i_trac_id => 'ASC')
    AutoMailer.notification_email(@tickets).deliver
    render template: 'fdoc_t_ticket/index.json.jbuilder'
  end
end
