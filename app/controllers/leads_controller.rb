class LeadsController < ApplicationController
  before_action :set_lead, only: [:show, :edit, :update, :destroy]

  # GET /leads
  # GET /leads.json
  # def index
  #   @leads = Lead.all
  # end

  # GET /leads/1
  # GET /leads/1.json
  # def show
  # end

  # GET /leads/new
  # def new
  #   @lead = Lead.new
  # end

  # GET /leads/1/edit
  # def edit
  # end

  # POST /leads
  # POST /leads.json
  def create
    @lead = Lead.new(lead_params)

    respond_to do |format|
      if verify_recaptcha(model: @lead) && @lead.save
        mg_client = Mailgun::Client.new
        message = {
          :from => @lead.email,
          :to => 'ordrhub@gmail.com',
          :subject => "New Lead (ID: #{@lead.id})",
          :text => params['beta_body']
        }

        mg_client.send_message 'mg.ordrhub.com', message

        format.html { redirect_to root_url, notice: 'Thank you for your interest! We\'ll review your request shortly.' }
        format.json { render :show, status: :created, location: @lead }
      else
        format.html { redirect_to root_url, alert: 'Uh-oh, it looks like you\'re either a robot or have already a submitted a request using that email. We still may be reviewing your request and we\'ll let you know when you\'re able to access OrdrHub as soon as possible!' }
        format.json { render json: @lead.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /leads/1
  # PATCH/PUT /leads/1.json
  # def update
  #   respond_to do |format|
  #     if @lead.update(lead_params)
  #       format.html { redirect_to @lead, notice: 'Lead was successfully updated.' }
  #       format.json { render :show, status: :ok, location: @lead }
  #     else
  #       format.html { render :edit }
  #       format.json { render json: @lead.errors, status: :unprocessable_entity }
  #     end
  #   end
  # end

  # DELETE /leads/1
  # DELETE /leads/1.json
  # def destroy
  #   @lead.destroy
  #   respond_to do |format|
  #     format.html { redirect_to leads_url, notice: 'Lead was successfully destroyed.' }
  #     format.json { head :no_content }
  #   end
  # end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_lead
      @lead = Lead.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def lead_params
      params.require(:lead).permit(:email, :grubhub, :yelp, :chownow, :doordash)
    end
end
