Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from smtprelay.synopsys.com ([198.182.47.9]:54584 "EHLO
        smtprelay.synopsys.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729167AbeH3Ssv (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 30 Aug 2018 14:48:51 -0400
From: Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>
Subject: Re: Patch "asm-generic/bitops/lock.h: Rewrite using atomic_fetch_"
 causes kernel crash
Date: Thu, 30 Aug 2018 14:46:16 +0000
Message-ID: <1535640375.4465.68.camel@synopsys.com>
References: <1535567633.4465.23.camel@synopsys.com>
         <C2D7FE5348E1B147BCA15975FBA23075012B090BEA@us01wembx1.internal.synopsys.com>
         <20180830094411.GX24124@hirez.programming.kicks-ass.net>
         <20180830095148.GB5942@arm.com> <1535629996.4465.44.camel@synopsys.com>
         <20180830141713.GN24082@hirez.programming.kicks-ass.net>
In-Reply-To: <20180830141713.GN24082@hirez.programming.kicks-ass.net>
Content-Language: en-US
Content-Type: text/plain; charset="utf-8"
Content-ID: <244CAC2AC2A4F0498C22EA8E008B89D6@internal.synopsys.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: "peterz@infradead.org" <peterz@infradead.org>, "Eugeniy.Paltsev@synopsys.com" <Eugeniy.Paltsev@synopsys.com>
Cc: "mingo@kernel.org" <mingo@kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "Alexey.Brodkin@synopsys.com" <Alexey.Brodkin@synopsys.com>, "Vineet.Gupta1@synopsys.com" <Vineet.Gupta1@synopsys.com>, "tglx@linutronix.de" <tglx@linutronix.de>, "linux-snps-arc@lists.infradead.org" <linux-snps-arc@lists.infradead.org>, "yamada.masahiro@socionext.com" <yamada.masahiro@socionext.com>, "will.deacon@arm.com" <will.deacon@arm.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>
Message-ID: <20180830144616.cD9QKy15lph4j95Zo3Cw5PVprQhGZx6_b5XlpQ9K2ZA@z>

T24gVGh1LCAyMDE4LTA4LTMwIGF0IDE2OjE3ICswMjAwLCBQZXRlciBaaWpsc3RyYSB3cm90ZToN
Cj4gT24gVGh1LCBBdWcgMzAsIDIwMTggYXQgMTE6NTM6MTdBTSArMDAwMCwgRXVnZW5peSBQYWx0
c2V2IHdyb3RlOg0KPiA+IEkgY2FuIHNlZSBjcmFzaGVzIHdpdGggTExTQyBlbmFibGVkIGluIGJv
dGggU01QIHJ1bm5pbmcgb24gNCBjb3Jlcw0KPiA+IGFuZCBTTVAgcnVubmluZyBvbiAxIGNvcmUu
DQo+IA0KPiBTbyB5b3UncmUgcnVubmluZyBvbiBMTC9TQyBlbmFibGVkIGhhcmR3YXJlOyB0aGF0
IHdvdWxkIG1ha2UgV2lsbCdzDQo+IHBhdGNoIGlycmVsZXZhbnQgKGFsdGhvdWdoIHN0aWxsIGEg
Z29vZCBpZGVhIGZvciB0aGUgaGFyZHdhcmUgdGhhdCBkb2VzDQo+IGNhcmUgYWJvdXQgdGhhdCBz
cGlubG9ja2VkIGF0b21pYyBjcnVkKS4NCj4gDQo+IERvZXMgc29tZXRoaW5nIGxpa2UgdGhlIGJl
bG93IGN1cmUgdGhpbmdzPyBUaGF0IHdvdWxkIGNvbmZpcm0gdGhlDQo+IHN1Z2dlc3Rpb24gdGhh
dCB0aGUgY2hhbmdlIHRvIF9fY2xlYXJfYml0X3VubG9jaygpIGlzIHRoZSBjdXJwcml0Lg0KDQpJ
IHRlc3RlZCBpdCAtIHRoaXMgZG9lc24ndCBjaGFuZ2UgYW55dGhpbmcsIHRoZSBwcm9ibGVtIHN0
aWxsIHJlcHJvZHVjZXMuDQoNCkknbGwgdGVzdCBpdCB3aXRoIGxhc3QgV2lsbCBmaXguDQoNCg0K
PiBJZiB0aGF0IGRvZXNuJ3QgY3VyZSB0aGluZ3MsIHRoZW4gd2UndmUgYmVlbiBsb29raW5nIGlu
IGVudGlyZWx5IHRoZQ0KPiB3cm9uZyBwbGFjZS4NCj4gDQo+IC0tLQ0KPiBkaWZmIC0tZ2l0IGEv
aW5jbHVkZS9hc20tZ2VuZXJpYy9iaXRvcHMvbG9jay5oIGIvaW5jbHVkZS9hc20tZ2VuZXJpYy9i
aXRvcHMvbG9jay5oDQo+IGluZGV4IDNhZTAyMTM2OGY0OC4uNzljNjk3ODE1MmY4IDEwMDY0NA0K
PiAtLS0gYS9pbmNsdWRlL2FzbS1nZW5lcmljL2JpdG9wcy9sb2NrLmgNCj4gKysrIGIvaW5jbHVk
ZS9hc20tZ2VuZXJpYy9iaXRvcHMvbG9jay5oDQo+IEBAIC01NywxMiArNTcsNyBAQCBzdGF0aWMg
aW5saW5lIHZvaWQgY2xlYXJfYml0X3VubG9jayh1bnNpZ25lZCBpbnQgbnIsIHZvbGF0aWxlIHVu
c2lnbmVkIGxvbmcgKnApDQo+ICBzdGF0aWMgaW5saW5lIHZvaWQgX19jbGVhcl9iaXRfdW5sb2Nr
KHVuc2lnbmVkIGludCBuciwNCj4gIAkJCQkgICAgICB2b2xhdGlsZSB1bnNpZ25lZCBsb25nICpw
KQ0KPiAgew0KPiAtCXVuc2lnbmVkIGxvbmcgb2xkOw0KPiAtDQo+IC0JcCArPSBCSVRfV09SRChu
cik7DQo+IC0Jb2xkID0gUkVBRF9PTkNFKCpwKTsNCj4gLQlvbGQgJj0gfkJJVF9NQVNLKG5yKTsN
Cj4gLQlhdG9taWNfbG9uZ19zZXRfcmVsZWFzZSgoYXRvbWljX2xvbmdfdCAqKXAsIG9sZCk7DQo+
ICsJY2xlYXJfYml0X3VubG9jayhuciwgcCk7DQo+ICB9DQo+ICANCj4gIC8qKg0KLS0gDQogRXVn
ZW5peSBQYWx0c2V2
