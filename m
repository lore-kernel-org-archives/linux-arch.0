Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail-by2nam01on0041.outbound.protection.outlook.com ([104.47.34.41]:29935
        "EHLO NAM01-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727755AbeIEXmV (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Wed, 5 Sep 2018 19:42:21 -0400
From: Nadav Amit <namit@vmware.com>
Subject: Re: [PATCH v2 0/6] x86/alternatives: text_poke() fixes
Date: Wed, 5 Sep 2018 19:10:46 +0000
Message-ID: <6B256AB7-0158-47DF-B2D5-4C835579F3A3@vmware.com>
References: <20180902173224.30606-1-namit@vmware.com>
 <20180905185617.GC24082@hirez.programming.kicks-ass.net>
 <8D3CE999-6D3A-4984-934A-634BDD8AC25A@vmware.com>
In-Reply-To: <8D3CE999-6D3A-4984-934A-634BDD8AC25A@vmware.com>
Content-Language: en-US
Content-Type: text/plain; charset="us-ascii"
Content-ID: <C6D032E7CC8E8F479471B6AA24CFAC2E@namprd05.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Peter Zijlstra <peterz@infradead.org>
Cc: Thomas Gleixner <tglx@linutronix.de>, LKML <linux-kernel@vger.kernel.org>, Ingo Molnar <mingo@redhat.com>, X86 ML <x86@kernel.org>, Arnd Bergmann <arnd@arndb.de>, linux-arch <linux-arch@vger.kernel.org>, Dave Hansen <dave.hansen@linux.intel.com>, Jiri Kosina <jkosina@suse.cz>, Andy Lutomirski <luto@kernel.org>, Masami Hiramatsu <mhiramat@kernel.org>, Kees Cook <keescook@chromium.org>
Message-ID: <20180905191046.ThFa03y35okqN4PqMh_ENBvQ-MamFmr0lqQsjGbeHSw@z>

at 12:02 PM, Nadav Amit <namit@vmware.com> wrote:

> at 11:56 AM, Peter Zijlstra <peterz@infradead.org> wrote:
>=20
>> On Sun, Sep 02, 2018 at 10:32:18AM -0700, Nadav Amit wrote:
>>> This patch-set addresses some issues that were raised in a recent
>>> correspondence and might affect the security and the correctness of cod=
e
>>> patching. (Note that patching performance is not addressed by this
>>> patch-set).
>>>=20
>>> The main issue that the patches deal with is the fact that the fixmap
>>> PTEs that are used for patching are available for access from other
>>> cores and might be exploited. They are not even flushed from the TLB in
>>> remote cores, so the risk is even higher. Address this issue by
>>> introducing a temporary mm that is only used during patching.
>>> Unfortunately, due to init ordering, fixmap is still used during
>>> boot-time patching. Future patches can eliminate the need for it.
>>=20
>> Remind me; why are we doing it like this instead of fixing fixmap?
>> Because while this fixes the text_poke crud, it does leave fixmap
>> broken.
>=20
> Do you have other fixmap mappings in mind that are modified after boot?

Oh.. I misunderstood you. You mean: why not to make the fixmap mappings tha=
t
are used for text_poke() as private ones.

Well, the main reason is that it can require synchronizations of the
different page-tables whenever a module is loaded/unloaded. The fixmap
region shares a PGD and PUD with the modules area in x86-64.

In contrast, the proposed solution uses a different PGD, so no
synchronization between page-tables is needed when modules are loaded.
Remember that module memory is allocated even when BPF programs are
installed, which can be rather common scenario.
