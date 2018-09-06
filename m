Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail-cys01nam02on0065.outbound.protection.outlook.com ([104.47.37.65]:15392
        "EHLO NAM02-CY1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725819AbeIGBe4 (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Thu, 6 Sep 2018 21:34:56 -0400
From: Nadav Amit <namit@vmware.com>
Subject: Re: [PATCH v2 1/6] Fix "x86/alternatives: Lockdep-enforce text_mutex
 in text_poke*()"
Date: Thu, 6 Sep 2018 20:57:38 +0000
Message-ID: <E8934715-B8B1-4E37-A37F-18D040885C4F@vmware.com>
References: <20180902173224.30606-1-namit@vmware.com>
 <20180902173224.30606-2-namit@vmware.com>
 <20180906194003.GD4816@worktop.programming.kicks-ass.net>
 <BD1F532F-1006-4CDC-9470-C8A91619E4DE@vmware.com>
 <20180906195351.GB9358@worktop.programming.kicks-ass.net>
 <D8CE0D88-9507-421C-9C97-ACAB05388F8D@vmware.com>
 <20180906202547.GC9358@worktop.programming.kicks-ass.net>
In-Reply-To: <20180906202547.GC9358@worktop.programming.kicks-ass.net>
Content-Language: en-US
Content-Type: text/plain; charset="utf-8"
Content-ID: <EEF9D4F61EC9694CB9241994A6E72CE0@namprd05.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Peter Zijlstra <peterz@infradead.org>
Cc: Thomas Gleixner <tglx@linutronix.de>, LKML <linux-kernel@vger.kernel.org>, Ingo Molnar <mingo@redhat.com>, X86 ML <x86@kernel.org>, Arnd Bergmann <arnd@arndb.de>, linux-arch <linux-arch@vger.kernel.org>, Dave Hansen <dave.hansen@linux.intel.com>, Jiri Kosina <jkosina@suse.cz>, Andy Lutomirski <luto@kernel.org>, Kees Cook <keescook@chromium.org>, Dave Hansen <dave.hansen@intel.com>
Message-ID: <20180906205738.MlLbE5h5r3F-B0q2CqOIDfKEKzhQvygpQ5dNHd4MBEc@z>

YXQgMToyNSBQTSwgUGV0ZXIgWmlqbHN0cmEgPHBldGVyekBpbmZyYWRlYWQub3JnPiB3cm90ZToN
Cg0KPiBPbiBUaHUsIFNlcCAwNiwgMjAxOCBhdCAwNzo1ODo0MFBNICswMDAwLCBOYWRhdiBBbWl0
IHdyb3RlOg0KPj4+IFdpdGggdGhhdCBDUjMgdHJpY2tlcnksIHdlIGNhbiByaWQgb3Vyc2VsdmVz
IG9mIHRoZSB0ZXh0X211dGV4DQo+Pj4gcmVxdWlyZW1lbnQsIHNpbmNlIGNvbmN1cnJlbnQgdGV4
dF9wb2tlIGlzICdzYWZlJy4gVGhhdCB3b3VsZCBjbGVhbiB1cA0KPj4+IHRoZSBrZ2RiIGNvZGUg
cXVpdGUgYSBiaXQuDQo+PiANCj4+IEkgZG9u4oCZdCBrbm93LiBJ4oCZbSBzb21ld2hhdCB3b3Jy
aWVkIHdpdGggbXVsdGlwbGUgbWVjaGFuaXNtcyBwb3RlbnRpYWxseQ0KPj4gY2hhbmdpbmcgdGhl
IHNhbWUgY29kZSBhdCB0aGUgc2FtZSB0aW1lIC0gYW5kIG1heWJlIGVuZGluZyB1cCB3aXRoIHNv
bWUNCj4+IG1lc3MuDQo+IA0KPiBrZ2RiIG9ubHkgcG9rZXMgSU5UMywgdGhhdCBzaG91bGQgYmUg
cHJldHR5IHNhZmUuDQoNCk1heWJlIEkgbWlzdW5kZXJzdGFuZCB5b3VyIHBvaW50LiBJZiB5b3Ug
d2FudCBtZSB0byBnZXQgcmlkIG9mIHRleHRfbXV0ZXgNCmNvbXBsZXRlbHksIEkgYW0gYWZyYWlk
IGl0IHdpbGwgYmUgYWJsZSB0byBjYXVzZSBtZXNzIGJ5IGNoYW5naW5nIHRoZSBzYW1lDQpwaWVj
ZSBvZiBjb2RlIHRocm91Z2gga3Byb2JlcyBhbmQgdGhlIHN0YXRpYy1rZXlzIG1lY2hhbmlzbS4N
Cg0KSSBkb3VidCBpdCB3b3VsZCB3b3JrIHRvZGF5IHdpdGhvdXQgZmFpbGluZywgYnV0IGdldHRp
bmcgcmlkIG9mIHRleHRfbXV0ZXgNCmlzIGxpa2VseSB0byBtYWtlIGl0IGV2ZW4gd29yc2UuDQoN
Cg==
