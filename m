Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from dc8-smtprelay2.synopsys.com ([198.182.47.102]:49872 "EHLO
        smtprelay-out1.synopsys.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725921AbfFTSeg (ORCPT
        <rfc822;linux-arch@vger.kernel.org>);
        Thu, 20 Jun 2019 14:34:36 -0400
From: Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>
Subject: Re: [PATCH] ARC: ARCv2: jump label: implement jump label patching
Date: Thu, 20 Jun 2019 18:34:29 +0000
Message-ID: <50a5120f512e7d6784efa403a7597c159074c8c1.camel@synopsys.com>
References: <20190614164049.31626-1-Eugeniy.Paltsev@synopsys.com>
         <C2D7FE5348E1B147BCA15975FBA2307501A252CCC3@us01wembx1.internal.synopsys.com>
         <20190619081227.GL3419@hirez.programming.kicks-ass.net>
In-Reply-To: <20190619081227.GL3419@hirez.programming.kicks-ass.net>
Content-Language: en-US
Content-Type: text/plain; charset="utf-8"
Content-ID: <B216DBA167D5AE4C97B8EDFB30EA7A2F@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: "peterz@infradead.org" <peterz@infradead.org>, "Vineet.Gupta1@synopsys.com" <Vineet.Gupta1@synopsys.com>
Cc: "jbaron@redhat.com" <jbaron@redhat.com>, "linux-snps-arc@lists.infradead.org" <linux-snps-arc@lists.infradead.org>, Alexey Brodkin <Alexey.Brodkin@synopsys.com>, "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "Eugeniy.Paltsev@synopsys.com" <Eugeniy.Paltsev@synopsys.com>, "pbonzini@redhat.com" <pbonzini@redhat.com>, "ard.biesheuvel@linaro.org" <ard.biesheuvel@linaro.org>
Message-ID: <20190620183429.5dLOGHkhBK9mCN9WtW_qZoRfnHx0LBjHpV4PrWeXCZA@z>

SGkgUGV0ZXIsDQoNCk9uIFdlZCwgMjAxOS0wNi0xOSBhdCAxMDoxMiArMDIwMCwgUGV0ZXIgWmlq
bHN0cmEgd3JvdGU6DQo+IE9uIFR1ZSwgSnVuIDE4LCAyMDE5IGF0IDA0OjE2OjIwUE0gKzAwMDAs
IFZpbmVldCBHdXB0YSB3cm90ZToNCj4gDQo+ID4gPiArLyoNCj4gPiA+ICsgKiBUbyBtYWtlIGF0
b21pYyB1cGRhdGUgb2YgcGF0Y2hlZCBpbnN0cnVjdGlvbiBhdmFpbGFibGUgd2UgbmVlZCB0byBn
dWFyYW50ZWUNCj4gPiA+ICsgKiB0aGF0IHRoaXMgaW5zdHJ1Y3Rpb24gZG9lc24ndCBjcm9zcyBM
MSBjYWNoZSBsaW5lIGJvdW5kYXJ5Lg0KPiA+ID4gKyAqDQo+IA0KPiBPaCB1cmdoLiBJcyB0aGF0
IHRoZSBvbmx5IHdheSBBUkMgY2FuIGRvIHRleHQgcGF0Y2hpbmc/IFdlJ3ZlIGFjdHVhbGx5DQo+
IGNvbnNpZGVyZWQgc29tZXRoaW5nIGxpa2UgdGhpcyBvbiB4ODYgYXQgc29tZSBwb2ludCwgYnV0
IHRoZXJlIHdlIGhhdmUNCj4gdGhlICdmdW4nIGRldGFpbCB0aGF0IHRoZSBpLWZldGNoIHdpbmRv
dyBkb2VzIG5vdCBpbiBmYWN0IGFsaWduIHdpdGggTDENCj4gc2l6ZSBvbiBhbGwgdWFyY2hzLCBz
byB0aGF0IGdvdCBjb21wbGljYXRlZCByZWFsIGZhc3QuDQo+IA0KPiBJJ20gYXNzdW1pbmcgeW91
J3ZlIGxvb2tlZCBhdCB3aGF0IHg4NiBjdXJyZW50bHkgZG9lcyBhbmQgZm91bmQNCj4gc29tZXRo
aW5nIGxpa2UgdGhhdCBkb2Vzbid0IHdvcmsgZm9yIEFSQz8NCg0KVG8gYmUgaG9uZXN0IEkndmUg
bW9zdGx5IGxvb2sgYXQgYXJtL2FybTY0IGltcGxlbWVudGF0aW9uIDopDQoNCkJ1dCB5ZWFoIGl0
J3MgZ29vZCByZW1hcmsgYWJvdXQgaS1mZXRjaCB3aW5kb3cuDQpJdCdzIG5hbWVkICdpbnN0cnVj
dGlvbl9mZXRjaF9ibG9ja193aWR0aCcgaW4gQVJDIGRvY3VtZW50YXRpb24gYW5kIGl0J3MNCnNt
YWxsZXIgdGhhbiBMMSBJJCBsaW5lIHNpemUuIE9uIEFSQ3YyIGl0J3MgMTYgYnl0ZS4NClNvIGlu
IGN1cnJlbnQgaW1wbGVtZW50YXRpb24gd2UgbmVlZCB0byBndWFyYW50ZWUgdGhhdCB0aGlzIGlu
c3RydWN0aW9uIGRvZXNuJ3QNCmNyb3NzICdpbnN0cnVjdGlvbl9mZXRjaF9ibG9jaycgYW5kIG5v
dCBMMSBjYWNoZSBsaW5lIGJvdW5kYXJ5Lg0KDQpTbyB0aGVyZSBpcyBubyBwcm9ibGVtIHdpdGgg
dGhpcyBjb2RlIGl0c2VsZiBidXQgdGhlIGNvbW1lbnQgc2hvdWxkIGJlIGZpeGVkLg0KDQpbc25p
cF0NCi0tIA0KIEV1Z2VuaXkgUGFsdHNldg0K
