SET SERVEROUTPUT ON
SET VERIFY OFF

---------------------------------Package----------------------------------------


CREATE OR REPLACE PACKAGE codashop_pkg AS
------------------------------------Insert--------------------------------------
    PROCEDURE insert_dev (id_dev CHAR, nama VARCHAR2, negara VARCHAR2, tahun NUMBER);
    PROCEDURE insert_game (id_game CHAR, id_dev CHAR, nama VARCHAR2, genre VARCHAR2, tahun NUMBER);
    PROCEDURE insert_ply (id_ply CHAR, id_game CHAR, nama VARCHAR2, email VARCHAR2, negara VARCHAR2);
    PROCEDURE insert_item (id_item CHAR, id_game CHAR, nama VARCHAR2, deskripsi VARCHAR2, harga NUMBER);
    PROCEDURE insert_transaksi (id_trans CHAR, id_player CHAR, id_item CHAR, tanggal DATE, pembayaran VARCHAR2);
------------------------------------Update--------------------------------------
    PROCEDURE update_dev (inp_id CHAR, new_nama VARCHAR2, new_negara VARCHAR2, new_tahun NUMBER);
    PROCEDURE update_game (inp_id CHAR, new_id_dev CHAR, new_nama VARCHAR2, new_genre VARCHAR2, new_tahun NUMBER);
    PROCEDURE update_ply (inp_id CHAR, new_id_game CHAR, new_nama VARCHAR2, new_email VARCHAR2, new_negara VARCHAR2);
    PROCEDURE update_item (inp_id CHAR, new_id_game CHAR, new_nama VARCHAR2, new_deskripsi VARCHAR2, new_harga NUMBER);
    PROCEDURE update_transaksi (inp_id CHAR, new_id_player CHAR, new_id_item CHAR, new_tanggal DATE, new_pembayaran VARCHAR2);
------------------------------------Delete--------------------------------------
    PROCEDURE delete_dev (inp_id CHAR);
    PROCEDURE delete_game (inp_id CHAR);
    PROCEDURE delete_ply (inp_id CHAR);
    PROCEDURE delete_item (inp_id CHAR);
    PROCEDURE delete_transaksi (inp_id CHAR);
-------------------------------------View---------------------------------------
    PROCEDURE view_dev (inp_nama IN VARCHAR2 DEFAULT NULL);
    PROCEDURE view_game (inp_nama IN VARCHAR2 DEFAULT NULL);
    PROCEDURE view_ply (inp_nama IN VARCHAR2 DEFAULT NULL);
    PROCEDURE view_item (inp_nama IN VARCHAR2 DEFAULT NULL);
    PROCEDURE view_transaksi (inp_pembayaran IN VARCHAR2 DEFAULT NULL);
-----------------------------------Function-------------------------------------
    FUNCTION cariDev (id_dev developer.id_developer%TYPE) RETURN developer%ROWTYPE;
    FUNCTION cariGame (id_game game.id_game%TYPE) RETURN game%ROWTYPE;
    FUNCTION cariPlayer (id_ply player.id_player%TYPE) RETURN player%ROWTYPE;
    FUNCTION cariItem (id_item item_game.id_item%TYPE) RETURN item_game%ROWTYPE;
    FUNCTION cariTransaksi (id_trans transaksi.id_transaksi%TYPE) RETURN transaksi%ROWTYPE;
END codashop_pkg;
/


