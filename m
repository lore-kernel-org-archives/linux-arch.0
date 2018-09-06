From: Nadav Amit <namit@vmware.com>
Subject: Re: [PATCH v2 0/6] x86/alternatives: text_poke() fixes
Date: Thu, 6 Sep 2018 18:38:30 +0000
Message-ID: <9F76711C-393C-4F8D-B460-26D400458690@vmware.com>
References: <20180902173224.30606-1-namit@vmware.com>
 <20180905185617.GC24082@hirez.programming.kicks-ass.net>
 <8D3CE999-6D3A-4984-934A-634BDD8AC25A@vmware.com>
 <6B256AB7-0158-47DF-B2D5-4C835579F3A3@vmware.com>
 <20180906081300.GF24082@hirez.programming.kicks-ass.net>
 <20180906101641.GG24142@hirez.programming.kicks-ass.net>
 <6703CD9F-2D84-4449-A423-A4DC24677673@vmware.com>
 <20180906171754.GJ24106@hirez.programming.kicks-ass.net>
 <9AF220A3-D783-442E-8E5B-AD0150628347@vmware.com>
 <32902EEE-FF64-4C12-A043-1848CC927C88@amacapital.net>
 <20180906183157.GK24106@hirez.programming.kicks-ass.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180906183157.GK24106@hirez.programming.kicks-ass.net>
Content-Language: en-US
Content-ID: <5EC0BAB23E8708448EC3299616BDBDBD@namprd05.prod.outlook.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Peter Zijlstra <peterz@infradead.org>, Andy Lutomirski <luto@amacapital.net>
Cc: Thomas Gleixner <tglx@linutronix.de>, LKML <linux-kernel@vger.kernel.org>, Ingo Molnar <mingo@redhat.com>, X86 ML <x86@kernel.org>, Arnd Bergmann <arnd@arndb.de>, linux-arch <linux-arch@vger.kernel.org>, Dave Hansen <dave.hansen@linux.intel.com>, Jiri Kosina <jkosina@suse.cz>, Andy Lutomirski <luto@kernel.org>, Masami Hiramatsu <mhiramat@kernel.org>, Kees Cook <keescook@chromium.org>
List-Id: linux-arch.vger.kernel.org

YXQgMTE6MzEgQU0sIFBldGVyIFppamxzdHJhIDxwZXRlcnpAaW5mcmFkZWFkLm9yZz4gd3JvdGU6
DQoNCj4gT24gVGh1LCBTZXAgMDYsIDIwMTggYXQgMTE6MDk6MjNBTSAtMDcwMCwgQW5keSBMdXRv
bWlyc2tpIHdyb3RlOg0KPj4+IE9uIFNlcCA2LCAyMDE4LCBhdCAxMDo1OCBBTSwgTmFkYXYgQW1p
dCA8bmFtaXRAdm13YXJlLmNvbT4gd3JvdGU6DQo+Pj4gSXQgZGVwZW5kcyB3aGF0IHNlY3VyaXR5
IHlvdSB3YW50LiBTb21lIG1heSBjb25zaWRlciBldmVuIHRoZSBzaG9ydA0KPj4+IHRpbWUtd2lu
ZG93IGluIHdoaWNoIHRoZSBrZXJuZWwgY29kZSBpcyB3cml0YWJsZSBmcm9tIG90aGVyIGNvcmVz
IGFzDQo+Pj4gaW5zdWZmaWNpZW50IGZvciBzZWN1cml0eS4NCj4+PiANCj4+PiBJbiBhZGRpdGlv
biwgdGhlIHNldCByZW1vdmVzIHRoZSBuZWVkIGZvciByZW1vdGUgVExCIHNob290ZG93bnMgdGhh
dA0KPj4+IHRleHRfcG9rZSgpIC0gd2l0aCB0aGlzIGZpeCAtIHJlcXVpcmVzLg0KPj4gDQo+PiBJ
4oCZbSBwZXJzb25hbGx5IGluIGZhdm9yIG9mIG5vdCBuZWVkaW5nIGEgZ2xvYmFsIGJyb2FkY2Fz
dCBmbHVzaCB0byBpbnN0YWxsIGtwcm9iZXMuDQo+IA0KPiBUaGF0J3MgZmluZS4gQnV0IGF0IHRo
YXQgcG9pbnQgaXRzIGFuIG9wdGltaXphdGlvbiwgbm90IGEgY29ycmVjdG5lc3MNCj4gaXNzdWUu
DQoNCk5vdGUgdGhhdCBwYXRjaCAxLzYgaXMgc3RpbGwgbmVlZGVkIHRvIGZpeCBmYWxzZSBsb2Nr
ZGVwIHNob3V0b3V0cyBkdWUgdG8gYQ0KcmVjZW50IHBhdGNoLg0KDQo=
