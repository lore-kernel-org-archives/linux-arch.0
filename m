From: "Kani, Toshi" <toshi.kani@hpe.com>
Subject: Re: [PATCH v1 0/4] Fix issues with huge mapping in ioremap
Date: Thu, 15 Mar 2018 14:38:27 +0000
Message-ID: <1521124702.2693.145.camel@hpe.com>
References: <1521017305-28518-1-git-send-email-cpandya@codeaurora.org>
         <1521038277.2693.131.camel@hpe.com>
         <9954bd28-0457-b80e-8af7-6259b63533f2@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <9954bd28-0457-b80e-8af7-6259b63533f2@codeaurora.org>
Content-Language: en-US
Content-ID: <891312FA6E232C4A9E87CA5353C923DE@NAMPRD84.PROD.OUTLOOK.COM>
Sender: linux-kernel-owner@vger.kernel.org
To: "cpandya@codeaurora.org" <cpandya@codeaurora.org>, "catalin.marinas@arm.com" <catalin.marinas@arm.com>, "will.deacon@arm.com" <will.deacon@arm.com>, "arnd@arndb.de" <arnd@arndb.de>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "ard.biesheuvel@linaro.org" <ard.biesheuvel@linaro.org>, "tglx@linutronix.de" <tglx@linutronix.de>, "takahiro.akashi@linaro.org" <takahiro.akashi@linaro.org>, "james.morse@arm.com" <james.morse@arm.com>, "kristina.martsenko@arm.com" <kristina.martsenko@arm.com>, "akpm@linux-foundation.org" <akpm@linux-foundation.org>, "mark.rutland@arm.com" <mark.rutland@arm.com>, "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "marc.zyngier@arm.com" <marc.zyngier@arm.com>, "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>
List-Id: linux-arch.vger.kernel.org

T24gVGh1LCAyMDE4LTAzLTE1IGF0IDEyOjQ3ICswNTMwLCBDaGludGFuIFBhbmR5YSB3cm90ZToN
Cj4gDQo+IE9uIDMvMTQvMjAxOCA4OjA4IFBNLCBLYW5pLCBUb3NoaSB3cm90ZToNCj4gPiBPbiBX
ZWQsIDIwMTgtMDMtMTQgYXQgMTQ6MTggKzA1MzAsIENoaW50YW4gUGFuZHlhIHdyb3RlOg0KPiA+
ID4gTm90ZTogSSB3YXMgd29ya2luZyBvbiB0aGVzZSBwYXRjaGVzIGZvciBxdWl0ZSBzb21ldGlt
ZQ0KPiA+ID4gYW5kIHJlYWxpemVkIHRoYXQgVG9zaGkgS2FuaSBoYXMgc2hhcmVkIHNvbWUgcGF0
Y2hlcw0KPiA+ID4gYWRkcmVzc2luZyB0aGUgc2FtZSBpc3NzdWUgd2l0aCBzdWJqZWN0DQo+ID4g
PiAiW1BBVENIIDAvMl0gZml4IG1lbW9yeSBsZWFrIC8gcGFuaWMgaW4gaW9yZW1hcCBodWdlIHBh
Z2VzIi4NCj4gPiA+IEkndmUgdGFrZW4gc2xpZ2h0bHkgZGlmZmVyZW50IGFwcHJvYWNoIGhlcmUs
IHNvIHNlbmRpbmcNCj4gPiA+IHRvIHRoZSBsaXN0LCBmaW5hbGx5Lg0KPiA+IA0KPiA+IEhpIENo
aW50YW4sDQo+IA0KPiBIaSBUb3NoaQ0KPiA+IA0KPiA+IERvIHlvdSBoYXZlIGFueSBpc3N1ZSBp
biBteSBwYXRjaHNldD8gIElmIHNvLCBjYW4geW91IHBsZWFzZSBjb21tZW50IG9uDQo+IA0KPiBO
b3QgZnVuY3Rpb25hbCBpc3N1ZXMuIEJ1dCBJIGRpZG4ndCBzZWUgaXNzdWVzIHlvdSBtZW50aW9u
ZWQgaW4geW91cg0KPiBjb21taXQgdGV4dCBiZWluZyBzb2x2ZWQgZm9yIEFSTTY0IGluIHlvdXIg
cGF0Y2hlcy4gSXQgaXMganVzdCBiZWluZw0KPiBtYXNrZWQgd2hpY2ggdGhleSB3ZXJlIGFscmVh
ZHkgYnkgV2lsbCdzIHBhdGNoLiBJbiBteSBhcHByb2FjaCwgZW5kDQo+IGdvYWwgd2FzIHRvIGdl
dCBiZW5lZml0cyBvZiBodWdlIG1hcHBpbmcgYmFjayBmb3IgQVJNNjQuDQoNClJpZ2h0LCBteSBw
YXRjaHNldCBkb2VzIG5vdCBpbXBsZW1lbnQgdGhlIGZpeCBmb3IgYXJtNjQuICBUaGUgc3R1Yg0K
dmVyc2lvbiBpcyBvbmx5IGEgd29ya2Fyb3VuZCBhbmQgaXMgbWVhbnQgdG8gYmUgcmVwbGFjZWQg
YnkgdGhlIGZpeC4NCg0KPiA+IHRoZW0/ICBJdCBjb21wbGljYXRlcyB0aGUgdGhpbmcgd2hlbiB5
b3Ugc2VuZCBhIGRpZmZlcmVudCBhcHByb2FjaA0KPiA+IHdpdGhvdXQgdGVsbGluZyB3aHkgYSBk
aWZmZXJlbnQgYXBwcm9hY2ggaXMgbmVlZGVkLiAgWW91ciBhcHByb2FjaA0KPiANCj4gU2VlIG15
IHJlcGx5IGFib3ZlLiBJIGp1c3QgaGFkIG15IG9yaWdpbmFsIHBhdGNoZXMgYW5kIEkgc2VudCBp
dC4NCj4gDQo+ID4gcHVyZ2VzIFRMQiBhZnRlciB1cGRhdGluZyBwbWQvcHVkLCB3aGljaCBJIHRo
aW5rIGlzIGJyb2tlbi4gIENhbiB5b3UNCj4gDQo+IFllcywgdGhleSBhcmUgYnJva2VuLiBJIHVu
ZGVyc3Rvb2QgdGhlIGlzc3VlcyBhZnRlciBNYXJrIGFuZCBNYXJjJ3MNCj4gcmV2aWV3IGNvbW1l
bnRzLg0KPiANCj4gPiB3b3JrIG9uIHRvcCBvZiBteSBwYXRjaHNldCBhbmQgcHJvcGVybHkgaW1w
bGVtZW50IHBYZF9mcmVlX3B0ZV9wYWdlKCkNCj4gDQo+IEkgaGF2ZSByZWFsaXplZCB0aGF0IGlm
IEkgYWRkcmVzcyBNYXJrJ3MgY29tbWVudHMsIG15IG5ldyBwYXRjaCB3aWxsDQo+IGxvb2sgc2lt
aWxhciB0byB3aGF0IHlvdSBoYXZlIGRvbmUuIFNvLCBJIHdpbGwgd29yayBvbiB0b3Agb2YgeW91
cg0KPiBwYXRjaGVzLg0KDQpTb3VuZHMgZ3JlYXQuDQoNClRoYW5rcywNCi1Ub3NoaQ0K