CREATE OR REPLACE PACKAGE BODY codashop_pkg AS
------------------------------------Insert--------------------------------------
    PROCEDURE insert_dev (id_dev CHAR, nama VARCHAR2, negara VARCHAR2, tahun NUMBER) IS
    BEGIN
        INSERT INTO Developer (id_developer , Nama, Negara, Tahun_Berdiri) 
        VALUES (id_dev, nama, negara, tahun);
        COMMIT;
    END insert_dev;
    
    PROCEDURE insert_game (id_game CHAR, id_dev CHAR, nama VARCHAR2, genre VARCHAR2, tahun NUMBER) IS
    BEGIN
        INSERT INTO Game (id_game, Id_developer, Nama, Genre, Tahun_rilis) 
        VALUES (id_game, id_dev, nama, genre, tahun);
        COMMIT;
    END insert_game;
    
    PROCEDURE insert_ply (id_ply CHAR, id_game CHAR, nama VARCHAR2, email VARCHAR2, negara VARCHAR2) IS
    BEGIN
        INSERT INTO Player (id_player, Id_game, Nama, Email, Negara) 
        VALUES (id_ply,id_game, nama, email, negara);
        COMMIT;
    END insert_ply;
    
    PROCEDURE insert_item (id_item CHAR, id_game CHAR, nama VARCHAR2, deskripsi VARCHAR2, harga NUMBER) IS
    BEGIN
        INSERT INTO Item_Game (id_item, Id_game, Nama, deskripsi, harga) 
        VALUES (id_item, id_game, nama, deskripsi, harga);
        COMMIT;
    END insert_item;
    
    PROCEDURE insert_transaksi (id_trans CHAR, id_player CHAR, id_item CHAR, tanggal DATE, pembayaran VARCHAR2) IS
    BEGIN
        INSERT INTO Transaksi (id_transaksi, Id_player, Id_item, Tanggal_transaksi, Metode_pembayaran) 
        VALUES (id_trans, id_player, id_item, tanggal, pembayaran);
        COMMIT;
    END insert_transaksi;

------------------------------------Update--------------------------------------
    PROCEDURE update_dev (inp_id CHAR, new_nama VARCHAR2, new_negara VARCHAR2, new_tahun NUMBER) IS
    BEGIN
        UPDATE Developer SET Nama = new_nama, Negara = new_negara, Tahun_berdiri = new_tahun 
        WHERE id_developer = inp_id;
        COMMIT;
    END update_dev;
    
    PROCEDURE update_game (inp_id CHAR, new_id_dev CHAR, new_nama VARCHAR2, new_genre VARCHAR2, new_tahun NUMBER) IS
    BEGIN
        UPDATE Game SET id_developer = new_id_dev, Nama = new_nama, Genre = new_genre, Tahun_rilis = new_tahun 
        WHERE id_game = inp_id;
        COMMIT;
    END update_game;
    
    PROCEDURE update_ply (inp_id CHAR, new_id_game CHAR, new_nama VARCHAR2, new_email VARCHAR2, new_negara VARCHAR2) IS
    BEGIN
        UPDATE Player SET id_game = new_id_game, Nama = new_nama, Email = new_email, Negara = new_negara 
        WHERE id_player = inp_id;
        COMMIT;
    END update_ply;
    
    PROCEDURE update_item (inp_id CHAR, new_id_game CHAR, new_nama VARCHAR2, new_deskripsi VARCHAR2, new_harga NUMBER) IS
    BEGIN
        UPDATE Item_Game SET id_game = new_id_game, Nama = new_nama, Deskripsi = new_deskripsi, Harga = new_harga 
        WHERE id_item = inp_id;
        COMMIT;
    END update_item;
    
    PROCEDURE update_transaksi (inp_id CHAR, new_id_player CHAR, new_id_item CHAR, new_tanggal DATE, new_pembayaran VARCHAR2) IS
    BEGIN
        UPDATE Transaksi SET id_player = new_id_player, id_item = new_id_item, Tanggal_Transaksi = new_tanggal, Metode_Pembayaran = new_pembayaran 
        WHERE id_transaksi = inp_id;
        COMMIT;
    END update_transaksi;
    
