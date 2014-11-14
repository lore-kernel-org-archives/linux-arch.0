Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mx0.aculab.com ([213.249.233.131]:33219 "HELO mx0.aculab.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S965115AbaKNKqK (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Fri, 14 Nov 2014 05:46:10 -0500
Received: from mx0.aculab.com ([127.0.0.1])
 by localhost (mx0.aculab.com [127.0.0.1]) (amavisd-new, port 10024) with SMTP
 id 25369-08 for <linux-arch@vger.kernel.org>;
 Fri, 14 Nov 2014 10:45:59 +0000 (GMT)
From: David Laight <David.Laight@ACULAB.COM>
Subject: RE: [PATCH 1/3] arch: Introduce load_acquire() and store_release()
Date: Fri, 14 Nov 2014 10:45:41 +0000
Message-ID: <063D6719AE5E284EB5DD2968C1650D6D1C9F0780@AcuExch.aculab.com>
References: <20141113191250.12579.19694.stgit@ahduyck-server>
 <20141113192723.12579.25343.stgit@ahduyck-server>
In-Reply-To: <20141113192723.12579.25343.stgit@ahduyck-server>
Content-Language: en-US
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: 'Alexander Duyck' <alexander.h.duyck@redhat.com>, "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>, "netdev@vger.kernel.org" <netdev@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Cc: "mikey@neuling.org" <mikey@neuling.org>, "tony.luck@intel.com" <tony.luck@intel.com>, "mathieu.desnoyers@polymtl.ca" <mathieu.desnoyers@polymtl.ca>, "donald.c.skidmore@intel.com" <donald.c.skidmore@intel.com>, "peterz@infradead.org" <peterz@infradead.org>, "benh@kernel.crashing.org" <benh@kernel.crashing.org>, "heiko.carstens@de.ibm.com" <heiko.carstens@de.ibm.com>, "oleg@redhat.com" <oleg@redhat.com>, "will.deacon@arm.com" <will.deacon@arm.com>, "davem@davemloft.net" <davem@davemloft.net>, "michael@ellerman.id.au" <michael@ellerman.id.au>, "matthew.vick@intel.com" <matthew.vick@intel.com>, "nic_swsd@realtek.com" <nic_swsd@realtek.com>, "geert@linux-m68k.org" <geert@linux-m68k.org>, "jeffrey.t.kirsher@intel.com" <jeffrey.t.kirsher@intel.com>, "fweisbec@gmail.com" <fweisbec@gmail.com>, "schwidefsky@de.ibm.com" <schwidefsky@de.ibm.com>, "linux@arm.linux.org.uk" <linux@arm.linux.org.uk>, "paulmck@linux.vnet.ibm.com" <paulmck@linux.vnet.ibm.com>, "torvalds@linux-foundation.org" <torvalds@linux-foundation.org>, "mingo@kernel.org" <mingo@kernel.org>
Message-ID: <20141114104541.RkgxJADF-6jCV6N77OYXRlYXgt0XzsA92S2pkTjPOqI@z>

RnJvbTogQWxleGFuZGVyIER1eWNrDQo+IEl0IGlzIGNvbW1vbiBmb3IgZGV2aWNlIGRyaXZlcnMg
dG8gbWFrZSB1c2Ugb2YgYWNxdWlyZS9yZWxlYXNlIHNlbWFudGljcw0KPiB3aGVuIGRlYWxpbmcg
d2l0aCBkZXNjcmlwdG9ycyBzdG9yZWQgaW4gZGV2aWNlIG1lbW9yeS4gIE9uIHJldmlld2luZyB0
aGUNCj4gZG9jdW1lbnRhdGlvbiBhbmQgY29kZSBmb3Igc21wX2xvYWRfYWNxdWlyZSgpIGFuZCBz
bXBfc3RvcmVfcmVsZWFzZSgpIGFzDQo+IHdlbGwgYXMgcmV2aWV3aW5nIGFuIElCTSB3ZWJzaXRl
IHRoYXQgZ29lcyBvdmVyIHRoZSB1c2Ugb2YgUG93ZXJQQyBiYXJyaWVycw0KPiBhdCBodHRwOi8v
d3d3LmlibS5jb20vZGV2ZWxvcGVyd29ya3Mvc3lzdGVtcy9hcnRpY2xlcy9wb3dlcnBjLmh0bWwg
aXQNCj4gb2NjdXJyZWQgdG8gbWUgdGhhdCB0aGUgc2FtZSBjb2RlIGNvdWxkIGxpa2VseSBiZSBh
cHBsaWVkIHRvIGRldmljZSBkcml2ZXJzLg0KPiANCj4gQXMgYSByZXN1bHQgdGhpcyBwYXRjaCBp
bnRyb2R1Y2VzIGxvYWRfYWNxdWlyZSgpIGFuZCBzdG9yZV9yZWxlYXNlKCkuICBUaGUNCj4gbG9h
ZF9hY3F1aXJlKCkgZnVuY3Rpb24gY2FuIGJlIHVzZWQgaW4gdGhlIHBsYWNlIG9mIHNpdHVhdGlv
bnMgd2hlcmUgYSB0ZXN0DQo+IGZvciBvd25lcnNoaXAgbXVzdCBiZSBmb2xsb3dlZCBieSBhIG1l
bW9yeSBiYXJyaWVyLiAgVGhlIGJlbG93IGV4YW1wbGUgaXMNCj4gZnJvbSBpeGdiZToNCj4gDQo+
IAlpZiAoIXJ4X2Rlc2MtPndiLnVwcGVyLnN0YXR1c19lcnJvcikNCj4gCQlicmVhazsNCj4gDQo+
IAkvKiBUaGlzIG1lbW9yeSBiYXJyaWVyIGlzIG5lZWRlZCB0byBrZWVwIHVzIGZyb20gcmVhZGlu
Zw0KPiAJICogYW55IG90aGVyIGZpZWxkcyBvdXQgb2YgdGhlIHJ4X2Rlc2MgdW50aWwgd2Uga25v
dyB0aGUNCj4gCSAqIGRlc2NyaXB0b3IgaGFzIGJlZW4gd3JpdHRlbiBiYWNrDQo+IAkgKi8NCj4g
CXJtYigpOw0KPiANCj4gV2l0aCBsb2FkX2FjcXVpcmUoKSB0aGlzIGNhbiBiZSBjaGFuZ2VkIHRv
Og0KPiANCj4gCWlmICghbG9hZF9hY3F1aXJlKCZyeF9kZXNjLT53Yi51cHBlci5zdGF0dXNfZXJy
b3IpKQ0KPiAJCWJyZWFrOw0KDQpJZiBJJ20gcXVpY2tseSByZWFkaW5nIHRoZSAnbmV3JyBjb2Rl
IEkgbmVlZCB0byBsb29rIHVwIHlldCBhbm90aGVyDQpmdW5jdGlvbiwgd2l0aCB0aGUgJ29sZCcg
Y29kZSBJIGNhbiBlYXNpbHkgc2VlIHRoZSBsb2dpYy4NCg0KWW91J3ZlIGFsc28gYWRkZWQgYSBt
ZW1vcnkgYmFycmllciB0byB0aGUgJ2JyZWFrJyBwYXRoIC0gd2hpY2ggaXNuJ3QgbmVlZGVkLg0K
DQpUaGUgZHJpdmVyIG1pZ2h0IGFsc28gaGF2ZSBhZGRpdGlvbmFsIGNvZGUgdGhhdCBjYW4gYmUg
YWRkZWQgYmVmb3JlIHRoZSBiYXJyaWVyDQpzbyByZWR1Y2luZyB0aGUgY29zdCBvZiB0aGUgYmFy
cmllci4NCg0KVGhlIGRyaXZlciBtYXkgYWxzbyBiZSBhYmxlIHRvIHBlcmZvcm0gbXVsdGlwbGUg
YWN0aW9ucyBiZWZvcmUgYSBiYXJyaWVyIGlzIG5lZWRlZC4NCg0KSGlkaW5nIGJhcnJpZXJzIGlz
bid0IG5lY2Vzc2FyaWx5IGEgZ29vZCBpZGVhIGFueXdheS4NCklmIHlvdSBhcmUgd3JpdGluZyBh
IGRyaXZlciB5b3UgbmVlZCB0byB1bmRlcnN0YW5kIHdoZW4gYW5kIHdoZXJlIHRoZXkgYXJlIG5l
ZWRlZC4NCg0KTWF5YmUgeW91IG5lZWQgYSBuZXcgKHdlYWtlcikgYmFycmllciB0byByZXBsYWNl
IHJtYigpIG9uIHNvbWUgYXJjaGl0ZWN0dXJlcy4NCg0KLi4uDQoNCg0KCURhdmlkDQoNCg==
