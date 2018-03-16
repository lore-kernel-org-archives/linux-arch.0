From: Alexey Brodkin <Alexey.Brodkin@synopsys.com>
Subject: Re: Do we need to disable preemption in flush_tlb_range()?
Date: Fri, 16 Mar 2018 15:01:22 +0000
Message-ID: <1521212481.4805.2.camel@synopsys.com>
References: <1519917189.13866.6.camel@synopsys.com>
         <5a5c67c1-9f45-f908-2c8d-0914cd616a18@synopsys.com>
         <20180315082720.GT4064@hirez.programming.kicks-ass.net>
         <1521106770.11552.70.camel@synopsys.com>
         <20180316101124.GB4064@hirez.programming.kicks-ass.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180316101124.GB4064@hirez.programming.kicks-ass.net>
Content-Language: en-US
Content-ID: <44DB983CB1008B4F89AD99B8A38C0138@internal.synopsys.com>
Sender: linux-kernel-owner@vger.kernel.org
To: "peterz@infradead.org" <peterz@infradead.org>
Cc: "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "Vineet.Gupta1@synopsys.com" <Vineet.Gupta1@synopsys.com>, "linux-snps-arc@lists.infradead.org" <linux-snps-arc@lists.infradead.org>
List-Id: linux-arch.vger.kernel.org

SGkgUGV0ZXIsDQoNCk9uIEZyaSwgMjAxOC0wMy0xNiBhdCAxMToxMSArMDEwMCwgUGV0ZXIgWmlq
bHN0cmEgd3JvdGU6DQo+IE9uIFRodSwgTWFyIDE1LCAyMDE4IGF0IDA5OjM5OjMxQU0gKzAwMDAs
IEFsZXhleSBCcm9ka2luIHdyb3RlOg0KPiA+IEhpIFBldGVyLA0KPiA+IA0KPiA+IE9uIFRodSwg
MjAxOC0wMy0xNSBhdCAwOToyNyArMDEwMCwgUGV0ZXIgWmlqbHN0cmEgd3JvdGU6DQo+ID4gPiBP
biBXZWQsIE1hciAxNCwgMjAxOCBhdCAwMToxOTowMVBNIC0wNzAwLCBWaW5lZXQgR3VwdGEgd3Jv
dGU6DQo+ID4gPiA+ICtDQyBQZXRlciBzaW5jZSB3ZSBoYXZlIGhpcyBhdHRlbnRpb24gOy0pDQo+
ID4gPiANCj4gPiA+IFllYWgsIHRpbWV6b25lIGNvbGxpc2lvbiB0aGVyZSwgSSB0eXBpY2FsbHkg
c2xlZXAgYXQgMWFtIDstKQ0KPiA+ID4gDQo+ID4gPiA+IE9uIDAzLzAxLzIwMTggMDc6MTMgQU0s
IEFsZXhleSBCcm9ka2luIHdyb3RlOg0KPiA+ID4gPiA+IEhpIFZpbmVldCwNCj4gPiA+ID4gPiAN
Cj4gPiA+ID4gPiBKdXN0IG5vdGljZWQgdGhhdCBpbiBjb21tZW50cyBmb3Igc21wX2NhbGxfZnVu
Y3Rpb25fbWFueSgpIGl0IGlzIHNhaWQgdGhhdA0KPiA+ID4gPiA+IHByZWVtcHRpb24gbXVzdCBi
ZSBkaXNhYmxlZCBkdXJpbmcgaXRzIGV4ZWN1dGlvbi4gQW5kIHRoYXQgZnVuY3Rpb24gZ2V0cyBl
eGVjdXRlZA0KPiA+ID4gPiA+IGFtb25nIG90aGVyIHdheXMgbGlrZSB0aGF0Og0KPiA+ID4gPiA+
IC0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tPjgtLS0tLS0tLS0tLS0tLS0tLS0tLS0tLQ0KPiA+
ID4gPiA+ICAgIGZsdXNoX3RsYl9yYW5nZSgpDQo+ID4gPiA+ID4gICAgICAtPiBvbl9lYWNoX2Nw
dV9tYXNrKCkNCj4gPiA+ID4gPiAgICAgICAgICAgLT4gc21wX2NhbGxfZnVuY3Rpb25fbWFueSgp
DQo+ID4gPiA+ID4gLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0+OC0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tDQo+ID4gPiA+IA0KPiA+ID4gPiBJbiBnZW5lcmFsIEkgcHJlZmVyIG5vdCB0byAtIFBl
dGVyIHdoYXQgc2F5IHlvdSA/DQo+ID4gPiANCj4gPiA+IFRoZSBjb21tZW50IHdpdGggc21wX2Nh
bGxfZnVuY3Rpb25fbWFueSgpIGlzIGNvcnJlY3QsIGl0IHJlbGllcyBvbg0KPiA+ID4gcHJlZW1w
dGlvbiBiZWluZyBkaXNhYmxlZCBpbiBhIG51bWJlciBvZiB3YXlzLiBJIHdvdWxkIGV4cGVjdA0K
PiA+ID4gdGhpc19jcHVfcHRyKCkgZm9yIGV4YW1wbGUgdG8gY29tcGxhaW4gd2hlbiB1c2VkIHdp
dGggcHJlZW1wdGlvbg0KPiA+ID4gZW5hYmxlZCAoQ09ORklHX0RFQlVHX1BSRUVNUFQpLg0KPiAN
Cj4gU28gb25fZWFjaF9jcHVfbWFzaygpIGFscmVhZHkgZGlzYWJsZXMgcHJlZW1wdGlvbiBhcm91
bmQgY2FsbGluZw0KPiBzbXBfY2FsbF9mdW5jdGlvbl9tYW55KCkuDQoNClJpZ2h0IHRoYXQgaGFw
cGVucyBpbiBnZXRfY3B1KCkgc28gdGhlbiB3ZSdyZSBnb2xkZW4gaGVyZS4NClRoYW5rcyBmb3Ig
cG9pbnRpbmcgb3V0IC0gd2FzIG5vdCBjbGVhciBpbW1lZGlhdGVseSBmcm9tIHRoZSBjb2RlIDop
DQoNCi1BbGV4ZXk=
