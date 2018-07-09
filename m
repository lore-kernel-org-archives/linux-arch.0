Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from smtprelay2.synopsys.com ([198.182.60.111]:51503 "EHLO
        smtprelay.synopsys.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754564AbeGIOd3 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 9 Jul 2018 10:33:29 -0400
From: Alexey Brodkin <Alexey.Brodkin@synopsys.com>
Subject: Re: [PATCH v3] devres: Explicitly align datai[] to 64-bit
Date: Mon, 9 Jul 2018 14:33:26 +0000
Message-ID: <44727d3cebda7bee5b68fb388bd2fecfc6dc7b89.camel@synopsys.com>
References: <20180709134550.29541-1-abrodkin@synopsys.com>
         <20180709140717.GR2476@hirez.programming.kicks-ass.net>
         <20180709141056.GR2512@hirez.programming.kicks-ass.net>
In-Reply-To: <20180709141056.GR2512@hirez.programming.kicks-ass.net>
Content-Language: en-US
Content-Type: text/plain; charset="utf-8"
Content-ID: <F5B1B0798FF2934384504C10F3BF1D1F@internal.synopsys.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: "peterz@infradead.org" <peterz@infradead.org>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "tglx@linutronix.de" <tglx@linutronix.de>, "linux-snps-arc@lists.infradead.org" <linux-snps-arc@lists.infradead.org>, "stable@vger.kernel.org" <stable@vger.kernel.org>, "greg@kroah.com" <greg@kroah.com>, "will.deacon@arm.com" <will.deacon@arm.com>, "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>, "David.Laight@ACULAB.COM" <David.Laight@ACULAB.COM>, "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>, "geert@linux-m68k.org" <geert@linux-m68k.org>
Message-ID: <20180709143326.DDxLrY0yAofHjLMtIydWdeGBTcMUzhdpyriB7ATaIe4@z>

SGkgUGV0ZXIsDQoNCk9uIE1vbiwgMjAxOC0wNy0wOSBhdCAxNjoxMCArMDIwMCwgUGV0ZXIgWmlq
bHN0cmEgd3JvdGU6DQo+IE9uIE1vbiwgSnVsIDA5LCAyMDE4IGF0IDA0OjA3OjE3UE0gKzAyMDAs
IFBldGVyIFppamxzdHJhIHdyb3RlOg0KPiA+IE9uIE1vbiwgSnVsIDA5LCAyMDE4IGF0IDA0OjQ1
OjUwUE0gKzAzMDAsIEFsZXhleSBCcm9ka2luIHdyb3RlOg0KPiA+ID4gLS0tIGEvZHJpdmVycy9i
YXNlL2RldnJlcy5jDQo+ID4gPiArKysgYi9kcml2ZXJzL2Jhc2UvZGV2cmVzLmMNCj4gPiA+IEBA
IC0yNCw4ICsyNCwxMiBAQCBzdHJ1Y3QgZGV2cmVzX25vZGUgew0KPiA+ID4gIA0KPiA+ID4gIHN0
cnVjdCBkZXZyZXMgew0KPiA+ID4gIAlzdHJ1Y3QgZGV2cmVzX25vZGUJCW5vZGU7DQo+ID4gPiAt
CS8qIC0tIDMgcG9pbnRlcnMgKi8NCj4gPiA+IC0JdW5zaWduZWQgbG9uZyBsb25nCQlkYXRhW107
CS8qIGd1YXJhbnRlZSB1bGwgYWxpZ25tZW50ICovDQo+ID4gPiArCS8qDQo+ID4gPiArCSAqIGRh
dGFbXSBtdXN0IGJlIDY0IGJpdCBhbGlnbmVkIGV2ZW4gb24gMzIgYml0IGFyY2hpdGVjdHVyZXMN
Cj4gPiA+ICsJICogYmVjYXVzZSBpdCBtaWdodCBiZSBhY2Nlc3NlZCBieSBpbnN0cnVjdGlvbnMg
dGhhdCByZXF1aXJlDQo+ID4gPiArCSAqIGFsaWduZWQgbWVtb3J5IGFyZ3VtZW50cyBzdWNoIGFz
IGF0b21pYzY0X3QuDQo+ID4gPiArCSAqLw0KPiA+ID4gKwl1OCBfX2FsaWduZWQoOCkJCQlkYXRh
W107DQo+ID4gPiAgfTsNCj4gPiANCj4gPiBTZWVpbmcgdGhhdCB0aGlzIGVuZHMgdXAgaW4gYSBz
ZW1pIGdlbmVyaWMgYWxsb2NhdGlvbiB0aGluZywgSSBkb24ndA0KPiA+IGZlZWwgdGhpcyBzaG91
bGQgYmUgZGlmZmVyZW50IGZyb20gQVJDSF9LTUFMTE9DX01JTkFMSUdOLg0KPiANCj4gSW4gZmFj
dCwgc2luY2UgYWxsb2NfZHIoKSB1c2VzIGttYWxsb2MoKSB0byBhbGxvY2F0ZSB0aGUgZW50aXJl
IHRoaW5nLA0KPiBpdCBpcyBpbXBvc3NpYmxlIHRvIGd1YXJhbnRlZSBhIGxhcmdlciBhbGlnbm1l
bnQgdGhhbiBrbWFsbG9jIGRvZXMuDQoNCldlbGwgYnV0IDQtYnl0ZXMgW3doaWNoIGlzIGNyaXRp
Y2FsIGZvciBhdG9taWM2NF90XSBzaG91bGQgYmUgbXVjaCBsZXNzDQp0aGFuIGEgc2FuZSBjYWNo
ZSBsaW5lIGxlbmd0aCBzbyBhYm92ZSBzaG91bGQgd29yay4NCg0KLUFsZXhleQ==
