From: Michael Kelley <mikelley@microsoft.com>
Subject: RE: [PATCH v6 04/10] arm64: hyperv: Add memory alloc/free functions
 for Hyper-V size pages
Date: Wed, 18 Mar 2020 00:15:25 +0000
Message-ID: <MW2PR2101MB1052D91D3A9CEEBD7E2EA82FD7F70@MW2PR2101MB1052.namprd21.prod.outlook.com>
References: <1584200119-18594-1-git-send-email-mikelley@microsoft.com>
 <1584200119-18594-5-git-send-email-mikelley@microsoft.com>
 <CAK8P3a2Hnm74aUMNFHbjMr4HwHGZn1+xa4ERsxAJY6hMzhEOhQ@mail.gmail.com>
 <632eb459dbe53a9b69df2a4f030a755b@kernel.org>
 <CAK8P3a3aihZeriUWAhWJMsOtdiY4Lo29syrRbB4Po3v4dsLhvA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mail-eopbgr770131.outbound.protection.outlook.com ([40.107.77.131]:12509
        "EHLO NAM02-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726680AbgCRAPb (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Tue, 17 Mar 2020 20:15:31 -0400
In-Reply-To: <CAK8P3a3aihZeriUWAhWJMsOtdiY4Lo29syrRbB4Po3v4dsLhvA@mail.gmail.com>
Content-Language: en-US
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Arnd Bergmann <arnd@arndb.de>, Marc Zyngier <maz@kernel.org>, gregkh <gregkh@linuxfoundation.org>
Cc: Will Deacon <will@kernel.org>, Ard Biesheuvel <ardb@kernel.org>, Catalin Marinas <catalin.marinas@arm.com>, Mark Rutland <mark.rutland@arm.com>, Linux ARM <linux-arm-kernel@lists.infradead.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>, linux-efi <linux-efi@vger.kernel.org>, linux-arch <linux-arch@vger.kernel.org>, "olaf@aepfle.de" <olaf@aepfle.de>, Andy Whitcroft <apw@canonical.com>, vkuznets <vkuznets@redhat.com>, Jason Wang <jasowang@redhat.com>, "marcelo.cerri@canonical.com" <marcelo.cerri@canonical.com>, KY Srinivasan <kys@microsoft.com>, Sunil Muthuswamy <sunilmut@microsoft.com>, Boqun Feng <boqun.feng@gmail.com>

RnJvbTogQXJuZCBCZXJnbWFubiA8YXJuZEBhcm5kYi5kZT4gU2VudDogTW9uZGF5LCBNYXJjaCAx
NiwgMjAyMCAxOjMzIEFNDQo+IA0KPiBPbiBNb24sIE1hciAxNiwgMjAyMCBhdCA5OjMwIEFNIE1h
cmMgWnluZ2llciA8bWF6QGtlcm5lbC5vcmc+IHdyb3RlOg0KPiA+IE9uIDIwMjAtMDMtMTYgMDg6
MjIsIEFybmQgQmVyZ21hbm4gd3JvdGU6DQo+ID4gPiBPbiBTYXQsIE1hciAxNCwgMjAyMCBhdCA0
OjM2IFBNIE1pY2hhZWwgS2VsbGV5IDxtaWtlbGxleUBtaWNyb3NvZnQuY29tPg0KPiA+ID4gd3Jv
dGU6DQo+ID4gPj4gIC8qDQo+ID4gPj4gKyAqIEZ1bmN0aW9ucyBmb3IgYWxsb2NhdGluZyBhbmQg
ZnJlZWluZyBtZW1vcnkgd2l0aCBzaXplIGFuZA0KPiA+ID4+ICsgKiBhbGlnbm1lbnQgSFZfSFlQ
X1BBR0VfU0laRS4gVGhlc2UgZnVuY3Rpb25zIGFyZSBuZWVkZWQgYmVjYXVzZQ0KPiA+ID4+ICsg
KiB0aGUgZ3Vlc3QgcGFnZSBzaXplIG1heSBub3QgYmUgdGhlIHNhbWUgYXMgdGhlIEh5cGVyLVYg
cGFnZQ0KPiA+ID4+ICsgKiBzaXplLiBXZSBkZXBlbmQgdXBvbiBrbWFsbG9jKCkgYWxpZ25pbmcg
cG93ZXItb2YtdHdvIHNpemUNCj4gPiA+PiArICogYWxsb2NhdGlvbnMgdG8gdGhlIGFsbG9jYXRp
b24gc2l6ZSBib3VuZGFyeSwgc28gdGhhdCB0aGUNCj4gPiA+PiArICogYWxsb2NhdGVkIG1lbW9y
eSBhcHBlYXJzIHRvIEh5cGVyLVYgYXMgYSBwYWdlIG9mIHRoZSBzaXplDQo+ID4gPj4gKyAqIGl0
IGV4cGVjdHMuDQo+ID4gPj4gKyAqDQo+ID4gPj4gKyAqIFRoZXNlIGZ1bmN0aW9ucyBhcmUgdXNl
ZCBieSBhcm02NCBzcGVjaWZpYyBjb2RlIGFzIHdlbGwgYXMNCj4gPiA+PiArICogYXJjaCBpbmRl
cGVuZGVudCBIeXBlci1WIGRyaXZlcnMuDQo+ID4gPj4gKyAqLw0KPiA+ID4+ICsNCj4gPiA+PiAr
dm9pZCAqaHZfYWxsb2NfaHlwZXJ2X3BhZ2Uodm9pZCkNCj4gPiA+PiArew0KPiA+ID4+ICsgICAg
ICAgQlVJTERfQlVHX09OKFBBR0VfU0laRSA8ICBIVl9IWVBfUEFHRV9TSVpFKTsNCj4gPiA+PiAr
ICAgICAgIHJldHVybiBrbWFsbG9jKEhWX0hZUF9QQUdFX1NJWkUsIEdGUF9LRVJORUwpOw0KPiA+
ID4+ICt9DQo+ID4gPj4gK0VYUE9SVF9TWU1CT0xfR1BMKGh2X2FsbG9jX2h5cGVydl9wYWdlKTsN
Cj4gPiA+DQo+ID4gPiBJIGRvbid0IHRoaW5rIHRoZXJlIGlzIGFueSBndWFyYW50ZWUgdGhhdCBr
bWFsbG9jKCkgcmV0dXJucw0KPiA+ID4gcGFnZS1hbGlnbmVkDQo+ID4gPiBhbGxvY2F0aW9ucyBp
biBnZW5lcmFsLg0KPiA+DQo+ID4gSSBiZWxpZXZlIHRoYXQgZ3VhcmFudGVlIGNhbWUgd2l0aCA1
OWJiNDc5ODVjMWRiICgibW0sIHNsW2FvdV1iOg0KPiA+IGd1YXJhbnRlZQ0KPiA+IG5hdHVyYWwg
YWxpZ25tZW50IGZvciBrbWFsbG9jKHBvd2VyLW9mLXR3bykiKS4NCj4gPg0KPiA+ID4gSG93IGFi
b3V0IHVzaW5nIGdldF9mcmVlX3BhZ2VzKCkgdG8gaW1wbGVtZW50IHRoaXM/DQo+ID4NCj4gPiBU
aGlzIHdvdWxkIGNlcnRhaW5seSB3b3JrLCBhdCB0aGUgZXhwZW5zZSBvZiBhIGxvdCBvZiB3YXN0
ZWQgbWVtb3J5IHdoZW4NCj4gPiBQQUdFX1NJWkUgaXNuJ3QgNGsuDQo+IA0KPiBJJ20gc3VyZSB0
aGlzIGlzIHRoZSBsZWFzdCBvZiB5b3VyIHByb2JsZW1zIHdoZW4gdGhlIGd1ZXN0IHJ1bnMgd2l0
aA0KPiBhIGxhcmdlIGJhc2UgcGFnZSBzaXplLCB5b3UndmUgYWxyZWFkeSB3YXN0ZWQgbW9zdCBv
ZiB5b3VyIG1lbW9yeQ0KPiBvdGhlcndpc2UgdGhlbi4NCj4gDQoNCkkgdGhpbmsgdGhlcmUncyB2
YWx1ZSBpbiBrZWVwaW5nIHRoZXNlIGZ1bmN0aW9ucy4gIFRoZXJlIGFyZSA4IHVzZXMgaW4NCmFy
Y2hpdGVjdHVyZSBpbmRlcGVuZGVudCBjb2RlIGF0IHRoZSBtb21lbnQsIHdoaWNoIGFkbWl0dGVk
bHkgc2F2ZXMNCm9ubHkgfjEvMiBNYnl0ZSBvZiBtZW1vcnkgd2l0aCBhIDY0SyBwYWdlIHNpemUs
IGJ1dCB3ZSB3aWxsIGhhdmUNCmFkZGl0aW9uYWwgdXNlcyB3aXRoIG1vcmUgbWVtb3J5IHNhdmlu
Z3MgYXMgd2UgZ2V0IGFsbCBvZiB0aGUNCkh5cGVyLVYgc3ludGhldGljIGRyaXZlcnMgdG8gd29y
ayB3aXRoIDY0SyBwYWdlIHNpemUuICBGdXJ0aGVybW9yZSwNCnRoZXJlJ3MgY29taW5nIHdvcmsg
dGhhdCB3aWxsIHJlcXVpcmUgYWRkaXRpb25hbCBzdGVwcyB0byBzaGFyZSBhIHBhZ2UNCmJldHdl
ZW4gYSBndWVzdCBhbmQgdGhlIEh5cGVyLVYgaG9zdC4gIFRoZXNlIGZ1bmN0aW9ucyBhcmUgdGhl
IHJpZ2h0DQpwbGFjZSB0byBwdXQgdGhlIGNvZGUgZm9yIHRoZSBhZGRpdGlvbmFsIHNoYXJpbmcg
c3RlcHMuICBSZW1vdmluZyB0aGVtDQpub3cgaW4gZmF2b3Igb2YgYSBiYXJlIGttYWxsb2MoKSBh
bmQgdGhlbiBhZGRpbmcgdGhlbSBiYWNrIGRvZXNuJ3QNCnNlZW0gd29ydGh3aGlsZS4NCg0KTWlj
aGFlbA0K
