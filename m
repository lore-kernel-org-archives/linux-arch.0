Received: from pdx-out-008.esa.us-west-2.outbound.mail-perimeter.amazon.com (pdx-out-008.esa.us-west-2.outbound.mail-perimeter.amazon.com [52.42.203.116])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A8D737A49C;
	Mon, 20 Apr 2026 16:58:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=52.42.203.116
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776704321; cv=none; b=ab//TkeGB+2sqW2OlXn2EfSb/CLRq/AH12xDiM6ucJtluVIpP/r88lpqEv/HJhLaB52aCDZYJ8sqrAzcAiE0DyFLPkY806C7i2EA+k8HqaTOE/5n0vDODAmYUb04aDUye/Wn2wKTBB1mJ/sl3ZXIavpitDqMNH6gWZAxoDwZ3cQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776704321; c=relaxed/simple;
	bh=6HP/DBBZt8GDHfg7Vxz91VK2Pm+O0Qa9CbbkeDhNaA4=;
	h=Subject:From:To:CC:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Zpfd/WY/2GyWSUVRUnXAxK4PW3GdwSarOP3dDSa0ggUdzmM+i6ow0dK54yT00oYBPSVHlmF/BqjRzQjle0Q4W9VJNFOG+85ZUILxEdO4g2kP74To3O+tGISib6w96LKG9lzEpoax1BfX23rFGe+eylK9jQPxKhXRAI4RQ+7dl7Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.com; dkim=pass (2048-bit key) header.d=amazon.com header.i=@amazon.com header.b=cCWQTDz+; arc=none smtp.client-ip=52.42.203.116
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amazon.com header.i=@amazon.com header.b="cCWQTDz+"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazoncorp2;
  t=1776704320; x=1808240320;
  h=from:to:cc:date:message-id:references:in-reply-to:
   content-id:content-transfer-encoding:mime-version:subject;
  bh=6HP/DBBZt8GDHfg7Vxz91VK2Pm+O0Qa9CbbkeDhNaA4=;
  b=cCWQTDz+Hid++XHnK2wx4RKaU0h73ZLn4a5pKTd7vYMPLc8+wME6vj5K
   piU6PJi0wDL5gjNIgk1kVVuAXcSDN5P1z+7oy+W6Q2M80UjK257uMbT6b
   JgADw0IxENxNqdBIsPMfjEovJ+X3hv7f5Ct+omeU6tj9AVHCdbBrmb+7j
   ynJNGqtjw31U177S7wBsjbbRkd8SBFeHg73pbECcVQD7IwtLDYs6tCLkv
   Bb3J6qU6IGHsIURWJeN3oIU03BghVupEml/U9L2GN4PQY3J0yTQSHkhLK
   XTgpLhDI97s/TnI1s1LxmPpApxcO/0jSBMbIfUUIkrsuccFUfKpf/jhSD
   Q==;
X-CSE-ConnectionGUID: sIOZLv0sQtmvqPB2tHRQEQ==
X-CSE-MsgGUID: DOS/F2v6TqmMmBr7utCKpw==
X-IronPort-AV: E=Sophos;i="6.23,190,1770595200"; 
   d="scan'208";a="17755569"
Subject: Re: [PATCH v11 12/14] cpuidle/poll_state: Wait for need-resched via
 tif_need_resched_relaxed_wait()
Thread-Topic: [PATCH v11 12/14] cpuidle/poll_state: Wait for need-resched via
 tif_need_resched_relaxed_wait()
Received: from ip-10-5-12-219.us-west-2.compute.internal (HELO smtpout.naws.us-west-2.prod.farcaster.email.amazon.dev) ([10.5.12.219])
  by internal-pdx-out-008.esa.us-west-2.outbound.mail-perimeter.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Apr 2026 16:58:39 +0000
