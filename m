From: Michael Kelley <mikelley@microsoft.com>
Subject: RE: [PATCH v6 09/10] arm64: efi: Export screen_info
Date: Thu, 19 Mar 2020 21:46:30 +0000
Message-ID: <MW2PR2101MB1052E413218D295EF24E5E05D7F40@MW2PR2101MB1052.namprd21.prod.outlook.com>
References: <1584200119-18594-1-git-send-email-mikelley@microsoft.com>
 <1584200119-18594-10-git-send-email-mikelley@microsoft.com>
 <CAK8P3a1YUjhaVUmjVC2pCoTTBTU408iN44Q=QZ0RDz8rmzJisQ@mail.gmail.com>
 <MW2PR2101MB10524254D2FE3EFC72329465D7F70@MW2PR2101MB1052.namprd21.prod.outlook.com>
 <CAK8P3a1YCtc3LJ-_3iT90_Srehb96gLHvTXsbJ0wT6NFYCG=TQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mail-dm6nam11on2123.outbound.protection.outlook.com ([40.107.223.123]:46176
        "EHLO NAM11-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726619AbgCSVqf (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Thu, 19 Mar 2020 17:46:35 -0400
In-Reply-To: <CAK8P3a1YCtc3LJ-_3iT90_Srehb96gLHvTXsbJ0wT6NFYCG=TQ@mail.gmail.com>
Content-Language: en-US
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Arnd Bergmann <arnd@arndb.de>
Cc: Will Deacon <will@kernel.org>, Ard Biesheuvel <ardb@kernel.org>, Catalin Marinas <catalin.marinas@arm.com>, Mark Rutland <mark.rutland@arm.com>, Marc Zyngier <maz@kernel.org>, Linux ARM <linux-arm-kernel@lists.infradead.org>, gregkh <gregkh@linuxfoundation.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>, linux-efi <linux-efi@vger.kernel.org>, linux-arch <linux-arch@vger.kernel.org>, "olaf@aepfle.de" <olaf@aepfle.de>, Andy Whitcroft <apw@canonical.com>, vkuznets <vkuznets@redhat.com>, Jason Wang <jasowang@redhat.com>, "marcelo.cerri@canonical.com" <marcelo.cerri@canonical.com>, KY Srinivasan <kys@microsoft.com>, Sunil Muthuswamy <sunilmut@microsoft.com>, Boqun Feng <boqun.feng@>

RnJvbTogQXJuZCBCZXJnbWFubiA8YXJuZEBhcm5kYi5kZT4gU2VudDogV2VkbmVzZGF5LCBNYXJj
aCAxOCwgMjAyMCAyOjI3IEFNDQo+IA0KPiBPbiBXZWQsIE1hciAxOCwgMjAyMCBhdCAxOjE4IEFN
IE1pY2hhZWwgS2VsbGV5IDxtaWtlbGxleUBtaWNyb3NvZnQuY29tPiB3cm90ZToNCj4gPiBGcm9t
OiBBcm5kIEJlcmdtYW5uIDxhcm5kQGFybmRiLmRlPg0KPiA+ID4gT24gU2F0LCBNYXIgMTQsIDIw
MjAgYXQgNDozNiBQTSBNaWNoYWVsIEtlbGxleSA8bWlrZWxsZXlAbWljcm9zb2Z0LmNvbT4gd3Jv
dGU6DQo+ID4gPiA+DQo+ID4gPiA+IFRoZSBIeXBlci1WIGZyYW1lIGJ1ZmZlciBkcml2ZXIgbWF5
IGJlIGJ1aWx0IGFzIGEgbW9kdWxlLCBhbmQNCj4gPiA+ID4gaXQgbmVlZHMgYWNjZXNzIHRvIHNj
cmVlbl9pbmZvLiBTbyBleHBvcnQgc2NyZWVuX2luZm8uDQo+ID4gPiA+DQo+ID4gPiA+IFNpZ25l
ZC1vZmYtYnk6IE1pY2hhZWwgS2VsbGV5IDxtaWtlbGxleUBtaWNyb3NvZnQuY29tPg0KPiA+ID4N
Cj4gPiA+IElzIHRoZXJlIGFueSBjaGFuY2Ugb2YgdXNpbmcgYSBtb3JlIG1vZGVybiBLTVMgYmFz
ZWQgZHJpdmVyIGZvciB0aGUgc2NyZWVuDQo+ID4gPiB0aGFuIHRoZSBvbGQgZmJkZXYgc3Vic3lz
dGVtPyBJIGhhZCBob3BlZCB0byBvbmUgZGF5IGNvbXBsZXRlbHkgcmVtb3ZlDQo+ID4gPiBzdXBw
b3J0IGZvciB0aGUgb2xkIENPTkZJR19WSURFT19GQkRFViBhbmQgc2NyZWVuX2luZm8gZnJvbSBt
b2Rlcm4NCj4gPiA+IGFyY2hpdGVjdHVyZXMuDQo+ID4gPg0KPiA+DQo+ID4gVGhlIGN1cnJlbnQg
aHlwZXJ2X2ZiLmMgZHJpdmVyIGlzIGFsbCB3ZSBoYXZlIHRvZGF5IGZvciB0aGUgc3ludGhldGlj
IEh5cGVyLVYNCj4gPiBmcmFtZSBidWZmZXIgZGV2aWNlLiAgVGhhdCBkcml2ZXIgYnVpbGRzIGFu
ZCBydW5zIG9uIGJvdGggQVJNNjQgYW5kIHg4Ni4NCj4gPg0KPiA+IEknbSBub3Qga25vd2xlZGdl
YWJsZSBhYm91dCB2aWRlby9ncmFwaGljcyBkcml2ZXJzLCBidXQgd2hlbiB5b3UNCj4gPiBzYXkg
ImEgbW9yZSBtb2Rlcm4gS01TIGJhc2VkIGRyaXZlciIsIGFyZSB5b3UgbWVhbmluZyBvbmUgYmFz
ZWQgb24NCj4gPiBEUk0gJiBLTVM/ICBEb2VzIERSTSBtYWtlIHNlbnNlIGZvciBhICJkdW1iIiBm
cmFtZSBidWZmZXIgZGV2aWNlPw0KPiA+IEFyZSB0aGVyZSBhbnkgZHJpdmVycyB0aGF0IHdvdWxk
IGJlIGEgZ29vZCBwYXR0ZXJuIHRvIGxvb2sgYXQ/DQo+IA0KPiBJdCB1c2VkIHRvIGJlIGEgbG90
IGhhcmRlciB0byB3cml0ZSBhIERSTSBkcml2ZXIgY29tcGFyZWQgdG8gYW4gZmJkZXYNCj4gZHJp
dmVyLCBidXQgdGhpcyBoYXMgY2hhbmdlZCB0byB0aGUgb3Bwb3NpdGUgb3ZlciB0aGUgeWVhcnMu
DQo+IA0KPiBBIGZhaXJseSBtaW5pbWFsIGV4YW1wbGUgd291bGQgYmUgZHJpdmVycy9ncHUvZHJt
L3BsMTExL3BsMTExX2Rydi5jDQo+IG9yIGFueXRoaW5nIGluIGRyaXZlcnMvZ3B1L2RybS90aW55
LywgYnV0IHlvdSBtYXkgd2FudCB0byBsb29rIGF0IHRoZQ0KPiBvdGhlciBoeXBlcnZpc29yIHBs
YXRmb3JtcyBmaXJzdCwgaS5lIGRyaXZlcnMvZ3B1L2RybS92aXJ0aW8vdmlydGdwdV9kcnYuYywN
Cj4gZHJpdmVycy9ncHUvZHJtL3Ztd2dmeC92bXdnZnhfZHJ2LmMsIGRyaXZlcnMvZ3B1L2RybS94
ZW4veGVuX2RybV9mcm9udC5jLA0KPiBkcml2ZXJzL2dwdS9kcm0vcXhsL3F4bF9kcnYuYywgYW5k
IGRyaXZlcnMvZ3B1L2RybS9ib2Nocy9ib2Noc19kcnYuYy4NCj4gDQoNClRoYW5rcyBmb3IgdGhl
IHBvaW50ZXJzLCBlc3BlY2lhbGx5IGZvciB0aGUgb3RoZXIgaHlwZXJ2aXNvcnMuDQoNCk1pY2hh
ZWwNCg==