------------------------------------Delete--------------------------------------
    PROCEDURE delete_dev (inp_id CHAR) IS
    BEGIN 
        DELETE FROM Developer WHERE id_developer = inp_id;
    END delete_dev;
    
    PROCEDURE delete_game (inp_id CHAR) IS
    BEGIN 
        DELETE FROM Game WHERE id_game = inp_id;
    END delete_game;

    PROCEDURE delete_ply (inp_id CHAR) IS
    BEGIN 
        DELETE FROM Player WHERE id_player = inp_id;
    END delete_ply;
    
    PROCEDURE delete_item (inp_id CHAR) IS
    BEGIN 
        DELETE FROM Item_Game WHERE id_item = inp_id;
    END delete_item;
    
    PROCEDURE delete_transaksi (inp_id CHAR) IS
    BEGIN 
        DELETE FROM Transaksi WHERE id_transaksi = inp_id;
    END delete_transaksi;
    
-------------------------------------View---------------------------------------
    PROCEDURE view_dev (inp_nama IN VARCHAR2 DEFAULT NULL) IS
        CURSOR cdev IS SELECT * FROM developer WHERE Nama like '%'||inp_nama||'%';
    BEGIN
        FOR i IN cdev LOOP
            DBMS_OUTPUT.PUT_LINE('ID_Developer : '|| i.id_developer ||', Nama : '||i.NAMA||', Negara : ' || i.negara ||
            ', Tahun_Berdiri : ' || i.tahun_berdiri);
        END LOOP;
    END view_dev;
    
    PROCEDURE view_game (inp_nama IN VARCHAR2 DEFAULT NULL) IS
        CURSOR cgame IS SELECT * FROM game WHERE Nama like '%'||inp_nama||'%';
    BEGIN
        FOR i IN cgame LOOP
            DBMS_OUTPUT.PUT_LINE('ID_Game : '|| i.id_game ||', ID_Developer : '||i.id_developer||', Nama : ' || i.NAMA ||
            ', Genre : ' || i.genre || ', Tahun_Rilis : ' || i.tahun_rilis);
        END LOOP;
    END view_game;
    
    PROCEDURE view_ply (inp_nama IN VARCHAR2 DEFAULT NULL) IS
        CURSOR cply IS SELECT * FROM player WHERE Nama like '%'||inp_nama||'%';
    BEGIN
        FOR i IN cply LOOP
            DBMS_OUTPUT.PUT_LINE('ID_Player : '|| i.id_player ||', ID_Game : '||i.id_game||', Nama : ' || i.NAMA ||
            ', Email : ' || i.email || ', Negara : ' || i.negara);
        END LOOP;
    END view_ply;
    
    PROCEDURE view_item (inp_nama IN VARCHAR2 DEFAULT NULL) IS
        CURSOR c_item IS SELECT * FROM item_game WHERE Nama like '%'||inp_nama||'%';
    BEGIN
        FOR i IN c_item LOOP
            DBMS_OUTPUT.PUT_LINE('ID_Item : '|| i.id_item ||', ID_Game : '||i.id_game||', Nama : ' || i.NAMA ||
            ', Deskripsi : ' || i.deskripsi || ', Harga : ' || i.harga);
        END LOOP;
    END view_item;
    
    PROCEDURE view_transaksi (inp_pembayaran IN VARCHAR2 DEFAULT NULL) IS
        CURSOR ctrans IS SELECT * FROM transaksi WHERE Metode_Pembayaran like '%'||inp_pembayaran||'%';
    BEGIN
        FOR i IN ctrans LOOP
            DBMS_OUTPUT.PUT_LINE('ID_Transaksi : '|| i.id_transaksi ||', ID_Player : '||i.id_player||', ID_Item : ' || i.id_item ||
            ', Tanggal_Transaksi : ' || i.tanggal_transaksi || ', Metode_Pembayaran : ' || i.metode_pembayaran);
        END LOOP;
    END view_transaksi;
    
