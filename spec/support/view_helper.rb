def stub_view(mock, method = :current_cart)
  allow_any_instance_of(ActionView::Base).to receive(method).and_return(mock)
end
