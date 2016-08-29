D = 100;

MM = 22; % rows
NN = 23; % columns
N = 19; % # of datapoints

filename={...
    '23','22','21','20','19','18','17','16','15','14','13','12','11','10','9','8','7','6','5','4','3','2','1'...
    ,'24','26','27','28','29','30','31','32','33','34','35','36','37','38','39','40','41','42','43','44','45','46','47'...
    ,'71','70','69','68','67','66','65','64','63','62','61','60','59','58','57','56','55','54','53','52','51','50','48'...
    ,'72','74','75','76','77','78','79','80','81','82','83','84','85','86','87','88','89','90','91','92','93','94','95'...
    ,'119','118','117','116','115','114','113','112','111','110','109','108','107','106','105','104','103','102','101','100','99','98','96'...
    ,'120','122','123','124','125','126','127','128','129','130','131','132','133','134','135','136','137','138','139','140','141','142','143'...
    ,'167','166','165','164','163','162','161','160','159','158','157','156','155','154','153','152','151','150','149','148','147','146','144'...
    ,'168','170','171','172','173','174','175','176','177','178','179','180','181','182','183','184','185','186','187','188','189','190','191'...
    ,'215','214','213','212','211','210','209','208','207','206','205','204','203','202','201','200','199','198','197','196','195','194','192'...
    ,'216','218','219','220','221','222','223','224','225','226','227','228','229','230','231','232','233','234','235','236','237','238','239'...
    ,'263','262','261','260','259','258','257','256','255','254','253','252','251','250','249','248','247','246','245','244','243','242','240'...
    ,'264','266','267','268','269','270','271','272','273','274','275','276','277','278','279','280','281','282','283','284','285','286','287'...
    ,'311','310','309','308','307','306','305','304','303','302','301','300','299','298','297','296','295','294','293','292','291','290','288'...
    ,'312','314','315','316','317','318','319','320','321','322','323','324','325','326','327','328','329','330','331','332','333','334','335'...
    ,'359','358','357','356','355','354','353','352','351','350','349','348','347','346','345','344','343','342','341','340','339','338','336'...
    ,'360','362','363','364','365','366','367','368','369','370','371','372','373','374','375','376','377','378','379','380','381','382','383'...
    ,'407','406','405','404','403','402','401','400','399','398','397','396','395','394','393','392','391','390','389','388','387','386','384'...
    ,'408','410','411','412','413','414','415','416','417','418','419','420','421','422','423','424','425','426','427','428','429','430','431'...
    ,'455','454','453','452','451','450','449','448','447','446','445','444','443','442','441','440','439','438','437','436','435','434','432'...
    ,'456','458','459','460','461','462','463','464','465','466','467','468','469','470','471','472','473','474','475','476','477','478','479'...
    ,'503','502','501','500','499','498','497','496','495','494','493','492','491','490','489','488','487','486','485','484','483','482','480'...
    ,'504','506','507','508','509','510','511','512','513','514','515','516','517','518','519','520','521','522','523','524','525','526','527'};

data = zeros(D*MM*NN, N);

for ii = 1:length(filename)
    data(D*(i-1)+1:D*i,:) = obtain_cubeNcorner_mat(sprintf('Cornaer_Ref_EXP/%s.csv',filename{ii}),2);
end

save(sprintf('corner_d%d.mat',D),'data','MM','NN','N');