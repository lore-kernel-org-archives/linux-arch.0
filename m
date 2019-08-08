Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail-eopbgr20066.outbound.protection.outlook.com ([40.107.2.66]:10816
        "EHLO EUR02-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725535AbfHHQaT (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Thu, 8 Aug 2019 12:30:19 -0400
From: Szabolcs Nagy <Szabolcs.Nagy@arm.com>
Subject: Re: [PATCH v7 1/2] arm64: Define
 Documentation/arm64/tagged-address-abi.rst
Date: Thu, 8 Aug 2019 16:30:01 +0000
Message-ID: <c73e76dd-de90-f5de-7809-5118270471c8@arm.com>
References: <20190807155321.9648-1-catalin.marinas@arm.com>
 <20190807155321.9648-2-catalin.marinas@arm.com>
In-Reply-To: <20190807155321.9648-2-catalin.marinas@arm.com>
Content-Language: en-US
Content-Type: text/plain; charset="utf-8"
Content-ID: <2416489F113EC049B7C1E80E7213516F@eurprd08.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Catalin Marinas <Catalin.Marinas@arm.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
Cc: nd <nd@arm.com>, Vincenzo Frascino <Vincenzo.Frascino@arm.com>, Will Deacon <Will.Deacon@arm.com>, Andrey Konovalov <andreyknvl@google.com>, Kevin Brodsky <Kevin.Brodsky@arm.com>, "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>, "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>, Dave Hansen <dave.hansen@intel.com>
Message-ID: <20190808163001.KJ44I3Hkr2EquFKzyL-SFiZte_mUvpAahCFiEGHdlOw@z>

T24gMDcvMDgvMjAxOSAxNjo1MywgQ2F0YWxpbiBNYXJpbmFzIHdyb3RlOg0KPiBGcm9tOiBWaW5j
ZW56byBGcmFzY2lubyA8dmluY2Vuem8uZnJhc2Npbm9AYXJtLmNvbT4NCj4gDQo+IE9uIGFybTY0
IHRoZSBUQ1JfRUwxLlRCSTAgYml0IGhhcyBiZWVuIGFsd2F5cyBlbmFibGVkIGhlbmNlDQo+IHRo
ZSB1c2Vyc3BhY2UgKEVMMCkgaXMgYWxsb3dlZCB0byBzZXQgYSBub24temVybyB2YWx1ZSBpbiB0
aGUNCj4gdG9wIGJ5dGUgYnV0IHRoZSByZXN1bHRpbmcgcG9pbnRlcnMgYXJlIG5vdCBhbGxvd2Vk
IGF0IHRoZQ0KPiB1c2VyLWtlcm5lbCBzeXNjYWxsIEFCSSBib3VuZGFyeS4NCj4gDQo+IFdpdGgg
dGhlIHJlbGF4ZWQgQUJJIHByb3Bvc2VkIHRocm91Z2ggdGhpcyBkb2N1bWVudCwgaXQgaXMgbm93
IHBvc3NpYmxlDQo+IHRvIHBhc3MgdGFnZ2VkIHBvaW50ZXJzIHRvIHRoZSBzeXNjYWxscywgd2hl
biB0aGVzZSBwb2ludGVycyBhcmUgaW4NCj4gbWVtb3J5IHJhbmdlcyBvYnRhaW5lZCBieSBhbiBh
bm9ueW1vdXMgKE1BUF9BTk9OWU1PVVMpIG1tYXAoKS4NCg0KZGVzY3JpcHRpb24gbmVlZHMgdG8g
YmUgdXBkYXRlZCBub3QgdG8gcmVzdHJpY3QgdGFncw0KdG8gYW5vbiBtbWFwLg0KDQo+ICszLiBB
QXJjaDY0IFRhZ2dlZCBBZGRyZXNzIEFCSSBFeGNlcHRpb25zDQo+ICstLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLQ0KPiArDQo+ICtUaGUgYmVoYXZpb3VyIGRlc2NyaWJl
ZCBpbiBzZWN0aW9uIDIsIHdpdGggcGFydGljdWxhciByZWZlcmVuY2UgdG8gdGhlDQo+ICthY2Nl
cHRhbmNlIGJ5IHRoZSBzeXNjYWxscyBvZiBhbnkgdmFsaWQgdGFnZ2VkIHBvaW50ZXIsIGlzIG5v
dCBhcHBsaWNhYmxlDQo+ICt0byB0aGUgZm9sbG93aW5nIGNhc2VzOg0KPiArDQo+ICstIG1tYXAo
KSBhZGRyIHBhcmFtZXRlci4NCj4gKw0KPiArLSBtcmVtYXAoKSBuZXdfYWRkcmVzcyBwYXJhbWV0
ZXIuDQo+ICsNCj4gKy0gcHJjdGwoUFJfU0VUX01NLCBgYCpgYCwgLi4uKSBvdGhlciB0aGFuIGFy
ZzIgUFJfU0VUX01NX01BUCBhbmQNCj4gKyAgUFJfU0VUX01NX01BUF9TSVpFLg0KPiArDQo+ICst
IHByY3RsKFBSX1NFVF9NTSwgUFJfU0VUX01NX01BUHssX1NJWkV9LCAuLi4pIHN0cnVjdCBwcmN0
bF9tbV9tYXAgZmllbGRzLg0KPiArDQo+ICtBbnkgYXR0ZW1wdCB0byB1c2Ugbm9uLXplcm8gdGFn
Z2VkIHBvaW50ZXJzIHdpbGwgbGVhZCB0byB1bmRlZmluZWQNCj4gK2JlaGF2aW91ci4NCg0KaSB0
aGluayB0aGF0IGJyayBtYXkgYmUgYWZmZWN0ZWQgdG9vIGJ5IHdoYXRldmVyIHRoYXQncw0KY2F1
c2luZyBwcm9ibGVtcyBpbiBtbWFwLg0KDQpvdGhlcndpc2UgdGhlIHRleHQgbG9va3MgZ29vZCB0
byBtZS4NCg==
