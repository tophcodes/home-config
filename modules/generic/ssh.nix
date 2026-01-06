{...}: {
  services.openssh = {
    enable = true;
    settings = {
      PasswordAuthentication = false;
      # TODO: Determine which user to allow!
      AllowUsers = ["toph" "root"];
    };
  };
}
