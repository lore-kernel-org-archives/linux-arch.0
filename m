Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail-eopbgr710066.outbound.protection.outlook.com ([40.107.71.66]:65263
        "EHLO NAM05-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727955AbeIGAfo (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Thu, 6 Sep 2018 20:35:44 -0400
From: Nadav Amit <namit@vmware.com>
Subject: Re: [PATCH v2 1/6] Fix "x86/alternatives: Lockdep-enforce text_mutex
 in text_poke*()"
Date: Thu, 6 Sep 2018 19:58:40 +0000
Message-ID: <D8CE0D88-9507-421C-9C97-ACAB05388F8D@vmware.com>
References: <20180902173224.30606-1-namit@vmware.com>
 <20180902173224.30606-2-namit@vmware.com>
 <20180906194003.GD4816@worktop.programming.kicks-ass.net>
 <BD1F532F-1006-4CDC-9470-C8A91619E4DE@vmware.com>
 <20180906195351.GB9358@worktop.programming.kicks-ass.net>
In-Reply-To: <20180906195351.GB9358@worktop.programming.kicks-ass.net>
Content-Language: en-US
Content-Type: text/plain; charset="utf-8"
Content-ID: <EC9E11FA9D12524082AA5BC914F4E697@namprd05.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Peter Zijlstra <peterz@infradead.org>
Cc: Thomas Gleixner <tglx@linutronix.de>, LKML <linux-kernel@vger.kernel.org>, Ingo Molnar <mingo@redhat.com>, X86 ML <x86@kernel.org>, Arnd Bergmann <arnd@arndb.de>, linux-arch <linux-arch@vger.kernel.org>, Dave Hansen <dave.hansen@linux.intel.com>, Jiri Kosina <jkosina@suse.cz>, Andy Lutomirski <luto@kernel.org>, Kees Cook <keescook@chromium.org>, Dave Hansen <dave.hansen@intel.com>
Message-ID: <20180906195840.IvuAJJN1XVoDaHIRuRw271fkaBQJfFNmlnBdZ9lOwSw@z>

YXQgMTI6NTMgUE0sIFBldGVyIFppamxzdHJhIDxwZXRlcnpAaW5mcmFkZWFkLm9yZz4gd3JvdGU6
DQoNCj4gT24gVGh1LCBTZXAgMDYsIDIwMTggYXQgMDc6NDI6MTRQTSArMDAwMCwgTmFkYXYgQW1p
dCB3cm90ZToNCj4+IGF0IDEyOjQwIFBNLCBQZXRlciBaaWpsc3RyYSA8cGV0ZXJ6QGluZnJhZGVh
ZC5vcmc+IHdyb3RlOg0KPj4gDQo+Pj4gT24gU3VuLCBTZXAgMDIsIDIwMTggYXQgMTA6MzI6MTlB
TSAtMDcwMCwgTmFkYXYgQW1pdCB3cm90ZToNCj4+Pj4gdGV4dF9tdXRleCBpcyBleHBlY3RlZCB0
byBiZSBoZWxkIGJlZm9yZSB0ZXh0X3Bva2UoKSBpcyBjYWxsZWQsIGJ1dCB3ZQ0KPj4+PiBjYW5u
b3QgYWRkIGEgbG9ja2RlcCBhc3NlcnRpb24gc2luY2Uga2dkYiBkb2VzIG5vdCB0YWtlIGl0LCBh
bmQgaW5zdGVhZA0KPj4+PiAqc3VwcG9zZWRseSogZW5zdXJlcyB0aGUgbG9jayBpcyBub3QgdGFr
ZW4gYW5kIHdpbGwgbm90IGJlIGFjcXVpcmVkIGJ5DQo+Pj4+IGFueSBvdGhlciBjb3JlIHdoaWxl
IHRleHRfcG9rZSgpIGlzIHJ1bm5pbmcuDQo+Pj4+IA0KPj4+PiBUaGUgcmVhc29uIGZvciB0aGUg
InN1cHBvc2VkbHkiIGNvbW1lbnQgaXMgdGhhdCBpdCBpcyBub3QgZW50aXJlbHkgY2xlYXINCj4+
Pj4gdGhhdCB0aGlzIHdvdWxkIGJlIHRoZSBjYXNlIGlmIGdkYl9kb19yb3VuZHVwIGlzIHplcm8u
DQo+Pj4gDQo+Pj4gQXJnaCwgdGhhdCdzIHByZXR0eSBzaGl0IGNvZGUuLi4NCj4+PiANCj4+PiBO
b3Qgb25seSBpcyB0aGF0IHRleHRfbXV0ZXggYWJ1c2UgdWdseSwgc28gdG9vIGlzIHRoZSBmaXht
YXAgdXNhZ2UgZnJvbQ0KPj4+IElSUSBjb250ZXh0LiBJIHN1cHBvc2UgdGhpcyByZWFsbHkgZG9l
cyByZXF1aXJlIHlvdXIgYWx0ZXJuYXRpdmUgbW0NCj4+PiBwYXRjaGVzIGZvciB0ZXh0X3Bva2Uo
KS4NCj4+IA0KPj4gUmlnaHQsIEkgZm9yZ290IGFib3V0IHRoYXTigKYNCj4gDQo+IFdpdGggdGhh
dCBDUjMgdHJpY2tlcnksIHdlIGNhbiByaWQgb3Vyc2VsdmVzIG9mIHRoZSB0ZXh0X211dGV4DQo+
IHJlcXVpcmVtZW50LCBzaW5jZSBjb25jdXJyZW50IHRleHRfcG9rZSBpcyAnc2FmZScuIFRoYXQg
d291bGQgY2xlYW4gdXANCj4gdGhlIGtnZGIgY29kZSBxdWl0ZSBhIGJpdC4NCg0KSSBkb27igJl0
IGtub3cuIEnigJltIHNvbWV3aGF0IHdvcnJpZWQgd2l0aCBtdWx0aXBsZSBtZWNoYW5pc21zIHBv
dGVudGlhbGx5DQpjaGFuZ2luZyB0aGUgc2FtZSBjb2RlIGF0IHRoZSBzYW1lIHRpbWUgLSBhbmQg
bWF5YmUgZW5kaW5nIHVwIHdpdGggc29tZQ0KbWVzcy4NCg0K
