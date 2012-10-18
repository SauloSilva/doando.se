class GmapController < ApplicationController
  def find_elements_to_map
    position = [params[:position][:lat].to_f, params[:position][:lng].to_f]
    distance = params[:distance].to_i
    blood_types = params[:blood_types]
    types = params[:types]
    @people = []
    @companies = []

    if !types || 'company'.in?(types)
      @companies = GMap.elements_by_distance(position, distance, 'Company').map(&:addressable).map do |r|
        {id: r.id, lat: r.address.loc[0], lng: r.address.loc[1] }
      end
    end

    if !types || 'person'.in?(types)
      @people = GMap.elements_by_distance(position, distance, 'Person').map(&:addressable).map do |r|
        if blood_types
          if r.blood.name.in? blood_types
            {id: r.id, lat: r.address.loc[0], lng: r.address.loc[1] }
          end
        else
          {id: r.id, lat: r.address.loc[0], lng: r.address.loc[1] }
        end
      end
    end

    render json: { people: @people.compact, companies: @companies.compact}
  end

  def find_elements_to_notification
    position = [params[:position][:lat].to_f, params[:position][:lng].to_f]
    distance = params[:distance].to_i
    blood_types = params[:bloods]

    @people = GMap.elements_by_distance(position, distance, 'Person').map(&:addressable).map do |r|
      if blood_types
        if r.blood.name.in? blood_types
          { name: r.name, address: r.address.formated_address }
        end
      else
        { name: r.name, address: r.address.formated_address }
      end
    end

    render json: { people: @people.compact }
  end
end