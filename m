Received: from pdx-out-001.esa.us-west-2.outbound.mail-perimeter.amazon.com (pdx-out-001.esa.us-west-2.outbound.mail-perimeter.amazon.com [44.245.243.92])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4ED8730DD1D;
	Fri, 24 Apr 2026 14:10:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=44.245.243.92
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777039831; cv=none; b=np+zQGOF98jonkp2E5Sdei109AMeZKiYLoZfR65ZvUm3Za939NdliRXiyDA/NWYOb8T5xo+apEYjdlqaUxLALiWmrIcX6ARuBYGs9A0yiKMT8erKVDQ5jPcp6+kciTBIcHPyyz9mEJQtp2pNid/MJR0JLPaYwvBjjW8jx+myjZA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777039831; c=relaxed/simple;
	bh=qgh3lJ+CjSPZqoH8RyKa1iBeGdTFbSZMbm/9a72fgmI=;
	h=Subject:From:To:CC:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=dLjBaW1AJBFa3WEufwFEhwgstHYCgE83lRwvThJRkI8j53P1HTQQa3jI4nBztJNeMaZ1Tfz9g0fPPZVNXT8SEziReibXBG8t3uZcnpTZTXprYFLJG75TjJv5w0JYnu7NxfF5q4ggjKEfOW/WNW63oCgunVwXvyZtmEXmMVirNwk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.com; dkim=pass (2048-bit key) header.d=amazon.com header.i=@amazon.com header.b=boDV7M1f; arc=none smtp.client-ip=44.245.243.92
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amazon.com header.i=@amazon.com header.b="boDV7M1f"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazoncorp2;
  t=1777039830; x=1808575830;
  h=from:to:cc:date:message-id:references:in-reply-to:
   content-id:content-transfer-encoding:mime-version:subject;
  bh=qgh3lJ+CjSPZqoH8RyKa1iBeGdTFbSZMbm/9a72fgmI=;
  b=boDV7M1f0EO6qJ7HS2YyddjR2Eh07NOQqHmcjB73kq1nrCq13z7QolzA
   s2M8u3+tq/W4huVIx/3g2IRbBWdQAldIZ4j7UPDhuh8/1XfInYhY61AnL
   LSwyHBqRDPHhrKxBQ79Ra9otmVuTCMhZZi+AoE8umLv4s/WP/QpYSljbw
   N/S8unXmKCXlPo3vL1L4VSQqInbTs2roedYizISoLSPZHnt/57mQKnrep
   8blJ1HWGjOO5baDSFEu2SJTVlNQYhhKWRdY/YcWC6Y7kXSaQrEpM3IMLf
   e6HAHmps7acsLFFo2NNnueZLmoVlGHPzCO5tsWCwXULgvWKlSaN1YULMn
   w==;
X-CSE-ConnectionGUID: 15NWk7qiQ2SUfTB3+sLZKw==
X-CSE-MsgGUID: yfeYcnHuRXmiHRu96Pwy1w==
X-IronPort-AV: E=Sophos;i="6.23,196,1770595200"; 
   d="scan'208";a="17646447"
Subject: Re: [PATCH v11 00/14] barrier: Add smp_cond_load_{relaxed, acquire}_timeout()
Thread-Topic: [PATCH v11 00/14] barrier: Add smp_cond_load_{relaxed, acquire}_timeout()
Received: from ip-10-5-6-203.us-west-2.compute.internal (HELO smtpout.naws.us-west-2.prod.farcaster.email.amazon.dev) ([10.5.6.203])
  by internal-pdx-out-001.esa.us-west-2.outbound.mail-perimeter.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Apr 2026 14:10:30 +0000
Received: from EX19MTAUWB002.ant.amazon.com [205.251.233.48:14253]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.27.2:2525] with esmtp (Farcaster)
 id ac603786-d141-4164-ac94-10c72085e656; Fri, 24 Apr 2026 14:10:29 +0000 (UTC)
