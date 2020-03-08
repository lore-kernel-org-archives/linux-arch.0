Return-Path: <SRS0=iRyw=4Z=vger.kernel.org=linux-arch-owner@kernel.org>
Received: from mx0a-0016f401.pphosted.com ([67.231.148.174]:40434 "EHLO
        mx0b-0016f401.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726055AbgCHGtd (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Sun, 8 Mar 2020 01:49:33 -0500
From: Alex Belits <abelits@marvell.com>
Subject: Re: [EXT] Re: [PATCH 11/12] task_isolation: kick_all_cpus_sync: don't
 kick isolated cpus
Date: Sun, 8 Mar 2020 06:48:43 +0000
Message-ID: <7e0ce8988f4811e7453859e22654d2618557d9ab.camel@marvell.com>
References: <4473787e1b6bc3cc226067e8d122092a678b63de.camel@marvell.com>
         <dfa5e0e9f34e6ff0ef048c81bc70496354f31300.camel@marvell.com>
         <20200306153446.GC8590@lenoir>
In-Reply-To: <20200306153446.GC8590@lenoir>
Content-Language: en-US
Content-Type: text/plain; charset="utf-8"
Content-ID: <22B91EB6759F5E429B9A26A5E13F7A1A@namprd18.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: "frederic@kernel.org" <frederic@kernel.org>
Cc: "mingo@kernel.org" <mingo@kernel.org>, "peterz@infradead.org" <peterz@infradead.org>, "rostedt@goodmis.org" <rostedt@goodmis.org>, Prasun Kapoor <pkapoor@marvell.com>, "tglx@linutronix.de" <tglx@linutronix.de>, "linux-api@vger.kernel.org" <linux-api@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "catalin.marinas@arm.com" <catalin.marinas@arm.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "netdev@vger.kernel.org" <netdev@vger.kernel.org>, "davem@davemloft.net" <davem@davemloft.net>, "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>, "will@kernel.org" <will@kernel.org>
Message-ID: <20200308064843.VI3HIXNuN7zINVfFV6KbU0JMw-30jR5B5E9kIKKGiSk@z>

T24gRnJpLCAyMDIwLTAzLTA2IGF0IDE2OjM0ICswMTAwLCBGcmVkZXJpYyBXZWlzYmVja2VyIHdy
b3RlOg0KPiBPbiBXZWQsIE1hciAwNCwgMjAyMCBhdCAwNDoxNToyNFBNICswMDAwLCBBbGV4IEJl
bGl0cyB3cm90ZToNCj4gPiBGcm9tOiBZdXJpIE5vcm92IDx5bm9yb3ZAbWFydmVsbC5jb20+DQo+
ID4gDQo+ID4gTWFrZSBzdXJlIHRoYXQga2lja19hbGxfY3B1c19zeW5jKCkgZG9lcyBub3QgY2Fs
bCBDUFVzIHRoYXQgYXJlDQo+ID4gcnVubmluZw0KPiA+IGlzb2xhdGVkIHRhc2tzLg0KPiA+IA0K
PiA+IFNpZ25lZC1vZmYtYnk6IEFsZXggQmVsaXRzIDxhYmVsaXRzQG1hcnZlbGwuY29tPg0KPiA+
IC0tLQ0KPiA+ICBrZXJuZWwvc21wLmMgfCAxNCArKysrKysrKysrKysrLQ0KPiA+ICAxIGZpbGUg
Y2hhbmdlZCwgMTMgaW5zZXJ0aW9ucygrKSwgMSBkZWxldGlvbigtKQ0KPiA+IA0KPiA+IGRpZmYg
LS1naXQgYS9rZXJuZWwvc21wLmMgYi9rZXJuZWwvc21wLmMNCj4gPiBpbmRleCAzYThiY2JkZDRj
ZTYuLmQ5YjRiMmZlZGZlZCAxMDA2NDQNCj4gPiAtLS0gYS9rZXJuZWwvc21wLmMNCj4gPiArKysg
Yi9rZXJuZWwvc21wLmMNCj4gPiBAQCAtNzMxLDkgKzczMSwyMSBAQCBzdGF0aWMgdm9pZCBkb19u
b3RoaW5nKHZvaWQgKnVudXNlZCkNCj4gPiAgICovDQo+ID4gIHZvaWQga2lja19hbGxfY3B1c19z
eW5jKHZvaWQpDQo+ID4gIHsNCj4gPiArCXN0cnVjdCBjcHVtYXNrIG1hc2s7DQo+ID4gKw0KPiA+
ICAJLyogTWFrZSBzdXJlIHRoZSBjaGFuZ2UgaXMgdmlzaWJsZSBiZWZvcmUgd2Uga2ljayB0aGUg
Y3B1cyAqLw0KPiA+ICAJc21wX21iKCk7DQo+ID4gLQlzbXBfY2FsbF9mdW5jdGlvbihkb19ub3Ro
aW5nLCBOVUxMLCAxKTsNCj4gPiArDQo+ID4gKwlwcmVlbXB0X2Rpc2FibGUoKTsNCj4gPiArI2lm
ZGVmIENPTkZJR19UQVNLX0lTT0xBVElPTg0KPiA+ICsJY3B1bWFza19jbGVhcigmbWFzayk7DQo+
ID4gKwl0YXNrX2lzb2xhdGlvbl9jcHVtYXNrKCZtYXNrKTsNCj4gPiArCWNwdW1hc2tfY29tcGxl
bWVudCgmbWFzaywgJm1hc2spOw0KPiA+ICsjZWxzZQ0KPiA+ICsJY3B1bWFza19zZXRhbGwoJm1h
c2spOw0KPiA+ICsjZW5kaWYNCj4gPiArCXNtcF9jYWxsX2Z1bmN0aW9uX21hbnkoJm1hc2ssIGRv
X25vdGhpbmcsIE5VTEwsIDEpOw0KPiA+ICsJcHJlZW1wdF9lbmFibGUoKTsNCj4gPiAgfQ0KPiAN
Cj4gVGhhdCBsb29rcyB2ZXJ5IGRhbmdlcm91cywgdGhlIGNhbGxlcnMgb2Yga2lja19hbGxfY3B1
c19zeW5jKCkgd2FudA0KPiB0bw0KPiBzeW5jIGFsbCBDUFVzIGZvciBhIHJlYXNvbi4gWW91IHdp
bGwgcmF0aGVyIG5lZWQgdG8gZml4IHRoZSBjYWxsZXJzLg0KDQpBbGwgY2FsbGVycyBvZiB0aGlz
IHVzZSB0aGlzIGZ1bmN0aW9uIHRvIHN5bmNocm9uaXplIElQSXMgYW5kIGljYWNoZSwNCmFuZCB0
aGV5IGhhdmUgbm8gaWRlYSBpZiB0aGVyZSBpcyBhbnl0aGluZyBzcGVjaWFsIGFib3V0IHRoZSBz
dGF0ZSBvZg0KQ1BVcy4gSWYgYSB0YXNrIGlzIGlzb2xhdGVkLCB0aGlzIGNhbGwgd291bGQgbm90
IGJlIG5lY2Vzc2FyeSBiZWNhdXNlDQp0aGUgdGFzayBpcyBpbiB1c2Vyc3BhY2UsIGFuZCBpdCB3
b3VsZCBoYXZlIHRvIGVudGVyIGtlcm5lbCBmb3IgYW55IG9mDQp0aGF0IHRvIGJlY29tZSByZWxl
dmFudCBidXQgdGhlbiBpdCB3aWxsIGhhdmUgdG8gc3dpdGNoIGZyb20gdXNlcnNwYWNlDQp0byBr
ZXJuZWwuIEF0IHdvcnN0IGl0IGlzIHJldHVybmluZyB0byB1c2Vyc3BhY2UgYWZ0ZXIgZW50ZXJp
bmcNCmlzb2xhdGlvbiBvciBiYWNrIGluIGtlcm5lbCBydW5uaW5nIGNsZWFudXAgYWZ0ZXIgaXNv
bGF0aW9uIGlzIGJyb2tlbg0KYnV0IGJlZm9yZSB0c2tfdGhyZWFkX2ZsYWdzX2NhY2hlIGlzIHVw
ZGF0ZWQuIFRoZXJlIHdpbGwgYmUgbm90aGluZyB0bw0KcnVuIG9uIHRoZSBzYW1lIENQVSBiZWNh
dXNlIHdlIGhhdmUganVzdCBsZWZ0IGlzb2xhdGlvbiwgc28gdGFzayB3aWxsDQplaXRoZXIgZXhp
dCBvciBnbyBiYWNrIHRvIHVzZXJzcGFjZS4NCg0KSXMgdGhlcmUgYW55IHJlYXNvbiBmb3IgYSBy
YWNlIGF0IHRoYXQgcG9pbnQ/DQoNCj4gVGhhbmtzLg0KPiANCj4gPiAgRVhQT1JUX1NZTUJPTF9H
UEwoa2lja19hbGxfY3B1c19zeW5jKTsNCj4gPiAgDQo+ID4gLS0gDQo+ID4gMi4yMC4xDQo+ID4g
DQoNCi0tIA0KQWxleA0K