-----------------------------------Function-------------------------------------
    FUNCTION cariDev (id_dev developer.id_developer%TYPE) RETURN developer%ROWTYPE IS
        rec_dev developer%ROWTYPE;
    BEGIN
        SELECT * INTO rec_dev FROM developer WHERE id_developer = id_dev;
    RETURN rec_dev;
    EXCEPTION
        WHEN NO_DATA_FOUND THEN
        RETURN NULL;
    END cariDev;
    FUNCTION cariGame (id_game game.id_game%TYPE) RETURN game%ROWTYPE IS
        rec_game game%ROWTYPE;
    BEGIN
        SELECT * INTO rec_game FROM game WHERE id_game = id_game;
    RETURN rec_game;
    EXCEPTION
        WHEN NO_DATA_FOUND THEN
        RETURN NULL;
    END cariGame;
    FUNCTION cariPlayer (id_ply player.id_player%TYPE) RETURN player%ROWTYPE IS
        rec_ply player%ROWTYPE;
    BEGIN
        SELECT * INTO rec_ply FROM player WHERE id_player = id_ply;
    RETURN rec_ply;
    EXCEPTION
        WHEN NO_DATA_FOUND THEN
        RETURN NULL;
    END cariPlayer;
    FUNCTION cariItem (id_item item_game.id_item%TYPE) RETURN item_game%ROWTYPE IS
        rec_item item_game%ROWTYPE;
    BEGIN
        SELECT * INTO rec_item FROM item_game WHERE Id_item = id_item;
    RETURN rec_item;
    EXCEPTION
        WHEN NO_DATA_FOUND THEN
        RETURN NULL;
    END cariItem;
    FUNCTION cariTransaksi (id_trans transaksi.id_transaksi%TYPE) RETURN transaksi%ROWTYPE IS
        rec_trans transaksi%ROWTYPE;
    BEGIN
        SELECT * INTO rec_trans FROM transaksi WHERE id_transaksi = id_trans;
    RETURN rec_trans;
    EXCEPTION
        WHEN NO_DATA_FOUND THEN
        RETURN NULL;
    END cariTransaksi;
END codashop_pkg;
/


-----------------------------------------running--------------------------------

//insert player

BEGIN
codashop_pkg.insert_ply('00000101', '0401', '3DE', 'silver3de@gmail.com', 'Indonesia');
END;
/

//update player

BEGIN
codashop_pkg.update_ply('00000101', '0401', 'Otrap', 'silver3de@gmail.com', 'Indonesia');
END;
/

//delete player 

BEGIN
codashop_pkg.delete_ply('00000101');
END;
/

//view player

BEGIN
codashop_pkg.view_ply;
END;
/

BEGIN
codashop_pkg.view_ply('L');
END;
/

//cari player


DECLARE
  input_id player.id_player%TYPE;
  rec_ply player%ROWTYPE;
BEGIN
  input_id := '&input_id';

  rec_ply := codashop_pkg.cariPlayer(input_id);
  IF rec_ply.id_player IS NULL THEN  
    DBMS_OUTPUT.PUT_LINE('Data Player dengan ID : '|| input_id|| ' Tidak ditemukan! ');
  ELSE
    DBMS_OUTPUT.PUT_LINE('Data Player dengan ID : '|| input_id|| ' Berhasil ditemukan');
    DBMS_OUTPUT.PUT_LINE('ID Player: '|| rec_ply.id_player ||', ID Game : '|| rec_ply.id_game ||', Nama: ' || rec_ply.nama || 
                        ', Email: ' || rec_ply.email || ', Negara: ' || rec_ply.negara);
  END IF;
END;
/



------------------------------------Trigger-------------------------------------

CREATE TABLE t_hapus
(Nama_user VARCHAR2(30),
Waktu VARCHAR2(25),
Keterangan VARCHAR2(50));


CREATE OR REPLACE TRIGGER H_DEL_PLAYER
AFTER DELETE ON Player
FOR EACH ROW
BEGIN
INSERT INTO t_hapus (NAMA_USER, WAKTU, KETERANGAN) VALUES
(USER,
TO_CHAR(SYSDATE,'DD-MON-YYYY HH24:MI:SS'), 'Terjadi Penghapusan Player'
);
DBMS_OUTPUT.PUT_LINE('TERJADI Penghapusan Player ');
END;

select * from t_hapus;


