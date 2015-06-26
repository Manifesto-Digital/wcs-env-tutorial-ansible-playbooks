DECLARE
    v_count       INTEGER        := 0;
BEGIN
  SELECT COUNT (1) INTO v_count FROM dba_users WHERE username = UPPER ('{{wcs_database_user}}');
  IF v_count = 0 THEN
    EXECUTE IMMEDIATE 'create user {{wcs_database_user}} identified by {{wcs_database_password}}';
    EXECUTE IMMEDIATE 'grant connect, resource to {{wcs_database_user}}';
  END IF;
END;
/	