X-Farcaster-Flow-ID: ac603786-d141-4164-ac94-10c72085e656
Received: from EX19D032UWA001.ant.amazon.com (10.13.139.62) by
 EX19MTAUWB002.ant.amazon.com (10.250.64.231) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.37;
 Fri, 24 Apr 2026 14:10:28 +0000
Received: from EX19D032UWA003.ant.amazon.com (10.13.139.37) by
 EX19D032UWA001.ant.amazon.com (10.13.139.62) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.37;
 Fri, 24 Apr 2026 14:10:28 +0000
Received: from EX19D032UWA003.ant.amazon.com ([fe80::8e94:8f60:9531:c497]) by
 EX19D032UWA003.ant.amazon.com ([fe80::8e94:8f60:9531:c497%5]) with mapi id
 15.02.2562.037; Fri, 24 Apr 2026 14:10:28 +0000
From: "Okanovic, Haris" <harisokn@amazon.com>
To: "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
	"ankur.a.arora@oracle.com" <ankur.a.arora@oracle.com>
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
Thread-Index: AQHcx1Lc+RjIJDvKCE+BAEcv9rf8TbXs+zWAgAFeVwA=
Date: Fri, 24 Apr 2026 14:10:28 +0000
Message-ID: <5e8ef9d2bd0b3356e37e6a982d04d2d993c8a88f.camel@amazon.com>
References: <20260408122538.3610871-1-ankur.a.arora@oracle.com>
	 <20260423101631.84f26592d629eee46fbde6f8@linux-foundation.org>
In-Reply-To: <20260423101631.84f26592d629eee46fbde6f8@linux-foundation.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
Content-Type: text/plain; charset="utf-8"
Content-ID: <D1A45CAF790C394AA6EF3536E4EF9861@amazon.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

