<?php
ini_set("display_errors", "on");

class ControllerExtensionPaymentIpara extends Controller {
	private $error = array();
	
	public function install () {
		$this->load->model('extension/payment/ipara');

		$this->model_extension_payment_ipara->install();
	}
	

	public function index() {
		$this->load->language('payment/ipara');
		
		$this->document->setTitle('Kredi Kartı İle Ödeme');

		$this->load->model('setting/setting');
		
		include(DIR_CATALOG.'controller/payment/iparaconfig.php');

		if (isset($this->request->post['ipara_submit'])) {
			$this->model_setting_setting->editSetting('ipara', $this->request->post);			
			$this->session->data['success'] = $this->language->get('text_success');
			$this->response->redirect($this->url->link('extension/payment/ipara', 'token=' . $this->session->data['token'] . '&type=payment', true));
		}
		
		if (isset($this->request->post['confirm_ipara_register'])) {
			$this->model_setting_setting->editSetting('ipara', array('ipara_registered' => "ok"));
			$this->registerMyStore();
			$this->response->redirect($this->url->link('extension/payment/ipara', 'token=' . $this->session->data['token'] . '&type=payment', true));
		}


		$data['heading_title'] = $this->language->get('heading_title');
		$data['text_edit'] = $this->language->get('text_edit');
		$data['help_total'] = $this->language->get('help_total');
		$data['button_save'] = $this->language->get('button_save');
		$data['button_cancel'] = $this->language->get('button_cancel');
		$data['ipara_registered'] = $this->config->get('ipara_registered');

		
		if (isset($this->error['warning'])) {
			$data['error_warning'] = $this->error['warning'];
		} else {
			$data['error_warning'] = '';
		}
		if($this->config->get('ipara_publickey') == null)
			$data['error_warning'] .= 'iPara Açık Anahtar Boş<br/>';
			
		if($this->config->get('ipara_privatekey') == null)
			$data['error_warning'] .= 'iPara Gizli Anahtar Boş<br/>';
		
		
		if($this->config->get('ipara_rates') == NULL){
			$this->config->set('ipara_rates', iParaConfig::setRatesDefault());
		}
		

		
		
		if (isset($this->request->post['ipara_3d_mode'])) {
			$data['ipara_3d_mode'] = $this->request->post['ipara_3d_mode'];
		} else {
			$data['ipara_3d_mode'] = $this->config->get('ipara_3d_mode');
		}
		
		if (isset($this->request->post['ipara_publickey'])) {
			$data['ipara_publickey'] = $this->request->post['ipara_publickey'];
		} else {
			$data['ipara_publickey'] = $this->config->get('ipara_publickey');
		}

		if (isset($this->request->post['ipara_ins_tab'])) {
			$data['ipara_ins_tab'] = $this->request->post['ipara_ins_tab'];
		} else {
			$data['ipara_ins_tab'] = $this->config->get('ipara_ins_tab');
		}
		
		if (isset($this->request->post['ipara_privatekey'])) {
			$data['ipara_privatekey'] = $this->request->post['ipara_privatekey'];
		} else {
			$data['ipara_privatekey'] = $this->config->get('ipara_privatekey');
		}
		if (isset($this->request->post['ipara_status'])) {
			$data['ipara_status'] = $this->request->post['ipara_status'];
		} else {
			$data['ipara_status'] = $this->config->get('ipara_status');
		}
		if (isset($this->request->post['ipara_order_status_id'])) {
			$data['ipara_order_status_id'] = $this->request->post['ipara_order_status_id'];
		} else {
			$data['ipara_order_status_id'] = $this->config->get('ipara_order_status_id');
		}
		$this->load->model('localisation/order_status');
		$data['order_statuses'] = $this->model_localisation_order_status->getOrderStatuses();

		
		$data['ipara_rates_table'] = iParaConfig::createRatesUpdateForm($this->config->get('ipara_rates'));
		
		$data['header'] = $this->load->controller('common/header');
		$data['column_left'] = $this->load->controller('common/column_left');
		$data['footer'] = $this->load->controller('common/footer');
		$data['breadcrumbs'] = array();

		$data['breadcrumbs'][] = array(
			'text' => $this->language->get('text_home'),
			'href' => $this->url->link('common/dashboard', 'token=' . $this->session->data['token'], 'SSL')
		);
		$data['breadcrumbs'][] = array(
			'text' => $this->language->get('text_payment'),
			'href' => $this->url->link('extension/payment', 'token=' . $this->session->data['token'], 'SSL')
		);
		$data['breadcrumbs'][] = array(
			'text' => $this->language->get('heading_title'),
			'href' => $this->url->link('payment/ipara', 'token=' . $this->session->data['token'], 'SSL')
		);
		$data['action'] = $this->url->link('extension/payment/ipara', 'token=' . $this->session->data['token'], 'SSL');
		$data['cancel'] = $this->url->link('extension/payment', 'token=' . $this->session->data['token'], 'SSL');
		$this->response->setOutput($this->load->view('payment/ipara.tpl', $data));
	}
	
	private function registerMyStore($url = ""){
		$this->load->model('setting/setting');
		

		$d =$_SERVER['HTTP_HOST'];
		if (substr($d, 0, 4) == "www.")
			$d = substr($d, 4);
		return $this->CurlPostExt(rawurldecode("data=
			<query>
				<id_product>20</id_product>
				<version>1.0</version>
				<domain>".$d."</domain>
				<ip>".$_SERVER['SERVER_ADDR']."</ip>
				<email>".$this->config->get('config_email')."</email>
				<customer_name><![CDATA[".$this->config->get('config_name')."]]></customer_name>
				<parent_version>".VERSION."</parent_version>
				<ipara><![CDATA[".$this->config->get('ipara_publickey')."]]></ipara>
			</query>
			"), "http://eticsoft.com/api/modulecheck.php?action=1");
	}
	
	private function curlPostExt($data, $url){
		$ch = curl_init();    // initialize curl handle
		curl_setopt($ch, CURLOPT_URL,$url); // set url to post to
		curl_setopt($ch, CURLOPT_RETURNTRANSFER,1); // return into a variable
		curl_setopt($ch, CURLOPT_SSL_VERIFYHOST, 0); 
		curl_setopt($ch, CURLOPT_SSL_VERIFYPEER, 0); 
		curl_setopt($ch, CURLOPT_TIMEOUT, 30); // times out after 4s
		curl_setopt($ch, CURLOPT_POST, 1); // set POST method
		curl_setopt($ch, CURLOPT_POSTFIELDS, $data); // add POST fields
		if($result = curl_exec($ch)) { // run the whole process
			curl_close($ch); 
			return $result;
		}
	}

	protected function validate() {
		
		if (!$this->user->hasPermission('modify', 'payment/ipara')) {
			$this->error['warning'] = $this->language->get('error_permission');
		}
		
		return true;
		
		$this->load->model('localisation/language');

		$languages = $this->model_localisation_language->getLanguages();

		foreach ($languages as $language) {
			if (empty($this->request->post['ipara_bank' . $language['language_id']])) {
				$this->error['bank' .  $language['language_id']] = $this->language->get('error_bank');
			}
		}

		return !$this->error;
	}
}