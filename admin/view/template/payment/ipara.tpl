<?php echo $header; ?><?php echo $column_left; ?>
<div id="content">
    <div class="page-header">
        <div class="container-fluid">
            <div class="pull-right">
                <button type="submit" form="form-ipara-settings" data-toggle="tooltip" title="<?php echo $button_save; ?>" class="btn btn-primary"><i class="fa fa-save"></i></button>
                <a href="<?php echo $cancel; ?>" data-toggle="tooltip" title="<?php echo $button_cancel; ?>" class="btn btn-default"><i class="fa fa-reply"></i></a></div>
            <h1>iPara Kredi Kartı Ödeme Modülü</h1>
            <ul class="breadcrumb">
                <?php foreach ($breadcrumbs as $breadcrumb) { ?>
                <li><a href="<?php echo $breadcrumb['href']; ?>"><?php echo $breadcrumb['text']; ?></a></li>
                <?php } ?>
            </ul>
        </div>
    </div>

    <div class="container-fluid">
        <?php if(!$ipara_registered OR $ipara_registered == null) { ?>
            <br/><hr/>
			<form action="" method="post">
				<div class="alert alert-warning">
					<h2>Kullanım Şartları </h2>
					<ul>
						<li>iPara modülü Aypara Ödeme Kuruluşu A.Ş tarafından GPL lisansı ile açık kaynaklı ve ücretsiz sunulmaktadır. <b>Satılamaz.</b></li>
						<li>iPara modülü Aypara Ödeme Kuruluşu A.Ş 'nin sağladığı servisleri kullanmak için geliştirilmiştir. Başka amaçla kullanılamaz.</li>
						<li>Uluslararası güvenlik standartlarında kredi kartı bilgilerine erişim veya bilgilerin kayıt edilmesi yasaktır. Bu modül orijinal kaynak kodlarıyla müşterilerinizin kredi kartı bilgilerini asla kaydetmez. Kaynak kodlarını bu kurallara uygun tutmak sizin sorumluluğunuzdadır.</li>
						<li>Bazı mağaza bilgileriniz (mağaza eposta, mağaza adresi ve versiyon) geliştirici teknik destek ve bilgilendirme sistemine otomatik kayıt edilecek ve bu bilgiler önemli bildirimler ile güncellemelerden haberdar olmanız için kullanılacaktır</li>
						<li>Mağaza bilgileriniz asla 3. kişi ve kurumlar ile paylaşılmaz.</li>
					</ul>
					<hr>
					<input type="checkbox" value="1" name="confirm_ipara_register" checked><br/>
					<label for="confirm_ipara">Kullanım şartlarını kabul ediyorum</label>
					<br>
					<button type="submit" class="btn btn-primary">Mağazamı Kaydet ve Başla</button>
				</div>
			</form>
        <?php } else {?>
        <?php if ($error_warning) { ?>
        <div class="alert alert-danger"><i class="fa fa-exclamation-circle"></i> <?php echo $error_warning; ?>
            <button type="button" class="close" data-dismiss="alert">&times;</button>
        </div>
        <?php } ?>
        <div class="panel panel-default">
            <div class="panel-heading">
                <h3 class="panel-title"><i class="fa fa-pencil"></i> <?php echo $text_edit; ?></h3>
            </div>

            <div class="panel-body">
                <ul class="nav nav-tabs" id="tabs">
                    <li class="active"><a href="#tab-ipara_settings" data-toggle="tab">Genel Ayarlar</a></li>
                    <li><a href="#tab-ipara_rates" data-toggle="tab">Taksit Oranları</a></li>
                    <li><a href="#tab-ipara_about" data-toggle="tab">iPara Hakkında</a></li>
                    <li><a href="#tab-ipara_help" data-toggle="tab">Yardım&Teknik destek</a></li>
                </ul>
                <div class="tab-content">
                    <div class="tab-pane active" id="tab-ipara_settings">
                        <form action="<?php echo $action; ?>" method="post" enctype="multipart/form-data" id="form-ipara-settings" class="form-horizontal">

                            <div class="form-group">
                                <label class="col-sm-2 control-label" for="ipara_publickey"><span data-toggle="tooltip" title="<?php echo $help_total; ?>">iPara Açık Anahtar</span></label>
                                <div class="col-sm-10">
                                    <input type="text" name="ipara_publickey" value="<?php echo $ipara_publickey; ?>" placeholder="X1Y2Z3Q4..." id="ipara_publickey" class="form-control" />
                                </div>
                            </div>
                            <div class="form-group">
                                <label class="col-sm-2 control-label" for="ipara_privatekey"><span data-toggle="tooltip" title="<?php echo $help_total; ?>">iPara Gizli Anahtar</span></label>
                                <div class="col-sm-10">
                                    <input type="text" name="ipara_privatekey" value="<?php echo $ipara_privatekey; ?>" placeholder="X1Y2Z3Q4A5B6C7Z8..." id="ipara_privatekey" class="form-control" />
                                </div>
                            </div>
                            <div class="form-group">
                                <label class="col-sm-2 control-label" for="ipara_ins_tab"><span data-toggle="tooltip" title="<?php echo $help_total; ?>">Taksit Seçenekleri Sekmesi</span></label>
                                <div class="col-sm-10">
                                    <select name="ipara_ins_tab" id="input-ipara_ins_tab" class="form-control">              
                                        <option value="on">Göster</option>
                                        <option value="off" <?php if ($ipara_ins_tab == 'off') { ?>selected="selected"<?php } ?>>Gizle</option>
                                    </select>
                                </div>
                            </div>
                            <div class="form-group">
                                <label class="col-sm-2 control-label" for="input-order-status">3D Secure Yönetimi</label>
                                <div class="col-sm-10">
                                    <select name="ipara_3d_mode" id="input-ipara_3d_mode" class="form-control">              
                                        <option value="auto" <?php if ($ipara_3d_mode == 'auto') { ?>selected="selected"<?php } ?>>Otomatik - iPara webservisi karar versin (Önerilen)</option>
                                        <option value="on" <?php if ($ipara_3d_mode == 'on') { ?>selected="selected"<?php } ?>>Tüm ödemeler 3DS ile yapılsın (SMS ile şifre gönder) </option>
                                        <option value="off" <?php if ($ipara_3d_mode == 'off') { ?>selected="selected"<?php } ?>>Asla 3DS kullanma (Hızlı tek sayfada ödeme)</option>
                                    </select>
                                </div>
                            </div>
                            <div class="form-group">
                                <label class="col-sm-2 control-label" for="input-status">Modül Durumu</label>
                                <div class="col-sm-10">
                                    <select name="ipara_status" id="input-status" class="form-control">                
                                        <option value="1" selected="selected">Aktif</option>
                                        <option value="0" <?php if (!$ipara_status) { ?> checked="checked" <?php } ?> >Pasif</option>
                                    </select>
                                </div>
                            </div>
                            <div class="form-group">
                                <label class="col-sm-2 control-label" for="input-status">Sipariş Durumu</label>
                                <div class="col-sm-10">
                                    <select name="ipara_order_status_id" id="input-order-status" class="form-control">
                                        <?php foreach ($order_statuses as $order_status) { ?>
                                        <?php if ($order_status['order_status_id'] == $ipara_order_status_id) { ?>
                                        <option value="<?php echo $order_status['order_status_id']; ?>" selected="selected"><?php echo $order_status['name']; ?></option>
                                        <?php } else { ?>
                                        <option value="<?php echo $order_status['order_status_id']; ?>"><?php echo $order_status['name']; ?></option>
                                        <?php } ?>
                                        <?php } ?>
                                    </select>
                                </div>
                            </div>
								<input type="hidden" name="ipara_submit" value="1"/>
                    </div>
                    <div class="tab-pane" id="tab-ipara_rates">
                            <div class="form-group">
                                <?php echo $ipara_rates_table ?>
                            </div>
                            <input type="hidden" name="ipara_rates_submit" value="1"/>
                            <input type="hidden" name="ipara_registered" value="ok"/>
                            <button type="submit" form="form-ipara-rates" data-toggle="tooltip" title="Oranları kaydet" class="btn btn-primary">Oranları kaydet</button>

                         </form>
                   </div>
                    <div class="tab-pane" id="tab-ipara_about">
					
					
					<div class="panel">
						<div class="row ipara-header">
							<img src="../catalog/view/theme/default/image/ipara/ipara_logo.png" class="col-xs-4 col-md-2 text-center" id="payment-logo">
							<div class="col-xs-6 col-md-5 text-center">
								<h4>Online ödeme çözümü</h4>
								<h4>Hızlı, Güvenli, Kolay</h4>
							</div>
							<div class="col-xs-12 col-md-5 text-center">
								<a href="https://ipara.com" class="btn btn-primary" id="create-account-btn">iPara'ya başvuru yap !</a><br>
								Hesabınız zaten var mı ?<a href="https://ipara.com"> Giriş</a>
							</div>
						</div>

				<hr>
	
				<div class="row">
					<div class="col-md-6">
						<h5>iPara size aşağıdaki avantajları Sağlar</h5>
						<dl>
							<dt>· Onlarca banka kartına taksitli alışveriş sunar</dt>
							<dd>7 bankanın kartlarına 0-12 taksit imkanı sunar. Visa®, Mastercard®, American Express® logosu taşıyan tüm kartlardan ödeme alır</dd>
							
							<dt>· Bankalara göre çok düşük komisyon oranı ödersiniz. </dt>
							<dd>Bankalara teker teker başvuru yapıp bir sürü ücret ödemezsiniz. Ayrıca komisyon oranları oldukça caziptir.</dd>
							
							<dt>· Gelişmiş güvenlik sistemi sağlar.</dt>
							<dd>Bir çok güvenlik duvarı ve şifreleme algoritması ile sizi dolandırıcılara karşı korur.</dd>
							
							<dt>· Tek başvuruyla 7 bankanın sanal posuna sahip olursunuz.</dt>
							<dd>0-12 taksit seçeneği s Word Bonus Axess CarFinans AsyaCard Maximum ve Paraf </dd>
						</dl>
							<img src="../catalog/view/theme/default/image/ipara/available_cards.png" class="col-md-12" id="payment-logo">
					</div>
			
					<div class="col-md-6">
						<h5>iPara API ödeme modülü</h5>
						<ul>
							<li>En kolay, en güvenli ve en hızlı kredi kartı ödeme çözümü</li>
							<li>Sanal terminal</li>
							<li>Tekrarlı ödeme</li>
							<li>24/7/365 müşteri desteği</li>
						</ul>
						<br>
						<em class="text-muted small">
									<img src="../catalog/view/theme/default/image/ipara/ipara_hakkinda.png" class="col-xs-8 col-md-8 text-center" id="">
						</em>
					</div>
				</div>
		<hr>
		
	</div>
					
					
					
                    </div>
                    <div class="tab-pane" id="tab-ipara_help">
						<div class="panel">
							<div class="row ipara-header">
								<img src="../catalog/view/theme/default/image/ipara/ipara_logo.png" class="col-sm-2 text-center" id="payment-logo">
								<div class="col-sm-6 text-center text-muted">
									Soru görüş ve teknik destek istekleriniz için lütfen bu iletişim bilgilerini kullanınız.
								</div>
								<div class="col-sm-4 text-center">
									<a class="btn btn-primary" href="https://www.ipara.com/">ipara.com</a>
									<a class="btn btn-primary" href="mailto:destek@ipara.com">destek@ipara.com</a>
								</div>
							</div>

							<hr>
						</div>					
						<div class="panel">
							<div class="col-sm-2 text-center">
								<img src="../catalog/view/theme/default/image/ipara/eticsoft_logo.png" class="col-sm-12 text-center" id="payment-logo">
							</div>
							<div class="col-sm-7 text-center">
							<p class="text-muted">
								<i class="icon icon-info-circle"></i>Bu modül EticSoft R&amp;D lab tarafından AyPara Aypara Ödeme Kuruluşu A.Ş. için geliştirilmiştir.

							</p>
							</div>
							<div class="col-sm-3 text-center">
							
							<p>
								<a href="#" onclick="javascript:return false;"><i class="icon icon-file"></i>Kullanım Klavuzu</a>
							</p>
							</div>
							<hr>
						</div>
					
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>
<?php } ?>
<?php echo $footer; ?>
<style>
    #content .tab-pane:first-child .panel {
        border-top-left-radius: 0;
    }

    .ipara-header .text-branded,
    .ipara-content .text-branded {
        color: #00aff0;
    }

    .ipara-header h4,
    .ipara-content h4,
    .ipara-content h5 {
        margin: 2px 0;
        color: #00aff0;
        font-size: 1.8em;
    }

    .ipara-header h4 {
        margin-top: 5px;
    }

    .ipara-header .col-md-6 {
        margin-top: 18px;
    }

    .ipara-content h4 {
        margin-bottom: 10px;
    }

    .ipara-content h5 {
        font-size: 1.4em;
        margin-bottom: 10px;
    }

    .ipara-content h6 {
        font-size: 1.3em;
        margin: 1px 0 4px 0;
    }

    .ipara-header > .col-md-4 {
        height: 65px;
        vertical-align: middle;
        border-left: 1px solid #ddd;
    }

    .ipara-header > .col-md-4:first-child {
        border-left: none;
    }

    .ipara-header #create-account-btn {
        margin-top: 14px;
    }

    .ipara-content dd + dt {
        margin-top: 5px;
    }

    .ipara-content ul {
        padding-left: 15px;
    }

    .ipara-content .ul-spaced li {
        margin-bottom: 5px;
    }
    table.ipara_table {
        width:90%;
        margin:auto;
    }
    table.ipara_table td,th {
        width: 60px;
        margin:0px;
        padding:2px;
    }
    table.ipara_table input[type="number"] {
        width:50px;
    }
</style>