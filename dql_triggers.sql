use sakilacampus;


-- 4 NotificarEliminacionAlquiler: Registra una notificación cuando se elimina un registro de alquiler.

delimiter //
create trigger NotificarEliminacionAlquiler
after delete on alquiler
for each row
begin
		set text_message = "error";
	end //
delimiter ;














