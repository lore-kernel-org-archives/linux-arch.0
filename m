From: "Kani, Toshimitsu" <toshi.kani@hpe.com>
Subject: Re: Enhancing semantics with memremap() - aliasing with memremap()
Date: Tue, 31 May 2016 23:31:54 +0000
Message-ID: <1464736922.3504.85.camel@hpe.com>
References: <CAB=NE6Wy=V17uwc3GNMYaWk4cOx1a1TtHBgMYii-M5FDuPn_Gw@mail.gmail.com>
	 <20160531165828.GA25366@infradead.org>
	 <20160531172514.GI11948@wotan.suse.de>
	 <20160531172705.GJ11948@wotan.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mail-bl2on0120.outbound.protection.outlook.com ([65.55.169.120]:13408
	"EHLO na01-bl2-obe.outbound.protection.outlook.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1750884AbcFAADn (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Tue, 31 May 2016 20:03:43 -0400
In-Reply-To: <20160531172705.GJ11948@wotan.suse.de>
Content-Language: en-US
Content-ID: <73FAE9D6A5530548A204EB6AD2ADD190@NAMPRD84.PROD.OUTLOOK.COM>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: "mcgrof@kernel.org" <mcgrof@kernel.org>
Cc: "toshi.kani@hp.com" <toshi.kani@hp.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "hch@infradead.org" <hch@infradead.org>, "dan.j.williams@intel.com" <dan.j.williams@intel.com>, "x86@kernel.org" <x86@kernel.org>, "paulmck@linux.vnet.ibm.com" <paulmck@linux.vnet.ibm.com>, "will.deacon@arm.com" <will.deacon@arm.com>, "bp@alien8.de" <bp@alien8.de>, "julia.lawall@lip6.fr" <julia.lawall@lip6.fr>, "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>, "benh@kernel.crashing.org" <benh@kernel.crashing.org>

T24gVHVlLCAyMDE2LTA1LTMxIGF0IDE5OjI3ICswMjAwLCBMdWlzIFIuIFJvZHJpZ3VleiB3cm90
ZToNCj4gT24gVHVlLCBNYXkgMzEsIDIwMTYgYXQgMDc6MjU6MTRQTSArMDIwMCwgTHVpcyBSLiBS
b2RyaWd1ZXogd3JvdGU6DQo+ID4gDQo+ID4gT24gVHVlLCBNYXkgMzEsIDIwMTYgYXQgMDk6NTg6
MjhBTSAtMDcwMCwgQ2hyaXN0b3BoIEhlbGx3aWcgd3JvdGU6DQo+ID4gPiANCj4gPiA+IE9uIFR1
ZSwgTWF5IDI0LCAyMDE2IGF0IDA0OjM2OjQyUE0gLTA3MDAsIEx1aXMgUi4gUm9kcmlndWV6IHdy
b3RlOg0KPiA+ID4gPiANCj4gPiA+ID4gSXMgaXQgYSBnb29kIHRpbWUgZm9yIHRoYXQgbm93PyBJ
IHdvdWxkIGhvcGUgaWRlbnRpZnlpbmcgcHJvcGVyDQo+ID4gPiA+IGFsaWFzaW5nIHVzZXMgZm9y
IG1lbXJlbWFwKCkgbWlnaHQgYmUgYSBiaXQgZWFzaWVyIG5vdyB0aGFuIGZvcg0KPiA+ID4gPiBp
b3JlbWFwKCkgZ2l2ZW4gaXRzIG5vdCB1c2VkIGFzIHdpZGVseS4gSXQgbWF5IGJlIGFuIGVhc2ll
ciB0YXJnZXQNCj4gPiA+ID4gdG8gYWxzbyB3cml0ZSBzb21lIGdyYW1tYXIgcnVsZXMgZm9yIGl0
IGFzIHdlbGwuDQo+ID4gPsKgDQo+ID4gPiBTbyB5b3Ugd2FudCBhbiBleHBsaWNpdCBvcHQtaW4g
ZmxhZyB0byBhbGxvdyBhbGlhc2luZz/CoMKgU291bmRzIGZpbmUgdG8NCj4gPiA+IG1lLg0KPiA+
IMKgwqANCj4gPiBZdXAhIENhbiB0aGUgZGVmYXVsdCB0aGVuIHNhZmVseSBhbHJlYWR5IGJlIG5v
LWFsaWFzaW5nIHRoZW4/DQo+DQo+IE9yIGlmIGFsaWFzaW5nIGlzIHRydWx5IG5vdCBuZWVkZWQg
YXMgb2Z0ZW4gYSBkaWZmZXJlbnQgQVBJLCB0aGlzDQo+IG1heWJlIHVzZWZ1bCBsYXRlciBpZiB3
ZSBwaWNrIHVwIGFnYWluIG1vZHVsZSBuYW1lc3BhY2Ugc3R1ZmYuDQoNCkkgYWdyZWUgdGhhdCB3
ZSBzaG91bGQgYmUgYWJsZSB0byBjaGFuZ2UgbWVtcmVtYXAoKSB0byBmYWlsIGFuIGFsaWFzaW5n
DQpyZXF1ZXN0IHNpbmNlIGl0J3MgYSByZWxhdGl2ZWx5IG5ldyBpbnRlcmZhY2UuIMKgaW9yZW1h
cCgpIG5lZWRzIHRvIHN0YXJ0DQpmcm9tIGFkZGluZyBhIHdhcm5pbmcgbWVzc2FnZS4NCg0KVGhh
bmtzLA0KLVRvc2hpwqA=