Received: from EX19MTAUWA002.ant.amazon.com [205.251.233.234:11136]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.43.27:2525] with esmtp (Farcaster)
 id 8909fea4-da9e-41e0-a404-c68a14937da1; Mon, 20 Apr 2026 16:58:39 +0000 (UTC)
X-Farcaster-Flow-ID: 8909fea4-da9e-41e0-a404-c68a14937da1
Received: from EX19D032UWA004.ant.amazon.com (10.13.139.56) by
 EX19MTAUWA002.ant.amazon.com (10.250.64.202) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.37;
 Mon, 20 Apr 2026 16:57:34 +0000
Received: from EX19D032UWA003.ant.amazon.com (10.13.139.37) by
 EX19D032UWA004.ant.amazon.com (10.13.139.56) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.37;
 Mon, 20 Apr 2026 16:57:34 +0000
Received: from EX19D032UWA003.ant.amazon.com ([fe80::8e94:8f60:9531:c497]) by
 EX19D032UWA003.ant.amazon.com ([fe80::8e94:8f60:9531:c497%5]) with mapi id
 15.02.2562.037; Mon, 20 Apr 2026 16:57:33 +0000
From: "Okanovic, Haris" <harisokn@amazon.com>
To: "ankur.a.arora@oracle.com" <ankur.a.arora@oracle.com>
CC: "joao.m.martins@oracle.com" <joao.m.martins@oracle.com>,
	"xueshuai@linux.alibaba.com" <xueshuai@linux.alibaba.com>,
	"david.laight.linux@gmail.com" <david.laight.linux@gmail.com>,
	"boris.ostrovsky@oracle.com" <boris.ostrovsky@oracle.com>, "memxor@gmail.com"
	<memxor@gmail.com>, "ashok.bhat@arm.com" <ashok.bhat@arm.com>,
	"zhenglifeng1@huawei.com" <zhenglifeng1@huawei.com>, "konrad.wilk@oracle.com"
	<konrad.wilk@oracle.com>, "cl@gentwo.org" <cl@gentwo.org>,
	"akpm@linux-foundation.org" <akpm@linux-foundation.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"catalin.marinas@arm.com" <catalin.marinas@arm.com>, "ast@kernel.org"
	<ast@kernel.org>, "rdunlap@infradead.org" <rdunlap@infradead.org>,
	"daniel.lezcano@linaro.org" <daniel.lezcano@linaro.org>, "arnd@arndb.de"
	<arnd@arndb.de>, "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>,
	"will@kernel.org" <will@kernel.org>, "mark.rutland@arm.com"
	<mark.rutland@arm.com>, "peterz@infradead.org" <peterz@infradead.org>,
	"bpf@vger.kernel.org" <bpf@vger.kernel.org>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "Okanovic, Haris"
	<harisokn@amazon.com>, "rafael@kernel.org" <rafael@kernel.org>,
	"linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>
Thread-Index: AQHcx1MT8HBQ4TuTGEClBPJM7WvFxrXoPugA
Date: Mon, 20 Apr 2026 16:57:33 +0000
Message-ID: <a374b23f8b03f850a874d46bc78411fb99483ca2.camel@amazon.com>
References: <20260408122538.3610871-1-ankur.a.arora@oracle.com>
	 <20260408122538.3610871-13-ankur.a.arora@oracle.com>
In-Reply-To: <20260408122538.3610871-13-ankur.a.arora@oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
Content-Type: text/plain; charset="utf-8"
Content-ID: <A188B63D186ECB48A6E242EA9484E9C1@amazon.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

