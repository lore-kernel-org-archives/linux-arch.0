Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from smtp-out6.electric.net ([192.162.217.186]:51179 "EHLO
        smtp-out6.electric.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754432AbeGIKRF (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 9 Jul 2018 06:17:05 -0400
From: David Laight <David.Laight@ACULAB.COM>
Subject: RE: [RESEND PATCH v2] devres: Really align data field to unsigned
 long long
Date: Mon, 9 Jul 2018 10:18:36 +0000
Message-ID: <91c57eeba2134dd99a9f0e11fa883c7c@AcuMS.aculab.com>
References: <20180709044444.6397-1-abrodkin@synopsys.com>
         <f7499a811ba54c00a11f7525ae216213@AcuMS.aculab.com>
 <c95ac7435736d93843c45628ba4d41a4a4988074.camel@synopsys.com>
In-Reply-To: <c95ac7435736d93843c45628ba4d41a4a4988074.camel@synopsys.com>
Content-Language: en-US
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: 'Alexey Brodkin' <Alexey.Brodkin@synopsys.com>
Cc: "tglx@linutronix.de" <tglx@linutronix.de>, "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "greg@kroah.com" <greg@kroah.com>, "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>, "linux-snps-arc@lists.infradead.org" <linux-snps-arc@lists.infradead.org>, "stable@vger.kernel.org" <stable@vger.kernel.org>
Message-ID: <20180709101836.ZFMG0eGkv-6xOVmLleiApfhuBu5jxxJ8eRwhp3UNQf8@z>

RnJvbTogQWxleGV5IEJyb2RraW4NCj4gU2VudDogMDkgSnVseSAyMDE4IDExOjAwDQouLi4NCj4g
VGhhdCdzIGEgZ29vZCBpZGVhIGluZGVlZCBidXQgaXQgZG9lc24ndCBzb2x2ZSB0aGUgcHJvYmxl
bSB3aXRoDQo+IHN0cnVjdCBkZXZyZXNfbm9kZS4gQ29uc2lkZXIgdGhlIGZvbGxvd2luZyBzbmlw
cGV0Og0KPiAtLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLT44LS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLQ0KPiAJc3RydWN0IG15c3RydWN0IHsNCj4gCQlhdG9taWM2NF90IG15
dmFyOw0KPiAJfQ0KPiANCj4gCXN0cnVjdCBteXN0cnVjdCAqcDsNCj4gCXAgPSBkZXZtX2t6YWxs
b2MoZGV2LCBzaXplb2YoKnApLCBHRlBfS0VSTkVMKTsNCj4gLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0+OC0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0NCj4gDQo+IEhlcmUg
bXl2YXIgYWRkcmVzcyB3aWxsIG1hdGNoIGFkZHJlc3Mgb2YgImRhdGEiIG1lbWJlciBvZiBzdHJ1
Y3QgZGV2cmVzX25vZGUuDQo+IFNvIGlmICJkYXRhIiBpcyBoYXMgb2Zmc2V0IG9mIDEyIGJ5dGVz
IGZyb20gdGhlIGJlZ2lubmluZyBvZiBhIHBhZ2UgdGhlbg0KPiBteXZhciB3b24ndCBiZSA2NC1i
aXQgYWxpZ25lZCByZWdhcmRsZXNzIG9mIG15dmFyJ3MgYXR0cmlidXRlLCByaWdodD8NCi4uLg0K
PiA+ID4gLQl1bnNpZ25lZCBsb25nIGxvbmcJCWRhdGFbXTsJLyogZ3VhcmFudGVlIHVsbCBhbGln
bm1lbnQgKi8NCg0KQWhoLCB0aGF0IGxpbmUgc2hvdWxkIGJlOg0KCXU4IGRhdGFbXSBfX2FsaWdu
ZWQoOCk7IC8qIEd1YXJhbnRlZSA2NGJpdCBhbGlnbm1lbnQgKi8NCg0KCURhdmlkDQoNCg==
