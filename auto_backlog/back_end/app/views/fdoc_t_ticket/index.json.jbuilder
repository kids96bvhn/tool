json.entities do
    json.tickets @tickets do |ticket|
      json.extract! ticket,
        :tik_i_trac_id,
        :tik_v_field_summary
    end
  end
