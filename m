Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from smtprelay.synopsys.com ([198.182.60.111]:51937 "EHLO
        smtprelay.synopsys.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932704AbeGIOxl (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 9 Jul 2018 10:53:41 -0400
From: Alexey Brodkin <Alexey.Brodkin@synopsys.com>
Subject: Re: [PATCH v3] devres: Explicitly align datai[] to 64-bit
Date: Mon, 9 Jul 2018 14:53:36 +0000
Message-ID: <4f6e9e8bf60f05872afaed4a1d8e516331e95ea7.camel@synopsys.com>
References: <20180709134550.29541-1-abrodkin@synopsys.com>
         <20180709140717.GR2476@hirez.programming.kicks-ass.net>
         <20180709141056.GR2512@hirez.programming.kicks-ass.net>
         <44727d3cebda7bee5b68fb388bd2fecfc6dc7b89.camel@synopsys.com>
         <20180709144925.GU2476@hirez.programming.kicks-ass.net>
In-Reply-To: <20180709144925.GU2476@hirez.programming.kicks-ass.net>
Content-Language: en-US
Content-Type: text/plain; charset="utf-8"
Content-ID: <965FC01BD20DB94FB99BA57AF9B8ADFA@internal.synopsys.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: "peterz@infradead.org" <peterz@infradead.org>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "tglx@linutronix.de" <tglx@linutronix.de>, "linux-snps-arc@lists.infradead.org" <linux-snps-arc@lists.infradead.org>, "stable@vger.kernel.org" <stable@vger.kernel.org>, "will.deacon@arm.com" <will.deacon@arm.com>, "greg@kroah.com" <greg@kroah.com>, "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>, "David.Laight@ACULAB.COM" <David.Laight@ACULAB.COM>, Vineet Gupta <Vineet.Gupta1@synopsys.com>, "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>, "geert@linux-m68k.org" <geert@linux-m68k.org>
Message-ID: <20180709145336.xhlA0TbQlJsQljkrYoNpAgP9vnD2YR2GppmkQl8bBCw@z>

SGkgUGV0ZXIsDQoNCk9uIE1vbiwgMjAxOC0wNy0wOSBhdCAxNjo0OSArMDIwMCwgUGV0ZXIgWmlq
bHN0cmEgd3JvdGU6DQo+IE9uIE1vbiwgSnVsIDA5LCAyMDE4IGF0IDAyOjMzOjI2UE0gKzAwMDAs
IEFsZXhleSBCcm9ka2luIHdyb3RlOg0KPiA+ID4gSW4gZmFjdCwgc2luY2UgYWxsb2NfZHIoKSB1
c2VzIGttYWxsb2MoKSB0byBhbGxvY2F0ZSB0aGUgZW50aXJlIHRoaW5nLA0KPiA+ID4gaXQgaXMg
aW1wb3NzaWJsZSB0byBndWFyYW50ZWUgYSBsYXJnZXIgYWxpZ25tZW50IHRoYW4ga21hbGxvYyBk
b2VzLg0KPiA+IA0KPiA+IFdlbGwgYnV0IDQtYnl0ZXMgW3doaWNoIGlzIGNyaXRpY2FsIGZvciBh
dG9taWM2NF90XSBzaG91bGQgYmUgbXVjaCBsZXNzDQo+ID4gdGhhbiBhIHNhbmUgY2FjaGUgbGlu
ZSBsZW5ndGggc28gYWJvdmUgc2hvdWxkIHdvcmsuDQo+IA0KPiBBRkFJQ1QgQVJDSF9LTUFMTE9D
X01JTkFMSUdOIGVuZHMgdXAgYmVpbmcgNCBvbiB4ODZfMzIgKGl0IGRvZXNuJ3QNCj4gZGVmaW5l
IEFSQ0hfRE1BX01JTkFMSUdOIGFuZCBkb2Vzbid0IHNlZW0gdG8gb3RoZXJ3aXNlIG92ZXJyaWRl
IHRoZQ0KPiB0aGluZykuDQo+IA0KPiBTbyB1bmNvbmRpdGlvbmFsbHkgc2V0dGluZyB0aGUgYWxp
Z25tZW50IG9mIGRldnJlczo6ZGF0YSB0byA4IHNlZW1zDQo+IGJyb2tlbi4NCg0KV2VsbCBidXQg
dGhlbiB3aGF0IG90aGVyIG9wdGlvbnMgZG8gd2UgaGF2ZSB0byBmaXggYSBwcm9ibGVtIHdpdGgN
Cm1pc2FsaWduZWQgYWNjZXNzIHRvIGF0b21pYzY0X3QgaW4gZHJtX2dwdV9zY2hlZHVsZXI/DQoN
Ci1BbGV4ZXk=