T24gVGh1LCAyMDI2LTA0LTIzIGF0IDEwOjE2IC0wNzAwLCBBbmRyZXcgTW9ydG9uIHdyb3RlOg0K
PiBDQVVUSU9OOiBUaGlzIGVtYWlsIG9yaWdpbmF0ZWQgZnJvbSBvdXRzaWRlIG9mIHRoZSBvcmdh
bml6YXRpb24uIERvIG5vdCBjbGljayBsaW5rcyBvciBvcGVuIGF0dGFjaG1lbnRzIHVubGVzcyB5
b3UgY2FuIGNvbmZpcm0gdGhlIHNlbmRlciBhbmQga25vdyB0aGUgY29udGVudCBpcyBzYWZlLg0K
PiANCj4gDQo+IA0KPiBPbiBXZWQsICA4IEFwciAyMDI2IDE3OjU1OjI0ICswNTMwIEFua3VyIEFy
b3JhIDxhbmt1ci5hLmFyb3JhQG9yYWNsZS5jb20+IHdyb3RlOg0KPiANCj4gPiBUaGUgY29yZSBr
ZXJuZWwgb2Z0ZW4gdXNlcyBzbXBfY29uZF9sb2FkX3tyZWxheGVkLGFjcXVpcmV9KCkgdG8gc3Bp
bg0KPiA+IG9uIGNvbmRpdGlvbiB2YXJpYWJsZXMgd2l0aCBhcmNoaXRlY3R1cmFsIHByaW1pdGl2
ZXMgdXNlZCB0byBhdm9pZA0KPiA+IGhhbW1lcmluZyB0aGUgcmVsZXZhbnQgY2FjaGVsaW5lcy4N
Cj4gPiANCj4gPiAuLi4NCj4gPiANCj4gPiBBY2NvcmRpbmdseSBhZGQgdHdvIGludGVyZmFjZXMg
KHdpdGggdGhlaXIgZ2VuZXJpYyBhbmQgYXJtNjQgc3BlY2lmaWMNCj4gPiBpbXBsZW1lbnRhdGlv
bnMpOg0KPiA+IA0KPiA+ICAgIHNtcF9jb25kX2xvYWRfcmVsYXhlZF90aW1lb3V0KHB0ciwgY29u
ZF9leHByLCB0aW1lX2V4cHIsIHRpbWVvdXQpDQo+ID4gICAgc21wX2NvbmRfbG9hZF9hY3F1aXJl
X3RpbWVvdXQocHRyLCBjb25kX2V4cHIsIHRpbWVfZXhwciwgdGltZW91dCkNCj4gPiANCj4gPiBB
bHNvIGFkZCB0aWZfbmVlZF9yZXNjaGVkX3JlbGF4ZWRfd2FpdCgpIHdoaWNoIHdyYXBzIHRoZSBw
b2xsaW5nDQo+ID4gcGF0dGVybiBhbmQgaXRzIHNjaGVkdWxlciBzcGVjaWZpYyBkZXRhaWxzIGlu
IHBvbGxfaWRsZSgpLg0KPiA+IEluIGFkZGl0aW9uIGFkZCBhdG9taWNfY29uZF9yZWFkXypfdGlt
ZW91dCgpLA0KPiANCj4gVGhhbmtzLCBJJ2xsIGFkZCB0aGlzIHRvIG1tLmdpdCdzIG1tLW5ldyBi
cmFuY2ggdG9kYXkuDQoNClRoYXQncyBncmVhdCBuZXdzISBUaGFua3MgZm9yIGp1bXBpbmcgaW4g
dG8gbW92ZSB0aGlzIGZvcndhcmQuDQoNCj4gDQo+IFRoaXMgaXNuJ3QgYW0gTU0gcGF0Y2hzZXQs
IGJ1dCBtbS1uZXcgaXNuJ3QgaW5jbHVkZWQgaW4gbGludXgtbmV4dCwgYW5kDQo+IGxpbnV4LW5l
eHQgaXNuJ3QgcHJlc2VudGx5IG9wZW4gZm9yIDcuMSBtYXRlcmlhbC4NCj4gDQo+IEFmdGVyIC1y
YzEgSSdsbCBtb3ZlIHRoZSBzZXJpZXMgaW50byBtbS5naXQncyBtbS1ub25tbS11bnN0YWJsZSBi
cmFuY2gsDQo+IHdoZXJlIGl0IHdpbGwgZ2V0IGxpbnV4LW5leHQgZXhwb3N1cmUuDQo+IA0KPiBJ
IHNlZSB0aGF0IGZ1cnRoZXIgcmV2aWV3L2NvbW1lbnQgaGFzIGJlZW4gcmVxdWVzdGVkIC0gaG9w
ZWZ1bGx5IHRoaXMNCj4gd2lsbCBoYXBwZW4gb3ZlciB0aGUgbmV4dCBjb3VwbGUgb2YgbW9udGhz
LCBidXQgcGxlYXNlIGRvIGNvbnRpbnVlIHRvDQo+IGNoYXNlIHRoaXMgZG93biBpZiB5b3UgZmVl
bCB0aGUgbmVlZC4NCj4gDQo+ID4gSGFyaXMgT2thbm92aWMgYWxzbyBzYXcgaW1wcm92ZW1lbnQg
aW4gcmVhbCB3b3JrbG9hZHMgZHVlIHRvIHRoZQ0KPiA+IGNwdWlkbGUgY2hhbmdlczogIm9ic2Vy
dmVkIDQtNiUgaW1wcm92ZW1lbnRzIGluIG1lbWNhaGVkLCBjYXNzYW5kcmEsDQo+ID4gbXlzcWws
IGFuZCBwb3N0Z3Jlc3FsIHVuZGVyIGNlcnRhaW4gbG9hZHMuIE90aGVyIGFwcGxpY2F0aW9ucyBs
aWtlbHkNCj4gPiBiZW5lZml0IHRvby4iIFsxMl0NCj4gDQo+IFRob3NlIGFyZSBzaWduaWZpY2Fu
dCBpbXByb3ZlbWVudHMuICAgVGhyZWUgeWVhcnMgOigNCg0KUmVnYXJkcywNCkhhcmlzIE9rYW5v
dmljDQpBV1MgR3Jhdml0b24gU29mdHdhcmUNCg0K
