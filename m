Received: from pdx-out-007.esa.us-west-2.outbound.mail-perimeter.amazon.com (pdx-out-007.esa.us-west-2.outbound.mail-perimeter.amazon.com [52.34.181.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 551E83C3439;
	Fri, 24 Apr 2026 14:16:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=52.34.181.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777040215; cv=none; b=JCDunvrpcUUNmuzWimxHkiD+7mYknHQl6qIBOiuWAaPmKeLDSYUFTIaTssE7OjRLHmP2wGd+E4aA8KEfR0c35xebkbxCTuYt7g4z7fDIeUa0zgSXKvgaU/tK0oyHffFr4zx/p6UiHKIfQ5WdcURU+GsAHlQUK+QebDrFcrNqn3E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777040215; c=relaxed/simple;
	bh=2AQqwQ/V3YeN+sSc5aDTpnwZegrT6zJu/UnKOSH329Y=;
	h=Subject:From:To:CC:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=NirYHAIVs0QbPjJ7p9c3Ekwt31+b9yc92N6OdTZbNXaPO/V64L3yafRtfd33m4u68kx2Py6pTvVsoLpXLoq4ifdi/dxY+laOf2Czyk1oqULHozjl/PuaclO2AMVlVqU8ZKWXC2NkN0DdnY7IZIrdRM5M20jpbWBUMX7RK1ZzsK0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.com; dkim=pass (2048-bit key) header.d=amazon.com header.i=@amazon.com header.b=OWLCs8/3; arc=none smtp.client-ip=52.34.181.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amazon.com header.i=@amazon.com header.b="OWLCs8/3"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazoncorp2;
  t=1777040214; x=1808576214;
  h=from:to:cc:date:message-id:references:in-reply-to:
   content-id:content-transfer-encoding:mime-version:subject;
  bh=2AQqwQ/V3YeN+sSc5aDTpnwZegrT6zJu/UnKOSH329Y=;
  b=OWLCs8/3EVfbW6N1KGSQASR59wpLfV0hfSDTtt0cnI8u21+priIh04sf
   wwYqNErGHCYmVApqW7F+kOGrunAaposYzScn6o+ybgN1FyT19HCtyLRCW
   PhRBHM/AoUssiZYH2exuUHlW+TukkfGfqwebWdwZetHgXt+4mbDUjzgXB
   UdB2eNsbbvhBC8+So4pXg7XLPoHXR9LMLbYmy4TewalSGpLQmrz8TeajR
   ZaTAKW/jRIUOFpZF5CDHRp1WPDOJ849q+gKXmYhJSBHzYMLM4x1XpyjtG
   OhUuTCdbvyO3QeeM1Sq1Ae1lH6Se0cvhUZBLm0ZqMhJJ8G+Xb6gPXyHDK
   w==;
X-CSE-ConnectionGUID: g2tXSHC9T4u1ZyPhFZy82A==
X-CSE-MsgGUID: +M25bqO3QTW5soUIw61HcQ==
X-IronPort-AV: E=Sophos;i="6.23,196,1770595200"; 
   d="scan'208";a="18113629"
Subject: Re: [PATCH v11 00/14] barrier: Add smp_cond_load_{relaxed, acquire}_timeout()
Thread-Topic: [PATCH v11 00/14] barrier: Add smp_cond_load_{relaxed, acquire}_timeout()
Received: from ip-10-5-12-219.us-west-2.compute.internal (HELO smtpout.naws.us-west-2.prod.farcaster.email.amazon.dev) ([10.5.12.219])
  by internal-pdx-out-007.esa.us-west-2.outbound.mail-perimeter.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Apr 2026 14:16:53 +0000
Received: from EX19MTAUWB001.ant.amazon.com [205.251.233.51:11239]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.41.10:2525] with esmtp (Farcaster)
 id fb967a1b-c42c-4869-b791-e23549861e76; Fri, 24 Apr 2026 14:16:53 +0000 (UTC)
X-Farcaster-Flow-ID: fb967a1b-c42c-4869-b791-e23549861e76
Received: from EX19D032UWA004.ant.amazon.com (10.13.139.56) by
 EX19MTAUWB001.ant.amazon.com (10.250.64.248) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.37;
 Fri, 24 Apr 2026 14:16:53 +0000
Received: from EX19D032UWA003.ant.amazon.com (10.13.139.37) by
 EX19D032UWA004.ant.amazon.com (10.13.139.56) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.37;
 Fri, 24 Apr 2026 14:16:53 +0000
Received: from EX19D032UWA003.ant.amazon.com ([fe80::8e94:8f60:9531:c497]) by
 EX19D032UWA003.ant.amazon.com ([fe80::8e94:8f60:9531:c497%5]) with mapi id
 15.02.2562.037; Fri, 24 Apr 2026 14:16:52 +0000
From: "Okanovic, Haris" <harisokn@amazon.com>
To: "ankur.a.arora@oracle.com" <ankur.a.arora@oracle.com>,
	"akpm@linux-foundation.org" <akpm@linux-foundation.org>
CC: "joao.m.martins@oracle.com" <joao.m.martins@oracle.com>,
	"xueshuai@linux.alibaba.com" <xueshuai@linux.alibaba.com>,
	"david.laight.linux@gmail.com" <david.laight.linux@gmail.com>,
	"boris.ostrovsky@oracle.com" <boris.ostrovsky@oracle.com>, "memxor@gmail.com"
	<memxor@gmail.com>, "ashok.bhat@arm.com" <ashok.bhat@arm.com>,
	"zhenglifeng1@huawei.com" <zhenglifeng1@huawei.com>, "konrad.wilk@oracle.com"
	<konrad.wilk@oracle.com>, "cl@gentwo.org" <cl@gentwo.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"catalin.marinas@arm.com" <catalin.marinas@arm.com>, "ast@kernel.org"
	<ast@kernel.org>, "rdunlap@infradead.org" <rdunlap@infradead.org>,
	"daniel.lezcano@linaro.org" <daniel.lezcano@linaro.org>,
	"linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>, "arnd@arndb.de"
	<arnd@arndb.de>, "will@kernel.org" <will@kernel.org>, "mark.rutland@arm.com"
	<mark.rutland@arm.com>, "peterz@infradead.org" <peterz@infradead.org>,
	"bpf@vger.kernel.org" <bpf@vger.kernel.org>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "Okanovic, Haris"
	<harisokn@amazon.com>, "rafael@kernel.org" <rafael@kernel.org>,
	"linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>
Thread-Index: AQHcx1Lc+RjIJDvKCE+BAEcv9rf8TbXs+zWAgAAlMoCAATrtgA==
Date: Fri, 24 Apr 2026 14:16:52 +0000
Message-ID: <7cd318985eebc0f068dcb77b07eab150d893b70d.camel@amazon.com>
References: <20260408122538.3610871-1-ankur.a.arora@oracle.com>
	 <20260423101631.84f26592d629eee46fbde6f8@linux-foundation.org>
	 <87tst1fpb0.fsf@oracle.com>
In-Reply-To: <87tst1fpb0.fsf@oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
Content-Type: text/plain; charset="utf-8"
Content-ID: <948A79D88771E846BD3132ACF440F1C9@amazon.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

T24gVGh1LCAyMDI2LTA0LTIzIGF0IDEyOjI5IC0wNzAwLCBBbmt1ciBBcm9yYSB3cm90ZToNCj4g
Q0FVVElPTjogVGhpcyBlbWFpbCBvcmlnaW5hdGVkIGZyb20gb3V0c2lkZSBvZiB0aGUgb3JnYW5p
emF0aW9uLiBEbyBub3QgY2xpY2sgbGlua3Mgb3Igb3BlbiBhdHRhY2htZW50cyB1bmxlc3MgeW91
IGNhbiBjb25maXJtIHRoZSBzZW5kZXIgYW5kIGtub3cgdGhlIGNvbnRlbnQgaXMgc2FmZS4NCj4g
DQo+IA0KPiANCj4gQW5kcmV3IE1vcnRvbiA8YWtwbUBsaW51eC1mb3VuZGF0aW9uLm9yZz4gd3Jp
dGVzOg0KPiANCj4gPiBPbiBXZWQsICA4IEFwciAyMDI2IDE3OjU1OjI0ICswNTMwIEFua3VyIEFy
b3JhIDxhbmt1ci5hLmFyb3JhQG9yYWNsZS5jb20+IHdyb3RlOg0KPiA+IA0KPiA+ID4gVGhlIGNv
cmUga2VybmVsIG9mdGVuIHVzZXMgc21wX2NvbmRfbG9hZF97cmVsYXhlZCxhY3F1aXJlfSgpIHRv
IHNwaW4NCj4gPiA+IG9uIGNvbmRpdGlvbiB2YXJpYWJsZXMgd2l0aCBhcmNoaXRlY3R1cmFsIHBy
aW1pdGl2ZXMgdXNlZCB0byBhdm9pZA0KPiA+ID4gaGFtbWVyaW5nIHRoZSByZWxldmFudCBjYWNo
ZWxpbmVzLg0KPiA+ID4gDQo+ID4gPiAuLi4NCj4gPiA+IA0KPiA+ID4gQWNjb3JkaW5nbHkgYWRk
IHR3byBpbnRlcmZhY2VzICh3aXRoIHRoZWlyIGdlbmVyaWMgYW5kIGFybTY0IHNwZWNpZmljDQo+
ID4gPiBpbXBsZW1lbnRhdGlvbnMpOg0KPiA+ID4gDQo+ID4gPiAgICBzbXBfY29uZF9sb2FkX3Jl
bGF4ZWRfdGltZW91dChwdHIsIGNvbmRfZXhwciwgdGltZV9leHByLCB0aW1lb3V0KQ0KPiA+ID4g
ICAgc21wX2NvbmRfbG9hZF9hY3F1aXJlX3RpbWVvdXQocHRyLCBjb25kX2V4cHIsIHRpbWVfZXhw
ciwgdGltZW91dCkNCj4gPiA+IA0KPiA+ID4gQWxzbyBhZGQgdGlmX25lZWRfcmVzY2hlZF9yZWxh
eGVkX3dhaXQoKSB3aGljaCB3cmFwcyB0aGUgcG9sbGluZw0KPiA+ID4gcGF0dGVybiBhbmQgaXRz
IHNjaGVkdWxlciBzcGVjaWZpYyBkZXRhaWxzIGluIHBvbGxfaWRsZSgpLg0KPiA+ID4gSW4gYWRk
aXRpb24gYWRkIGF0b21pY19jb25kX3JlYWRfKl90aW1lb3V0KCksDQo+ID4gDQo+ID4gVGhhbmtz
LCBJJ2xsIGFkZCB0aGlzIHRvIG1tLmdpdCdzIG1tLW5ldyBicmFuY2ggdG9kYXkuDQo+IA0KPiBH
cmVhdC4gVGhhbmtzIQ0KPiANCj4gPiBUaGlzIGlzbid0IGFtIE1NIHBhdGNoc2V0LCBidXQgbW0t
bmV3IGlzbid0IGluY2x1ZGVkIGluIGxpbnV4LW5leHQsIGFuZA0KPiA+IGxpbnV4LW5leHQgaXNu
J3QgcHJlc2VudGx5IG9wZW4gZm9yIDcuMSBtYXRlcmlhbC4NCj4gPiANCj4gPiBBZnRlciAtcmMx
IEknbGwgbW92ZSB0aGUgc2VyaWVzIGludG8gbW0uZ2l0J3MgbW0tbm9ubW0tdW5zdGFibGUgYnJh
bmNoLA0KPiA+IHdoZXJlIGl0IHdpbGwgZ2V0IGxpbnV4LW5leHQgZXhwb3N1cmUuDQo+IA0KPiBB
Y2sgdGhhdC4NCj4gDQo+ID4gSSBzZWUgdGhhdCBmdXJ0aGVyIHJldmlldy9jb21tZW50IGhhcyBi
ZWVuIHJlcXVlc3RlZCAtIGhvcGVmdWxseSB0aGlzDQo+ID4gd2lsbCBoYXBwZW4gb3ZlciB0aGUg
bmV4dCBjb3VwbGUgb2YgbW9udGhzLCBidXQgcGxlYXNlIGRvIGNvbnRpbnVlIHRvDQo+ID4gY2hh
c2UgdGhpcyBkb3duIGlmIHlvdSBmZWVsIHRoZSBuZWVkLg0KPiANCj4gV2lsbCBkby4NCj4gDQo+
ID4gPiBIYXJpcyBPa2Fub3ZpYyBhbHNvIHNhdyBpbXByb3ZlbWVudCBpbiByZWFsIHdvcmtsb2Fk
cyBkdWUgdG8gdGhlDQo+ID4gPiBjcHVpZGxlIGNoYW5nZXM6ICJvYnNlcnZlZCA0LTYlIGltcHJv
dmVtZW50cyBpbiBtZW1jYWhlZCwgY2Fzc2FuZHJhLA0KPiA+ID4gbXlzcWwsIGFuZCBwb3N0Z3Jl
c3FsIHVuZGVyIGNlcnRhaW4gbG9hZHMuIE90aGVyIGFwcGxpY2F0aW9ucyBsaWtlbHkNCj4gPiA+
IGJlbmVmaXQgdG9vLiIgWzEyXQ0KPiA+IA0KPiA+IFRob3NlIGFyZSBzaWduaWZpY2FudCBpbXBy
b3ZlbWVudHMuICAgVGhyZWUgeWVhcnMgOigNCj4gDQo+IFBhcnQgb2YgdGhlIHJlYXNvbiB3YXMg
dGhhdCB0aGUgYmFycmllciBpbnRlcmZhY2Ugd2FzIHBhcnQgb2YgYSBzZXJpZXMNCj4gZm9jdXNl
ZCBvbiB2aXJ0dWFsaXphdGlvbiB2aWEgY3B1aWRsZS1oYWx0cG9sbC4gQXMgdGhhdCB3YXMgcmV2
aWV3ZWQsDQo+IHRoZSB0YWxlIGNoYW5nZWQgaW4gdGhlIHRlbGxpbmcsIGFuZCBpdCBtYWRlIG1v
cmUgc2Vuc2UgdG8gc2VwYXJhdGUNCj4gdGhlIHR3by4NCj4gDQo+IFdpbGwgc2VuZCBvdXQgdGhl
IGNwdWlkbGUgY2hhbmdlcyBmb3IgcmV2aWV3IHdoaWNoIEhhcmlzIGlzIHJ1bm5pbmcNCj4gd2l0
aC4NCg0KSXQgbmVlZHMgc29tZSBtaW5vciByZWZhY3RvcnMgZm9yIGxhdGVzdCBtYWludGFpbi4N
Cg0KVGhpcyBpcyB3aGF0IEkgdGVzdGVkIGxhc3Qgd2VlazoNCmh0dHBzOi8vZ2l0aHViLmNvbS9o
YXJpc29rYW5vdmljL2xpbnV4L3RyZWUvZGV2L2hhcmlzb2tuL2FybS1oYWx0cG9sbC0yMDI2LWFw
cmlsLXRlc3QNCg0KPiANCj4gLS0NCj4gYW5rdXINCg0KUmVnYXJkcywNCkhhcmlzIE9rYW5vdmlj
DQpBV1MgR3Jhdml0b24gU29mdHdhcmUNCg0K
