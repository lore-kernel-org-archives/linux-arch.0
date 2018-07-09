Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from smtprelay4.synopsys.com ([198.182.47.9]:43984 "EHLO
        smtprelay.synopsys.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932415AbeGIKYC (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 9 Jul 2018 06:24:02 -0400
From: Alexey Brodkin <Alexey.Brodkin@synopsys.com>
Subject: Re: [RESEND PATCH v2] devres: Really align data field to unsigned
 long long
Date: Mon, 9 Jul 2018 10:23:58 +0000
Message-ID: <82d2b36fa913bca6d56c7bf32a653324970817b8.camel@synopsys.com>
References: <20180709044444.6397-1-abrodkin@synopsys.com>
         <f7499a811ba54c00a11f7525ae216213@AcuMS.aculab.com>
         <c95ac7435736d93843c45628ba4d41a4a4988074.camel@synopsys.com>
         <91c57eeba2134dd99a9f0e11fa883c7c@AcuMS.aculab.com>
In-Reply-To: <91c57eeba2134dd99a9f0e11fa883c7c@AcuMS.aculab.com>
Content-Language: en-US
Content-Type: text/plain; charset="utf-8"
Content-ID: <0FE62AD68A7BDD4BA7A10A97E9CFE6D3@internal.synopsys.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: "David.Laight@ACULAB.COM" <David.Laight@ACULAB.COM>
Cc: "tglx@linutronix.de" <tglx@linutronix.de>, "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "greg@kroah.com" <greg@kroah.com>, "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>, "linux-snps-arc@lists.infradead.org" <linux-snps-arc@lists.infradead.org>, "stable@vger.kernel.org" <stable@vger.kernel.org>
Message-ID: <20180709102358.yI3FeERKMxeWoeYeiJ6SF7hkiAcoPvRaFl7c63PK1hw@z>

SGkgRGF2aWQsDQoNCk9uIE1vbiwgMjAxOC0wNy0wOSBhdCAxMDoxOCArMDAwMCwgRGF2aWQgTGFp
Z2h0IHdyb3RlOg0KPiBGcm9tOiBBbGV4ZXkgQnJvZGtpbg0KPiA+IFNlbnQ6IDA5IEp1bHkgMjAx
OCAxMTowMA0KPiANCj4gLi4uDQo+ID4gVGhhdCdzIGEgZ29vZCBpZGVhIGluZGVlZCBidXQgaXQg
ZG9lc24ndCBzb2x2ZSB0aGUgcHJvYmxlbSB3aXRoDQo+ID4gc3RydWN0IGRldnJlc19ub2RlLiBD
b25zaWRlciB0aGUgZm9sbG93aW5nIHNuaXBwZXQ6DQo+ID4gLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0+OC0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0NCj4gPiAJc3RydWN0
IG15c3RydWN0IHsNCj4gPiAJCWF0b21pYzY0X3QgbXl2YXI7DQo+ID4gCX0NCj4gPiANCj4gPiAJ
c3RydWN0IG15c3RydWN0ICpwOw0KPiA+IAlwID0gZGV2bV9remFsbG9jKGRldiwgc2l6ZW9mKCpw
KSwgR0ZQX0tFUk5FTCk7DQo+ID4gLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0+OC0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0NCj4gPiANCj4gPiBIZXJlIG15dmFyIGFkZHJl
c3Mgd2lsbCBtYXRjaCBhZGRyZXNzIG9mICJkYXRhIiBtZW1iZXIgb2Ygc3RydWN0IGRldnJlc19u
b2RlLg0KPiA+IFNvIGlmICJkYXRhIiBpcyBoYXMgb2Zmc2V0IG9mIDEyIGJ5dGVzIGZyb20gdGhl
IGJlZ2lubmluZyBvZiBhIHBhZ2UgdGhlbg0KPiA+IG15dmFyIHdvbid0IGJlIDY0LWJpdCBhbGln
bmVkIHJlZ2FyZGxlc3Mgb2YgbXl2YXIncyBhdHRyaWJ1dGUsIHJpZ2h0Pw0KPiANCj4gLi4uDQo+
ID4gPiA+IC0JdW5zaWduZWQgbG9uZyBsb25nCQlkYXRhW107CS8qIGd1YXJhbnRlZSB1bGwgYWxp
Z25tZW50ICovDQo+IA0KPiBBaGgsIHRoYXQgbGluZSBzaG91bGQgYmU6DQo+IAl1OCBkYXRhW10g
X19hbGlnbmVkKDgpOyAvKiBHdWFyYW50ZWUgNjRiaXQgYWxpZ25tZW50ICovDQoNCkFuZCB0aGF0
IHByZXR0eSBtdWNoIHdoYXQgSSBzdWdnZXN0ZWQgaW4gbXkgaW5pdGlhbCBwYXRjaCA6KQ0KDQpG
b3IgdGhlIHJlY29yZCB4ODYgaGFzIGV4YWN0bHkgdGhlIHNhbWUgYXRvbWljNjRfdCBhcyB5b3Ug
c3VnZ2VzdGVkLA0Kc2VlIGh0dHBzOi8vZWxpeGlyLmJvb3RsaW4uY29tL2xpbnV4L2xhdGVzdC9z
b3VyY2UvYXJjaC94ODYvaW5jbHVkZS9hc20vYXRvbWljNjRfMzIuaCNMMTM6DQotLS0tLS0tLS0t
LS0tLS0tLS0tLS0tPjgtLS0tLS0tLS0tLS0tLS0tLS0NCnR5cGVkZWYgc3RydWN0IHsNCgl1NjQg
X19hbGlnbmVkKDgpIGNvdW50ZXI7DQp9IGF0b21pYzY0X3Q7DQotLS0tLS0tLS0tLS0tLS0tLS0t
LS0tPjgtLS0tLS0tLS0tLS0tLS0tLS0NCg0KLUFsZXhleQ==
