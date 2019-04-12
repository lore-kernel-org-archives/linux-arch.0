Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail-eopbgr750059.outbound.protection.outlook.com ([40.107.75.59]:54084
        "EHLO NAM02-BL2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726815AbfDLTmn (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Fri, 12 Apr 2019 15:42:43 -0400
From: Nadav Amit <namit@vmware.com>
Subject: Re: 1808d65b55 ("asm-generic/tlb: Remove arch_tlb*_mmu()"):  BUG:
 KASAN: stack-out-of-bounds in __change_page_attr_set_clr
Date: Fri, 12 Apr 2019 19:42:37 +0000
Message-ID: <721948C9-0E56-4E70-B9C5-58F0A4A5C126@vmware.com>
References: <5cae03c4.iIPk2cWlfmzP0Zgy%lkp@intel.com>
 <20190411193906.GA12232@hirez.programming.kicks-ass.net>
 <20190411195424.GL14281@hirez.programming.kicks-ass.net>
 <20190411211348.GA8451@worktop.programming.kicks-ass.net>
 <20190412105633.GM14281@hirez.programming.kicks-ass.net>
 <20190412111756.GO14281@hirez.programming.kicks-ass.net>
 <F18AF0D5-D8B4-4F4B-8469-F9DEC49683C7@vmware.com>
 <20190412181930.GD12232@hirez.programming.kicks-ass.net>
In-Reply-To: <20190412181930.GD12232@hirez.programming.kicks-ass.net>
Content-Language: en-US
Content-Type: text/plain; charset="utf-8"
Content-ID: <B2CC06664A851F43A6C8D26D535F1709@namprd05.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Peter Zijlstra <peterz@infradead.org>
Cc: kernel test robot <lkp@intel.com>, LKP <lkp@01.org>, Linux List Kernel Mailing <linux-kernel@vger.kernel.org>, Linux-MM <linux-mm@kvack.org>, linux-arch <linux-arch@vger.kernel.org>, Ingo Molnar <mingo@kernel.org>, Thomas Gleixner <tglx@linutronix.de>, Will Deacon <will.deacon@arm.com>, Andy Lutomirski <luto@kernel.org>, Linus Torvalds <torvalds@linux-foundation.org>, Dave Hansen <dave.hansen@intel.com>
Message-ID: <20190412194237.e469PYaiLeLTdYC1e1lr0VnNT9YdY40lz915s7Uj2Uo@z>

PiBPbiBBcHIgMTIsIDIwMTksIGF0IDExOjE5IEFNLCBQZXRlciBaaWpsc3RyYSA8cGV0ZXJ6QGlu
ZnJhZGVhZC5vcmc+IHdyb3RlOg0KPiANCj4gT24gRnJpLCBBcHIgMTIsIDIwMTkgYXQgMDM6MTE6
MjJQTSArMDAwMCwgTmFkYXYgQW1pdCB3cm90ZToNCj4+PiBPbiBBcHIgMTIsIDIwMTksIGF0IDQ6
MTcgQU0sIFBldGVyIFppamxzdHJhIDxwZXRlcnpAaW5mcmFkZWFkLm9yZz4gd3JvdGU6DQo+IA0K
Pj4+IFRvIGNsYXJpZnksICd0aGF0JyBpcyBOYWRhdidzIHBhdGNoOg0KPj4+IA0KPj4+IDUxNWFi
N2M0MTMwNiAoIng4Ni9tbTogQWxpZ24gVExCIGludmFsaWRhdGlvbiBpbmZvIikNCj4+PiANCj4+
PiB3aGljaCB0dXJucyBvdXQgdG8gYmUgdGhlIHJlYWwgcHJvYmxlbS4NCj4+IA0KPj4gU29ycnkg
Zm9yIHRoYXQuIEkgc3RpbGwgdGhpbmsgaXQgc2hvdWxkIGJlIGFsaWduZWQsIGVzcGVjaWFsbHkg
d2l0aCBhbGwgdGhlDQo+PiBlZmZvcnQgdGhlIEludGVsIHB1dHMgYXJvdW5kIHRvIGF2b2lkIGJ1
cy1sb2NraW5nIG9uIHVuYWxpZ25lZCBhdG9taWMNCj4+IG9wZXJhdGlvbnMuDQo+IA0KPiBObyBh
dG9taWNzIGFueXdoZXJlIGluIHNpZ2h0LCBzbyB0aGF0J3Mgbm90IGEgY29uY2Vybi4NCg0KWW91
IGFyZSByaWdodC4gSSBzdGlsbCB0aGluayB0aGF0IGF0IGxlYXN0IFRMQi13aXNlIGl0IHNob3Vs
ZCBiZSBiZXR0ZXIgdG8NCmhhdmUgdGhlIGFyZ3VtZW50IG9mZi1zdGFjay4gSeKAmWxsIHRyeSB0
byBydW4gc29tZSBleHBlcmltZW50cywgYmFzZWQgb24NCnlvdXIgZmVlZGJhY2ssIGFuZCBzZW5k
IGEgcGF0Y2ggb24gdG9wIG9mIHlvdXIgcmV2ZXJ0Lg0KDQpTb3JyeSBmb3IgdGhlIG1lc3MsIGFn
YWluLg0KDQoNCg==
