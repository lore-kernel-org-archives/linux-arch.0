Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail-sn1nam01on0051.outbound.protection.outlook.com ([104.47.32.51]:24374
        "EHLO NAM01-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727618AbeIEXdu (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Wed, 5 Sep 2018 19:33:50 -0400
From: Nadav Amit <namit@vmware.com>
Subject: Re: [PATCH v2 0/6] x86/alternatives: text_poke() fixes
Date: Wed, 5 Sep 2018 19:02:16 +0000
Message-ID: <8D3CE999-6D3A-4984-934A-634BDD8AC25A@vmware.com>
References: <20180902173224.30606-1-namit@vmware.com>
 <20180905185617.GC24082@hirez.programming.kicks-ass.net>
In-Reply-To: <20180905185617.GC24082@hirez.programming.kicks-ass.net>
Content-Language: en-US
Content-Type: text/plain; charset="us-ascii"
Content-ID: <4A01DA3454B22E46A164B6C7B51ED283@namprd05.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Peter Zijlstra <peterz@infradead.org>
Cc: Thomas Gleixner <tglx@linutronix.de>, LKML <linux-kernel@vger.kernel.org>, Ingo Molnar <mingo@redhat.com>, X86 ML <x86@kernel.org>, Arnd Bergmann <arnd@arndb.de>, linux-arch <linux-arch@vger.kernel.org>, Dave Hansen <dave.hansen@linux.intel.com>, Jiri Kosina <jkosina@suse.cz>, Andy Lutomirski <luto@kernel.org>, Masami Hiramatsu <mhiramat@kernel.org>, Kees Cook <keescook@chromium.org>
Message-ID: <20180905190216.7CZ6GU8JWoH7aQ2Xck8KITnEbHl9PurfWfVUrKn1gWY@z>

at 11:56 AM, Peter Zijlstra <peterz@infradead.org> wrote:

> On Sun, Sep 02, 2018 at 10:32:18AM -0700, Nadav Amit wrote:
>> This patch-set addresses some issues that were raised in a recent
>> correspondence and might affect the security and the correctness of code
>> patching. (Note that patching performance is not addressed by this
>> patch-set).
>>=20
>> The main issue that the patches deal with is the fact that the fixmap
>> PTEs that are used for patching are available for access from other
>> cores and might be exploited. They are not even flushed from the TLB in
>> remote cores, so the risk is even higher. Address this issue by
>> introducing a temporary mm that is only used during patching.
>> Unfortunately, due to init ordering, fixmap is still used during
>> boot-time patching. Future patches can eliminate the need for it.
>=20
> Remind me; why are we doing it like this instead of fixing fixmap?
> Because while this fixes the text_poke crud, it does leave fixmap
> broken.

Do you have other fixmap mappings in mind that are modified after boot?
