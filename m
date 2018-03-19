Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from g9t1613g.houston.hpe.com ([15.241.32.99]:44048 "EHLO
        g9t1613g.houston.hpe.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S970806AbeCSTCU (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 19 Mar 2018 15:02:20 -0400
Received: from g2t2354.austin.hpe.com (g2t2354.austin.hpe.com [15.233.44.27])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by g9t1613g.houston.hpe.com (Postfix) with ESMTPS id 9510060BF1
        for <linux-arch@vger.kernel.org>; Mon, 19 Mar 2018 19:02:19 +0000 (UTC)
From: "Kani, Toshi" <toshi.kani@hpe.com>
Subject: Re: [PATCH v3 1/3] ioremap: Update pgtable free interfaces with addr
Date: Mon, 19 Mar 2018 19:01:45 +0000
Message-ID: <1521486096.2693.202.camel@hpe.com>
References: <1521463256-19858-1-git-send-email-cpandya@codeaurora.org>
         <1521463256-19858-2-git-send-email-cpandya@codeaurora.org>
In-Reply-To: <1521463256-19858-2-git-send-email-cpandya@codeaurora.org>
Content-Language: en-US
Content-Type: text/plain; charset="utf-8"
Content-ID: <E918B9CB35AE6047A33C70C73CA038E8@NAMPRD84.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: "cpandya@codeaurora.org" <cpandya@codeaurora.org>, "mark.rutland@arm.com" <mark.rutland@arm.com>, "catalin.marinas@arm.com" <catalin.marinas@arm.com>, "will.deacon@arm.com" <will.deacon@arm.com>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "ard.biesheuvel@linaro.org" <ard.biesheuvel@linaro.org>, "tglx@linutronix.de" <tglx@linutronix.de>, "takahiro.akashi@linaro.org" <takahiro.akashi@linaro.org>, "james.morse@arm.com" <james.morse@arm.com>, "kristina.martsenko@arm.com" <kristina.martsenko@arm.com>, "akpm@linux-foundation.org" <akpm@linux-foundation.org>, "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "marc.zyngier@arm.com" <marc.zyngier@arm.com>, "arnd@arndb.de" <arnd@arndb.de>, "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>
Message-ID: <20180319190145.Sl43TRvvabKU2vPLhB2hJBAx8k8vkqsDpdcNwdw8ySw@z>

T24gTW9uLCAyMDE4LTAzLTE5IGF0IDE4OjEwICswNTMwLCBDaGludGFuIFBhbmR5YSB3cm90ZToN
Cj4gVGhpcyBwYXRjaCAoIm1tL3ZtYWxsb2M6IEFkZCBpbnRlcmZhY2VzIHRvIGZyZWUgdW5tYXBw
ZWQNCj4gcGFnZSB0YWJsZSIpIGFkZHMgZm9sbG93aW5nIDIgaW50ZXJmYWNlcyB0byBmcmVlIHRo
ZSBwYWdlDQo+IHRhYmxlIGluIGNhc2Ugd2UgaW1wbGVtZW50IGh1Z2UgbWFwcGluZy4NCj4gDQo+
IHB1ZF9mcmVlX3BtZF9wYWdlKCkgYW5kIHBtZF9mcmVlX3B0ZV9wYWdlKCkNCj4gDQo+IFNvbWUg
YXJjaGl0ZWN0dXJlcyAobGlrZSBhcm02NCkgbmVlZHMgdG8gZG8gcHJvcGVyIFRMQg0KPiBtYWlu
dGFuYW5jZSBhZnRlciB1cGRhdGluZyBwYWdldGFibGUgZW50cnkgZXZlbiBpbiBtYXAuDQo+IFdo
eSA/IFJlYWQgdGhpcywNCj4gaHR0cHM6Ly9wYXRjaHdvcmsua2VybmVsLm9yZy9wYXRjaC8xMDEz
NDU4MS8NCj4gDQo+IFBhc3MgJ2FkZHInIGluIHRoZXNlIGludGVyZmFjZXMgc28gdGhhdCBwcm9w
ZXIgVExCIG9wcw0KPiBjYW4gYmUgcGVyZm9ybWVkLg0KPiANCj4gU2lnbmVkLW9mZi1ieTogQ2hp
bnRhbiBQYW5keWEgPGNwYW5keWFAY29kZWF1cm9yYS5vcmc+DQogOg0KPiBkaWZmIC0tZ2l0IGEv
YXJjaC94ODYvbW0vcGd0YWJsZS5jIGIvYXJjaC94ODYvbW0vcGd0YWJsZS5jDQo+IGluZGV4IDM0
Y2RhN2UuLjIwYjAzMjIgMTAwNjQ0DQo+IC0tLSBhL2FyY2gveDg2L21tL3BndGFibGUuYw0KPiAr
KysgYi9hcmNoL3g4Ni9tbS9wZ3RhYmxlLmMNCj4gQEAgLTcxMCw3ICs3MTAsNyBAQCBpbnQgcG1k
X2NsZWFyX2h1Z2UocG1kX3QgKnBtZCkNCj4gICAqIENvbnRleHQ6IFRoZSBwdWQgcmFuZ2UgaGFz
IGJlZW4gdW5tYXBlZCBhbmQgVExCIHB1cmdlZC4NCj4gICAqIFJldHVybjogMSBpZiBjbGVhcmlu
ZyB0aGUgZW50cnkgc3VjY2VlZGVkLiAwIG90aGVyd2lzZS4NCj4gICAqLw0KPiAtaW50IHB1ZF9m
cmVlX3BtZF9wYWdlKHB1ZF90ICpwdWQpDQo+ICtpbnQgcHVkX2ZyZWVfcG1kX3BhZ2UocHVkX3Qg
KnB1ZCwgdW5zaWduZWQgbG9uZyBhZGRyKQ0KDQpQbGVhc2UgdXBkYXRlIHRoZSBmdW5jdGlvbiBo
ZWFkZXIgYXMgd2VsbC4gIFNhbWUgZm9yIHBtZC4NCg0KKyAqIEBhZGRyOiBWaXJ0dWFsIGFkZHJl
c3MgYXNzb2NpYXRlZCB3aXRoIHB1ZC4NCg0KLS0tIGEvaW5jbHVkZS9hc20tZ2VuZXJpYy9wZ3Rh
YmxlLmgNCj4gKysrIGIvaW5jbHVkZS9hc20tZ2VuZXJpYy9wZ3RhYmxlLmgNCj4gQEAgLTk4Myw4
ICs5ODMsOCBAQCBzdGF0aWMgaW5saW5lIGludCBwNGRfY2xlYXJfaHVnZShwNGRfdCAqcDRkKQ0K
PiAgaW50IHBtZF9zZXRfaHVnZShwbWRfdCAqcG1kLCBwaHlzX2FkZHJfdCBhZGRyLCBwZ3Byb3Rf
dCBwcm90KTsNCj4gIGludCBwdWRfY2xlYXJfaHVnZShwdWRfdCAqcHVkKTsNCj4gIGludCBwbWRf
Y2xlYXJfaHVnZShwbWRfdCAqcG1kKTsNCj4gLWludCBwdWRfZnJlZV9wbWRfcGFnZShwdWRfdCAq
cHVkKTsNCj4gLWludCBwbWRfZnJlZV9wdGVfcGFnZShwbWRfdCAqcG1kKTsNCj4gK2ludCBwdWRf
ZnJlZV9wbWRfcGFnZShwdWRfdCAqcHVkLCB1bnNpZ25lZCBsb25nIGFkZHIpOw0KPiAraW50IHBt
ZF9mcmVlX3B0ZV9wYWdlKHBtZF90ICpwbWQsIHVuc2lnbmVkIGxvbmcgYWRkcik7DQo+ICAjZWxz
ZQkvKiAhQ09ORklHX0hBVkVfQVJDSF9IVUdFX1ZNQVAgKi8NCj4gIHN0YXRpYyBpbmxpbmUgaW50
IHA0ZF9zZXRfaHVnZShwNGRfdCAqcDRkLCBwaHlzX2FkZHJfdCBhZGRyLCBwZ3Byb3RfdA0KcHJv
dCkNCj4gIHsNCj4gQEAgLTEwMTAsMTEgKzEwMTAsMTEgQEAgc3RhdGljIGlubGluZSBpbnQgcG1k
X2NsZWFyX2h1Z2UocG1kX3QgKnBtZCkNCj4gIHsNCj4gIAlyZXR1cm4gMDsNCj4gIH0NCj4gLXN0
YXRpYyBpbmxpbmUgaW50IHB1ZF9mcmVlX3BtZF9wYWdlKHB1ZF90ICpwdWQpDQo+ICtzdGF0aWMg
aW5saW5lIGludCBwdWRfZnJlZV9wbWRfcGFnZShwdWRfdCAqcHVkLCB1bnNpZ25lZCBsb25nIGFk
ZHIpDQo+ICB7DQo+ICAJcmV0dXJuIDA7DQo+ICB9DQo+IC1zdGF0aWMgaW5saW5lIGludCBwbWRf
ZnJlZV9wdGVfcGFnZShwdWRfdCAqcG1kKQ0KPiArc3RhdGljIGlubGluZSBpbnQgcG1kX2ZyZWVf
cHRlX3BhZ2UocHVkX3QgKnBtZCwgdW5zaWduZWQgbG9uZyBhZGRyKQ0KDQpQbGVhc2UgYmFzZSB5
b3VyIHBhdGNoZXMgb24gdG9wIG9mIHRoZSBtbSB0cmVlIG9yIGF0IGxlYXN0IHBpY2sgdXANCjhj
YWI5M2RlOTk0ZjYgaW4gdGhlIG1tIHRyZWUuICBBbmRyZXcgZml4ZWQgdGhlIHR5cG87IHRoZSAn
cHVkX3QnIGFib3ZlDQpzaG91bGQgaGF2ZSBiZWVuICdwbWRfdCcuDQoNClRoYW5rcywNCi1Ub3No
aQ0K
