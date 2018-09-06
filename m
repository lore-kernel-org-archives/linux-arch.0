Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail-dm3nam03on0077.outbound.protection.outlook.com ([104.47.41.77]:7136
        "EHLO NAM03-DM3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727650AbeIGATR (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Thu, 6 Sep 2018 20:19:17 -0400
From: Nadav Amit <namit@vmware.com>
Subject: Re: [PATCH v2 1/6] Fix "x86/alternatives: Lockdep-enforce text_mutex
 in text_poke*()"
Date: Thu, 6 Sep 2018 19:42:14 +0000
Message-ID: <BD1F532F-1006-4CDC-9470-C8A91619E4DE@vmware.com>
References: <20180902173224.30606-1-namit@vmware.com>
 <20180902173224.30606-2-namit@vmware.com>
 <20180906194003.GD4816@worktop.programming.kicks-ass.net>
In-Reply-To: <20180906194003.GD4816@worktop.programming.kicks-ass.net>
Content-Language: en-US
Content-Type: text/plain; charset="utf-8"
Content-ID: <9280685D9FEEB04BB4A67C99F6D7439F@namprd05.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Peter Zijlstra <peterz@infradead.org>
Cc: Thomas Gleixner <tglx@linutronix.de>, LKML <linux-kernel@vger.kernel.org>, Ingo Molnar <mingo@redhat.com>, X86 ML <x86@kernel.org>, Arnd Bergmann <arnd@arndb.de>, linux-arch <linux-arch@vger.kernel.org>, Dave Hansen <dave.hansen@linux.intel.com>, Jiri Kosina <jkosina@suse.cz>, Andy Lutomirski <luto@kernel.org>, Kees Cook <keescook@chromium.org>, Dave Hansen <dave.hansen@intel.com>
Message-ID: <20180906194214.PY46QTj6BmRjkmNdfCe58LA06UUn2XLSXf3pSE93fiI@z>

YXQgMTI6NDAgUE0sIFBldGVyIFppamxzdHJhIDxwZXRlcnpAaW5mcmFkZWFkLm9yZz4gd3JvdGU6
DQoNCj4gT24gU3VuLCBTZXAgMDIsIDIwMTggYXQgMTA6MzI6MTlBTSAtMDcwMCwgTmFkYXYgQW1p
dCB3cm90ZToNCj4+IHRleHRfbXV0ZXggaXMgZXhwZWN0ZWQgdG8gYmUgaGVsZCBiZWZvcmUgdGV4
dF9wb2tlKCkgaXMgY2FsbGVkLCBidXQgd2UNCj4+IGNhbm5vdCBhZGQgYSBsb2NrZGVwIGFzc2Vy
dGlvbiBzaW5jZSBrZ2RiIGRvZXMgbm90IHRha2UgaXQsIGFuZCBpbnN0ZWFkDQo+PiAqc3VwcG9z
ZWRseSogZW5zdXJlcyB0aGUgbG9jayBpcyBub3QgdGFrZW4gYW5kIHdpbGwgbm90IGJlIGFjcXVp
cmVkIGJ5DQo+PiBhbnkgb3RoZXIgY29yZSB3aGlsZSB0ZXh0X3Bva2UoKSBpcyBydW5uaW5nLg0K
Pj4gDQo+PiBUaGUgcmVhc29uIGZvciB0aGUgInN1cHBvc2VkbHkiIGNvbW1lbnQgaXMgdGhhdCBp
dCBpcyBub3QgZW50aXJlbHkgY2xlYXINCj4+IHRoYXQgdGhpcyB3b3VsZCBiZSB0aGUgY2FzZSBp
ZiBnZGJfZG9fcm91bmR1cCBpcyB6ZXJvLg0KPiANCj4gQXJnaCwgdGhhdCdzIHByZXR0eSBzaGl0
IGNvZGUuLi4NCj4gDQo+IE5vdCBvbmx5IGlzIHRoYXQgdGV4dF9tdXRleCBhYnVzZSB1Z2x5LCBz
byB0b28gaXMgdGhlIGZpeG1hcCB1c2FnZSBmcm9tDQo+IElSUSBjb250ZXh0LiBJIHN1cHBvc2Ug
dGhpcyByZWFsbHkgZG9lcyByZXF1aXJlIHlvdXIgYWx0ZXJuYXRpdmUgbW0NCj4gcGF0Y2hlcyBm
b3IgdGV4dF9wb2tlKCkuDQoNClJpZ2h0LCBJIGZvcmdvdCBhYm91dCB0aGF04oCmDQoNCg==