T24gV2VkLCAyMDI2LTA0LTA4IGF0IDE3OjU1ICswNTMwLCBBbmt1ciBBcm9yYSB3cm90ZToNCj4g
Q0FVVElPTjogVGhpcyBlbWFpbCBvcmlnaW5hdGVkIGZyb20gb3V0c2lkZSBvZiB0aGUgb3JnYW5p
emF0aW9uLiBEbyBub3QgY2xpY2sgbGlua3Mgb3Igb3BlbiBhdHRhY2htZW50cyB1bmxlc3MgeW91
IGNhbiBjb25maXJtIHRoZSBzZW5kZXIgYW5kIGtub3cgdGhlIGNvbnRlbnQgaXMgc2FmZS4NCj4g
DQo+IA0KPiANCj4gVGhlIGlubmVyIGxvb3AgaW4gcG9sbF9pZGxlKCkgcG9sbHMgb3ZlciB0aGUg
dGhyZWFkX2luZm8gZmxhZ3MsDQo+IHdhaXRpbmcgdG8gc2VlIGlmIHRoZSB0aHJlYWQgaGFzIFRJ
Rl9ORUVEX1JFU0NIRUQgc2V0LiBUaGUgbG9vcA0KPiBleGl0cyBvbmNlIHRoZSBjb25kaXRpb24g
aXMgbWV0LCBvciBpZiB0aGUgcG9sbCB0aW1lIGxpbWl0IGhhcw0KPiBiZWVuIGV4Y2VlZGVkLg0K
PiANCj4gVG8gbWluaW1pemUgdGhlIG51bWJlciBvZiBpbnN0cnVjdGlvbnMgZXhlY3V0ZWQgaW4g
ZWFjaCBpdGVyYXRpb24sDQo+IHRoZSB0aW1lIGNoZWNrIGlzIHJhdGUtbGltaXRlZC4gSW4gYWRk
aXRpb24sIGVhY2ggbG9vcCBpdGVyYXRpb24NCj4gZXhlY3V0ZXMgY3B1X3JlbGF4KCkgd2hpY2gg
b24gY2VydGFpbiBwbGF0Zm9ybXMgcHJvdmlkZXMgYSBoaW50IHRvDQo+IHRoZSBwaXBlbGluZSB0
aGF0IHRoZSBsb29wIGJ1c3ktd2FpdHMsIGFsbG93aW5nIHRoZSBwcm9jZXNzb3IgdG8NCj4gcmVk
dWNlIHBvd2VyIGNvbnN1bXB0aW9uLg0KPiANCj4gU3dpdGNoIG92ZXIgdG8gdGlmX25lZWRfcmVz
Y2hlZF9yZWxheGVkX3dhaXQoKSBpbnN0ZWFkLCBzaW5jZSB0aGF0DQo+IHByb3ZpZGVzIGV4YWN0
bHkgdGhhdC4NCj4gDQo+IEhvd2V2ZXIsIHNpbmNlIHdlIHdhbnQgdG8gbWluaW1pemUgcG93ZXIg
Y29uc3VtcHRpb24gaW4gaWRsZSwgYnVpbGRpbmcNCj4gb2YgY3B1aWRsZS9wb2xsX3N0YXRlLmMg
Y29udGludWVzIHRvIGRlcGVuZCBvbiBDT05GSUdfQVJDSF9IQVNfQ1BVX1JFTEFYDQo+IGFzIHRo
YXQgc2VydmVzIGFzIGFuIGluZGljYXRvciB0aGF0IHRoZSBwbGF0Zm9ybSBzdXBwb3J0cyBhbiBv
cHRpbWl6ZWQNCj4gdmVyc2lvbiBvZiB0aWZfbmVlZF9yZXNjaGVkX3JlbGF4ZWRfd2FpdCgpICh2
aWENCj4gc21wX2NvbmRfbG9hZF9hY3F1aXJlX3RpbWVvdXQoKSkuDQo+IA0KPiBDYzogUmFmYWVs
IEouIFd5c29ja2kgPHJhZmFlbEBrZXJuZWwub3JnPg0KPiBDYzogRGFuaWVsIExlemNhbm8gPGRh
bmllbC5sZXpjYW5vQGxpbmFyby5vcmc+DQo+IENjOiBsaW51eC1wbUB2Z2VyLmtlcm5lbC5vcmcN
Cj4gU3VnZ2VzdGVkLWJ5OiBSYWZhZWwgSi4gV3lzb2NraSA8cmFmYWVsQGtlcm5lbC5vcmc+DQo+
IEFja2VkLWJ5OiBSYWZhZWwgSi4gV3lzb2NraSAoSW50ZWwpIDxyYWZhZWxAa2VybmVsLm9yZz4N
Cj4gU2lnbmVkLW9mZi1ieTogQW5rdXIgQXJvcmEgPGFua3VyLmEuYXJvcmFAb3JhY2xlLmNvbT4N
Cj4gLS0tDQo+ICBkcml2ZXJzL2NwdWlkbGUvcG9sbF9zdGF0ZS5jIHwgMjEgKy0tLS0tLS0tLS0t
LS0tLS0tLS0tDQo+ICAxIGZpbGUgY2hhbmdlZCwgMSBpbnNlcnRpb24oKyksIDIwIGRlbGV0aW9u
cygtKQ0KPiANCj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvY3B1aWRsZS9wb2xsX3N0YXRlLmMgYi9k
cml2ZXJzL2NwdWlkbGUvcG9sbF9zdGF0ZS5jDQo+IGluZGV4IGM3NTI0ZTRjNTIyYS4uNzQ0M2Iz
ZTk3MWJhIDEwMDY0NA0KPiAtLS0gYS9kcml2ZXJzL2NwdWlkbGUvcG9sbF9zdGF0ZS5jDQo+ICsr
KyBiL2RyaXZlcnMvY3B1aWRsZS9wb2xsX3N0YXRlLmMNCj4gQEAgLTYsNDEgKzYsMjIgQEANCj4g
ICNpbmNsdWRlIDxsaW51eC9jcHVpZGxlLmg+DQo+ICAjaW5jbHVkZSA8bGludXgvZXhwb3J0Lmg+
DQo+ICAjaW5jbHVkZSA8bGludXgvaXJxZmxhZ3MuaD4NCj4gLSNpbmNsdWRlIDxsaW51eC9zY2hl
ZC5oPg0KPiAtI2luY2x1ZGUgPGxpbnV4L3NjaGVkL2Nsb2NrLmg+DQo+ICAjaW5jbHVkZSA8bGlu
dXgvc2NoZWQvaWRsZS5oPg0KPiAgI2luY2x1ZGUgPGxpbnV4L3NwcmludGYuaD4NCj4gICNpbmNs
dWRlIDxsaW51eC90eXBlcy5oPg0KPiANCj4gLSNkZWZpbmUgUE9MTF9JRExFX1JFTEFYX0NPVU5U
ICAyMDANCj4gLQ0KPiAgc3RhdGljIGludCBfX2NwdWlkbGUgcG9sbF9pZGxlKHN0cnVjdCBjcHVp
ZGxlX2RldmljZSAqZGV2LA0KPiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgc3RydWN0
IGNwdWlkbGVfZHJpdmVyICpkcnYsIGludCBpbmRleCkNCj4gIHsNCj4gLSAgICAgICB1NjQgdGlt
ZV9zdGFydDsNCj4gLQ0KPiAtICAgICAgIHRpbWVfc3RhcnQgPSBsb2NhbF9jbG9ja19ub2luc3Ry
KCk7DQo+IC0NCj4gICAgICAgICBkZXYtPnBvbGxfdGltZV9saW1pdCA9IGZhbHNlOw0KPiANCj4g
ICAgICAgICByYXdfbG9jYWxfaXJxX2VuYWJsZSgpOw0KPiAgICAgICAgIGlmICghY3VycmVudF9z
ZXRfcG9sbGluZ19hbmRfdGVzdCgpKSB7DQo+IC0gICAgICAgICAgICAgICB1bnNpZ25lZCBpbnQg
bG9vcF9jb3VudCA9IDA7DQo+ICAgICAgICAgICAgICAgICB1NjQgbGltaXQ7DQo+IA0KPiAgICAg
ICAgICAgICAgICAgbGltaXQgPSBjcHVpZGxlX3BvbGxfdGltZShkcnYsIGRldik7DQo+IA0KPiAt
ICAgICAgICAgICAgICAgd2hpbGUgKCFuZWVkX3Jlc2NoZWQoKSkgew0KPiAtICAgICAgICAgICAg
ICAgICAgICAgICBjcHVfcmVsYXgoKTsNCj4gLSAgICAgICAgICAgICAgICAgICAgICAgaWYgKGxv
b3BfY291bnQrKyA8IFBPTExfSURMRV9SRUxBWF9DT1VOVCkNCj4gLSAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICBjb250aW51ZTsNCj4gLQ0KPiAtICAgICAgICAgICAgICAgICAgICAgICBs
b29wX2NvdW50ID0gMDsNCj4gLSAgICAgICAgICAgICAgICAgICAgICAgaWYgKGxvY2FsX2Nsb2Nr
X25vaW5zdHIoKSAtIHRpbWVfc3RhcnQgPiBsaW1pdCkgew0KPiAtICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgIGRldi0+cG9sbF90aW1lX2xpbWl0ID0gdHJ1ZTsNCj4gLSAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICBicmVhazsNCj4gLSAgICAgICAgICAgICAgICAgICAgICAgfQ0K
PiAtICAgICAgICAgICAgICAgfQ0KPiArICAgICAgICAgICAgICAgZGV2LT5wb2xsX3RpbWVfbGlt
aXQgPSAhdGlmX25lZWRfcmVzY2hlZF9yZWxheGVkX3dhaXQobGltaXQpOw0KPiAgICAgICAgIH0N
Cj4gICAgICAgICByYXdfbG9jYWxfaXJxX2Rpc2FibGUoKTsNCj4gDQo+IC0tDQo+IDIuMzEuMQ0K
PiANCg0KSGkgQW5rdXIsDQoNClRlc3RlZCBhdG9wIGxhdGVzdCBtYWlubGluZSBkNjBiYzE0MDEg
d2l0aCB0aGUgcmVzdCBvZiB5b3VyIGhhbHRwb2xsDQpjaGFuZ2VzIGZyb20gc2VwYXJhdGUgdGhy
ZWFkOg0KfjEwJSBpbXByb3ZlbWVudCBpbiBgcGVyZiBzY2hlZCBiZW5jaCBwaXBlYCBtaWNybyBh
bmQgfjQtNiUgdGhyb3VnaHB1dA0KaW1wcm92ZW1lbnRzIGluIG15c3FsLA0KcG9zdGdyZXNxbCwg
Y2Fzc2FuZHJhLCBhbmQgbWVtY2FjaGVkIGluIHVuZGVyLWxvYWRlZCBjb25maWd1cmF0aW9ucy4N
ClRlc3RlZCBvbiBBV1MgR3Jhdml0b24zIGFuZA0KR3Jhdml0b240LCBBUk0gTmVvdmVyc2UgVjEg
YW5kIFYyIGNvcmVzIHJlc3BlY3RpdmVseS4NCg0KSSBob3BlIHRoaXMgc2VyaWVzIGNhbiBtZXJn
ZSBzb29uLiBJdCdzIGJlZW4gc3R1Y2sgaW4gcmV2aWV3IGZvciBtb3JlDQp0aGFuIDIgeWVhcnMu
DQoNClRlc3RlZC1ieTogSGFyaXMgT2thbm92aWMgPGhhcmlzb2tuQGFtYXpvbi5jb20+DQoNClJl
Z2FyZHMsDQpIYXJpcyBPa2Fub3ZpYw0KQVdTIEdyYXZpdG9uIFNvZnR3YXJlDQoNCg==
