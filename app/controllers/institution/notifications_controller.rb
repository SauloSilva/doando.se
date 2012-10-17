class Institution::NotificationsController < Institution::BaseController
  def index
    @notifications = Notification.all
  end

  def new
    @notification = Notification.new
    @bloods = Blood.scoped
  end

  def show
    @notification = Notification.find_by_slug(params[:id])
  end

  def edit
    @bloods = Blood.scoped
    @notification = Notification.find_by_slug(params[:id])
  end

  def create
    @bloods = Blood.scoped

    @notification = Notification.new(params[:notification])

    if @notification.save
      redirect_to([:institution, :notifications], :notice => t('flash.notification.create.notice'))
    else
      render :action => "new"
    end
  end

  def update
    @bloods = Blood.scoped.map{ |b| [b.name, b.id] }
    @companies = Company.scoped.map{ |b| [b.name, b.id] }

    @notification = Notification.find_by_slug(params[:id])

    if @notification.update_attributes(params[:notification])
      redirect_to([:institution, @notification], :notice => t('flash.notification.update.notice'))
    else
      render :action => "edit"
    end
  end

  def destroy
    @notification = Notification.find_by_slug(params[:id])

    if @notification.destroy
      redirect_to [:institution, :notifications], :notice => t('flash.notification.delete.notice')
    else
      redirect_to :action => 'edit'
    end
  end
end