class users::admins {
  users::managed_user { ['jose', 'alice', 'chen']: }
  
  users::managed_user { 'george':
    ssh_authkey => 'AAAAB3NzaC1yc2EAAAADAQABAAACAQC8UGvCuEudjZVW/ORREPelui4qu/Acm5L8mkBQdD7YMg4+A6AEeIBlhGntBX54AsOno58F2Bk0qQDe+6a5c5EsKJGzyewohcLXD/Wdfo9ZtViZ/pXBfnf+9hlwVPNkR4Wy7/ltumqoemD8FSXHdscDMp4mXYnihz1HrQMQryNXWh+LNkD0aZg8iQj4Jf0b6gXlAxM56Xol3u5BbhcNNwGF1OvD9EVX7xy2Xvw+CMxJybK/I11WbXU9kr9Hiyeyw3Z+vM5yICAiU/E0xLyXRjDlG5L9VvWS+6OQ0ikCB5b6Q6uE9Is4VVF+ehGzJ8nD7JuGCnSLFjYOj86VPlMpTQ+jdTC6oewUegNwkOq41bIwZ0v2z0gAteYr3C9gqofcJxYTLS+s72wuuNxEqB5EBZ+1eG8S02YFdKPHQs7YBPGW+sR+pgFWX1e+cgGBvK8BxSeD78P9zVy1DM8pFiPWxxZKeX19cwZNq5cWjMT26EmGvVjYCY8mWQ3N1nZ9znvyZ7RlIkbe+FcTdAe9nLUrMqEZAWTZiCX4nXIX1GJ8ug84cN6XySLNY/1Fl7lKfUbsJgemIxD+BW/1z8U3d5wtaMvxzPSHu/3xanlzMO7C0ClqI/68cc2+ncDV++KiDkqFDrBya/y3nwE1VLWEyQryfFkshLmmw4s8rqXGYSOfYm6nXQ==',
  }
  
  users::managed_user { 'tomcat7':
    home => '/opt/tomcat7',
    shell => '/sbin/nologin',
  }
}
