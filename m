Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from merlin.infradead.org ([205.233.59.134]:41296 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725913AbeIFMra (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 6 Sep 2018 08:47:30 -0400
Date: Thu, 6 Sep 2018 10:13:00 +0200
From: Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH v2 0/6] x86/alternatives: text_poke() fixes
Message-ID: <20180906081300.GF24082@hirez.programming.kicks-ass.net>
References: <20180902173224.30606-1-namit@vmware.com>
 <20180905185617.GC24082@hirez.programming.kicks-ass.net>
 <8D3CE999-6D3A-4984-934A-634BDD8AC25A@vmware.com>
 <6B256AB7-0158-47DF-B2D5-4C835579F3A3@vmware.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6B256AB7-0158-47DF-B2D5-4C835579F3A3@vmware.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Nadav Amit <namit@vmware.com>
Cc: Thomas Gleixner <tglx@linutronix.de>, LKML <linux-kernel@vger.kernel.org>, Ingo Molnar <mingo@redhat.com>, X86 ML <x86@kernel.org>, Arnd Bergmann <arnd@arndb.de>, linux-arch <linux-arch@vger.kernel.org>, Dave Hansen <dave.hansen@linux.intel.com>, Jiri Kosina <jkosina@suse.cz>, Andy Lutomirski <luto@kernel.org>, Masami Hiramatsu <mhiramat@kernel.org>, Kees Cook <keescook@chromium.org>
Message-ID: <20180906081300.-QwfB4CFtSZCOMIS_ch21sSF2Ftu5pO4It2GdtgdyvA@z>

On Wed, Sep 05, 2018 at 07:10:46PM +0000, Nadav Amit wrote:
> at 12:02 PM, Nadav Amit <namit@vmware.com> wrote:
> 
> > at 11:56 AM, Peter Zijlstra <peterz@infradead.org> wrote:
> > 
> >> On Sun, Sep 02, 2018 at 10:32:18AM -0700, Nadav Amit wrote:
> >>> This patch-set addresses some issues that were raised in a recent
> >>> correspondence and might affect the security and the correctness of code
> >>> patching. (Note that patching performance is not addressed by this
> >>> patch-set).
> >>> 
> >>> The main issue that the patches deal with is the fact that the fixmap
> >>> PTEs that are used for patching are available for access from other
> >>> cores and might be exploited. They are not even flushed from the TLB in
> >>> remote cores, so the risk is even higher. Address this issue by
> >>> introducing a temporary mm that is only used during patching.
> >>> Unfortunately, due to init ordering, fixmap is still used during
> >>> boot-time patching. Future patches can eliminate the need for it.
> >> 
> >> Remind me; why are we doing it like this instead of fixing fixmap?
> >> Because while this fixes the text_poke crud, it does leave fixmap
> >> broken.
> > 
> > Do you have other fixmap mappings in mind that are modified after boot?
> 
> Oh.. I misunderstood you. You mean: why not to make the fixmap mappings that
> are used for text_poke() as private ones.

No, you got it the first time. There are in fact more fixmap abusers;
see drivers/acpi/apei/ghes.c.  Also, as long as set_fixmap() allows
overwriting a _PAGE_PRESENT pte and has that dodgy
__flush_tlb_one_kernel() in it, the broken remains (and can return).

So we need to fix fixmap, to either disallow overwriting a _PAGE_PRESENT
pte, or to issue a full TLB invalidate.

Either fix will terminally break GHES, but that's OK, they've known
about this issue since 2015 and haven't cared, so I can't be bothered
about them.
