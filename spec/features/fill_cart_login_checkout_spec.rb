require 'rails_helper'

RSpec.describe "fill cart -> login -> checkout", :type => :feature do
  it 'fill cart -> login -> checkout' do
    user = create(:user)
    book_1 = create(:book)
    book_2 = create(:book)
    default_shipment = create(:shipment)

    visit book_path(book_1)
    click_on 'Add to Cart'
    click_on 'Add to Cart'

    expect(page).to have_content 'Cart (2 items)'

    visit book_path(book_2)
    click_on 'Add to Cart'

    expect(page).to have_content 'Cart (3 items)'

    click_on 'Cart (3 items)'
    click_on 'Checkout'

    expect(current_path).to eq '/users/sign_in'

    fill_in 'Email',    with: user.email
    fill_in 'Password', with: user.password
    find('input[name="commit"]').click

    click_on 'Cart (3 items)'
    click_on 'Checkout'

    expect(page).to have_content 'Checkout'

    within('#billing') do
      fill_in('First name',     with: 'Vasya')
      fill_in('Last name',      with: 'Pupkin')
      fill_in('Street address', with: '12 Main Street')
      fill_in('City',     with: 'The Big One')
      fill_in('Country',  with: 'MURICA')
      fill_in('Zip',      with: '1488')
      fill_in('Phone',    with: '+1337 420 14 88')
    end

    within('div#shipment') do
      fill_in('First name',     with: 'Vasya')
      fill_in('Last name',      with: 'Pupkin')
      fill_in('Street address', with: '12 Main Street')
      fill_in('City',     with: 'The Big One')
      fill_in('Country',  with: 'MURICA')
      fill_in('Zip',      with: '1488')
      fill_in('Phone',    with: '+1337 420 14 88')
    end

    click_on 'Save and Continue'
    # leave default shipment
    click_on 'Save and Continue'

    fill_in('Card', with: '1234123412341234')
    fill_in('Expiration year',  with: '2017')
    fill_in('Expiration month', with: '6')
    fill_in('Cvv', with: '359')

    click_on 'Save and Continue'
    click_on 'PLACE ORDER'

    expect(page).to have_content "Order #{Order.last.id}"
  end
end

#############################################################
###################################################   #######
###############################################   /~\   #####
############################################   _- `~~~', ####
##########################################  _-~       )  ####
#######################################  _-~          |  ####
####################################  _-~            ;  #####
##########################  __---___-~              |   #####
#######################   _~   ,,                  ;  `,,  ##
#####################  _-~    ;'                  |  ,'  ; ##
###################  _~      '                    `~'   ; ###
############   __---;                                 ,' ####
########   __~~  ___                                ,' ######
#####  _-~~   -~~ _                               ,' ########
##### `-_         _                              ; ##########
#######  ~~----~~~   ;                          ; ###########
#########  /          ;                        ; ############
#######  /             ;                      ; #############
#####  /                `                    ; ##############
###  /                                      ; ###############
#                                            ################
