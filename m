Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from smtprelay2.synopsys.com ([198.182.60.111]:50988 "EHLO
        smtprelay.synopsys.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932899AbeGIOHy (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 9 Jul 2018 10:07:54 -0400
From: Alexey Brodkin <Alexey.Brodkin@synopsys.com>
Subject: Re: [PATCH v3] devres: Explicitly align datai[] to 64-bit
Date: Mon, 9 Jul 2018 14:07:50 +0000
Message-ID: <6da84ff10e7b34f1b08ac26136aaa325fb91a440.camel@synopsys.com>
References: <20180709134550.29541-1-abrodkin@synopsys.com>
         <20180709135409.GQ2476@hirez.programming.kicks-ass.net>
In-Reply-To: <20180709135409.GQ2476@hirez.programming.kicks-ass.net>
Content-Language: en-US
Content-Type: text/plain; charset="utf-8"
Content-ID: <01B5E02333E9D04C9B8D9EBE036739E8@internal.synopsys.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: "peterz@infradead.org" <peterz@infradead.org>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "tglx@linutronix.de" <tglx@linutronix.de>, "linux-snps-arc@lists.infradead.org" <linux-snps-arc@lists.infradead.org>, "stable@vger.kernel.org" <stable@vger.kernel.org>, "daniel.vetter@intel.com" <daniel.vetter@intel.com>, "airlied@redhat.com" <airlied@redhat.com>, "greg@kroah.com" <greg@kroah.com>, "will.deacon@arm.com" <will.deacon@arm.com>, "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>, "David.Laight@ACULAB.COM" <David.Laight@ACULAB.COM>, "l.stach@pengutronix.de" <l.stach@pengutronix.de>, "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>, "geert@linux-m68k.org" <geert@linux-m68k.org>
Message-ID: <20180709140750.zlO7r6wZi9f1KSIITP0r0kT8M6FzXBfR2VHwgi9Pyi8@z>

SGkgUGV0ZXIsDQoNCk9uIE1vbiwgMjAxOC0wNy0wOSBhdCAxNTo1NCArMDIwMCwgUGV0ZXIgWmlq
bHN0cmEgd3JvdGU6DQo+IE9uIE1vbiwgSnVsIDA5LCAyMDE4IGF0IDA0OjQ1OjUwUE0gKzAzMDAs
IEFsZXhleSBCcm9ka2luIHdyb3RlOg0KPiA+IGRpZmYgLS1naXQgYS9kcml2ZXJzL2Jhc2UvZGV2
cmVzLmMgYi9kcml2ZXJzL2Jhc2UvZGV2cmVzLmMNCj4gPiBpbmRleCBmOThhMDk3ZTczZjIuLmQ2
NTMyN2NiODNjOSAxMDA2NDQNCj4gPiAtLS0gYS9kcml2ZXJzL2Jhc2UvZGV2cmVzLmMNCj4gPiAr
KysgYi9kcml2ZXJzL2Jhc2UvZGV2cmVzLmMNCj4gPiBAQCAtMjQsOCArMjQsMTIgQEAgc3RydWN0
IGRldnJlc19ub2RlIHsNCj4gPiAgDQo+ID4gIHN0cnVjdCBkZXZyZXMgew0KPiA+ICAJc3RydWN0
IGRldnJlc19ub2RlCQlub2RlOw0KPiA+IC0JLyogLS0gMyBwb2ludGVycyAqLw0KPiA+IC0JdW5z
aWduZWQgbG9uZyBsb25nCQlkYXRhW107CS8qIGd1YXJhbnRlZSB1bGwgYWxpZ25tZW50ICovDQo+
ID4gKwkvKg0KPiA+ICsJICogZGF0YVtdIG11c3QgYmUgNjQgYml0IGFsaWduZWQgZXZlbiBvbiAz
MiBiaXQgYXJjaGl0ZWN0dXJlcw0KPiA+ICsJICogYmVjYXVzZSBpdCBtaWdodCBiZSBhY2Nlc3Nl
ZCBieSBpbnN0cnVjdGlvbnMgdGhhdCByZXF1aXJlDQo+ID4gKwkgKiBhbGlnbmVkIG1lbW9yeSBh
cmd1bWVudHMgc3VjaCBhcyBhdG9taWM2NF90Lg0KPiA+ICsJICovDQo+ID4gKwl1OCBfX2FsaWdu
ZWQoOCkJCQlkYXRhW107DQo+ID4gIH07DQo+IA0KPiBGcm9tIGEgcXVpY2sgcmVhZGluZyBpbiBE
b2N1bWVudGF0aW9uL2RyaXZlci1tb2RlbC9kZXZyZXMudHh0IHRoaXMNCj4gZGV2cmVzIG11Y2sg
aXMgc3VwcG9zZWQgdG8gYmUgZGV2aWNlIG1lbW9yeSwgcmlnaHQ/DQo+IA0KPiBhdG9taWNzIChh
cyBpbiBhdG9taWMqX3QpIGFyZSBub3QgZGVmaW5lZCBmb3IgdXNlIG9uIG1taW8uDQo+IA0KPiB3
dGgga2luZCBvZiBjb2RlIGlzIHJlbHlpbmcgb24gdGhpcz8NCg0KSXQncyBFdG5hdml2IChHUFUv
RFJNKSBkcml2ZXIgaW4gZXRuYXZpdl9ncHVfcGxhdGZvcm1fcHJvYmUoKSwNCnNlZSBodHRwczov
L2VsaXhpci5ib290bGluLmNvbS9saW51eC9sYXRlc3Qvc291cmNlL2RyaXZlcnMvZ3B1L2RybS9l
dG5hdml2L2V0bmF2aXZfZ3B1LmMjTDE3NDA6DQotLS0tLS0tLS0tLS0tLS0tLS0tLS0tPjgtLS0t
LS0tLS0tLS0tLS0tLS0tLS0NCglzdHJ1Y3QgZHJtX2dwdV9zY2hlZHVsZXIgew0KCQkuLi4NCgkJ
YXRvbWljNjRfdAkJCWpvYl9pZF9jb3VudDsNCgkJLi4uDQoJfTsNCg0KCXN0cnVjdCBldG5hdml2
X2dwdSB7DQoJCS4uLg0KCQlzdHJ1Y3QgZHJtX2dwdV9zY2hlZHVsZXIJc2NoZWQ7DQoJfTsNCg0K
CXN0cnVjdCBldG5hdml2X2dwdSAqZ3B1Ow0KDQoJZ3B1ID0gZGV2bV9remFsbG9jKGRldiwgc2l6
ZW9mKCpncHUpLCBHRlBfS0VSTkVMKTsNCi0tLS0tLS0tLS0tLS0tLS0tLS0tLS0+OC0tLS0tLS0t
LS0tLS0tLS0tLS0tLQ0KDQotQWxleGV5
