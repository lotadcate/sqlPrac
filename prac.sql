
drop table テーブル名; // テーブル自体消す
delete from テーブル名; // テーブルの全てのデータを消す
show fields from テーブル名; // テーブルの構成を表示 selectではない

order by xxx limit 10; // 上位10件
order by xxx limit 4, 5; // 4件目から5件表示

viewはtableと扱い同じ
create view ビュー名 as select テーブル名1.列名1 as ビューの列名1,
                              テーブル名1.列名2 as ビューの項目名2,
from テーブル1, テーブル2 where 条件式;
show tables;

drop view;

列制約,表制約
https://uxmilk.jp/12787 見てみる

集約関数
avg, count, max, min, sum

select 集約関数名(列名) from 表名 group by 列名;

演習2
// 近畿地方のみ
create database todoufukenbase;
create table todoufuken(
    kenmei char(20),
    kenchou char(20),
    jinkou int,
    menseki float
);

insert into todoufuken values ('大阪府', '大阪市', 8807279, 1905.34);
insert into todoufuken values ('兵庫県', '神戸市', 5432560, 8400.94);
insert into todoufuken values ('滋賀県', '大津市', 1410352, 4017.38);
insert into todoufuken values ('京都府', '京都市', 2561358, 4612.20);
insert into todoufuken values ('奈良県', '奈良市', 1315350, 3690.94);
insert into todoufuken values ('和歌山県', '和歌山市', 913523, 4724.68);

select * from todoufuken where jinkou >= 10000000;
select kenmei, kenchou, jinkou from todoufuken where jinkou <= 1000000;
select * from todoufuken where menseki >= 8000;
select kenchou, menseki from todoufuken where menseki <= 3000;

演習3
alter table todoufuken add chihou char(20) after menseki; // first なら　最初のカラムに
update todoufuken set chihou='近畿地方';

// 問題のため追加
insert into todoufuken values ('北海道', '札幌市', 5181776, 78421.36, '北海道地方');

select chihou, sum(jinkou), sum(menseki) from todoufuken group by chihou;
select chihou, count(kenmei) from todoufuken group by chihou;


// max(kenmei_count)の表示だけならできる
select max(kenmei_count)
from (select chihou, count(kenmei) as kenmei_count from todoufuken group by chihou) as max_count;


// countの中のmax
https://qiita.com/khale/items/3106748174ef7fb6d907


where, having の違い
https://dev.classmethod.jp/articles/difference-where-and-having/

演習3.2
select kenmei, jinkou/menseki as jinkoumitudo from todoufuken;

alter table todoufuken add jinkoumitudo float after menseki;
update todoufuken set jinkoumitudo = jinkou/menseki;

create view chihou_view
as select chihou, sum(jinkou) as chihou_jinkou, sum(menseki) as chihou_menseki
from todoufuken group by chihou;

create database jikanwaribase;

use jikanwaribase;

create table gakusei (
    gakuseino char(10),
    namae char(20),
    kana char(30)
);

create table kamoku (
    kamokuno char(10),
    kamokumei char(30),
    kyouin char(20),
    kyoushitsu char(10),
    tani int,
    youbi char(10),
    jigen char(10)
);

create table rishu (
    gakuseino char(10),
    kamokuno char(10)
);

insert into gakusei values ('80AB0001', '田中花子', 'たなかはなこ');
insert into gakusei values ('80AB0002', '山田聡', 'やまださとし');
insert into gakusei values ('80AB0003', '佐藤美那子', 'さとうみなこ');
insert into gakusei values ('80AB0004', '鈴木博', 'すずきひろし');

insert into kamoku values ('C110', 'ネットワーク基礎', '小川', '2111', 2, '火', 1);
insert into kamoku values ('C111', 'プログラミング入門', '川田', '2111', 2, '火', 2);
insert into kamoku values ('C210', 'オペレーティングシステム', '山川', '1203', 2, '月', 3);
insert into kamoku values ('C212', 'データベース', '大山', '1203', 4, '月', 2);
insert into kamoku values ('T1022', '英語1', '島田', '3221', 2, '火', 2);
insert into kamoku values ('T1212', '体育2', '前川', 'グランド', 1, '火', 2);

insert into rishu values ('80AB0001', 'C110');
insert into rishu values ('80AB0001', 'C212');
insert into rishu values ('80AB0001', 'T1022');
insert into rishu values ('80AB0001', 'C321');
insert into rishu values ('80AB0002', 'C211');
insert into rishu values ('80AB0002', 'C321');
insert into rishu values ('80AB0003', 'T1212');
insert into rishu values ('80AB0004', 'C111');

cross join すべての組み合わせ

select * from gakusei inner join rishu on gakusei.gakuseino;

natural join ・・・同じカラム名・同じ型のところで結合
つまり on で指定しなくても共通のキーで結合
https://atmarkit.itmedia.co.jp/ait/articles/1703/01/news186_3.html

select * from gakusei natural inner join rishu;

select
gakusei.namae, kamoku.kamokumei, kamoku.kyoushitsu, kamoku.youbi, kamoku.jigen
from gakusei
inner join rishu on gakusei.gakuseino = rishu.gakuseino
inner join kamoku on rishu.kamokuno = kamoku.kamokuno;

select
gakusei.namae, kamoku.kamokumei, kamoku.kyoushitsu, kamoku.youbi, kamoku.jigen
from gakusei
natural inner join rishu natural inner join kamoku;

演習4.1
select * from kamoku;
select * from gakusei
inner join rishu on gakuseino
inner join kamoku on kamoku.kamokuno;

select kamoku.kamokumei, kamoku.kyoushitsu, kamoku.youbi, kamoku.jigen
FROM gakusei
NATURAL INNER JOIN rishu
NATURAL INNER JOIN kamoku
where gakusei.namae='田中花子';

SELECT kamoku.kamokumei, kamoku.kyoushitsu, kamoku.youbi, kamoku.jigen
FROM gakusei
NATURAL INNER JOIN rishu
NATURAL INNER JOIN kamoku
WHERE gakusei.namae='田中花子'
ORDER BY CASE kamoku.youbi
when '日' then 1
when '月' then 2
when '火' then 3
when '水' then 4
when '木' then 5
when '金' then 6
when '土' then 7 END;

CASE式
https://qiita.com/sfp_waterwalker/items/acc7f95f6ab5aa5412f3

演習4.2
select gakusei.gakuseino, gakusei.namae, sum(kamoku.tani)
from jikanwaribase
where

SELECT gakusei.gakuseino, gakusei.namae, SUM(kamoku.tani) AS total_tani
FROM gakusei
NATURAL INNER JOIN rishu
NATURAL INNER JOIN kamoku
GROUP BY gakusei.gakuseino, gakusei.namae
HAVING SUM(kamoku.tani) > 4;
