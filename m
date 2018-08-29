Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from merlin.infradead.org ([205.233.59.134]:55576 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727484AbeH2ULx (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 29 Aug 2018 16:11:53 -0400
Date: Wed, 29 Aug 2018 18:14:00 +0200
From: Peter Zijlstra <peterz@infradead.org>
Subject: Re: [RFC PATCH 5/6] x86/alternatives: use temporary mm for text
 poking
Message-ID: <20180829161400.GV24124@hirez.programming.kicks-ass.net>
References: <20180829081147.184610-1-namit@vmware.com>
 <20180829081147.184610-6-namit@vmware.com>
 <20180829092839.GP24124@hirez.programming.kicks-ass.net>
 <CALCETrXe9CUMo3c44UtmkxD4w68PvmoypdCyvCFvWiZVuxy=sQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CALCETrXe9CUMo3c44UtmkxD4w68PvmoypdCyvCFvWiZVuxy=sQ@mail.gmail.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Andy Lutomirski <luto@kernel.org>
Cc: Nadav Amit <namit@vmware.com>, Thomas Gleixner <tglx@linutronix.de>, LKML <linux-kernel@vger.kernel.org>, Ingo Molnar <mingo@redhat.com>, X86 ML <x86@kernel.org>, Arnd Bergmann <arnd@arndb.de>, linux-arch <linux-arch@vger.kernel.org>, Masami Hiramatsu <mhiramat@kernel.org>, Kees Cook <keescook@chromium.org>, Dave Hansen <dave.hansen@intel.com>
Message-ID: <20180829161400.uzGl4lebPFw-z_hBghGPVpF4x-M6yyxmEQo6YkGfvZY@z>

On Wed, Aug 29, 2018 at 08:46:04AM -0700, Andy Lutomirski wrote:
> On Wed, Aug 29, 2018 at 2:28 AM, Peter Zijlstra <peterz@infradead.org> wrote:
> > On Wed, Aug 29, 2018 at 01:11:46AM -0700, Nadav Amit wrote:
> 
> >> +     pte_clear(poking_mm, poking_addr, ptep);
> >> +
> >> +     /*
> >> +      * __flush_tlb_one_user() performs a redundant TLB flush when PTI is on,
> >> +      * as it also flushes the corresponding "user" address spaces, which
> >> +      * does not exist.
> >> +      *
> >> +      * Poking, however, is already very inefficient since it does not try to
> >> +      * batch updates, so we ignore this problem for the time being.
> >> +      *
> >> +      * Since the PTEs do not exist in other kernel address-spaces, we do
> >> +      * not use __flush_tlb_one_kernel(), which when PTI is on would cause
> >> +      * more unwarranted TLB flushes.
> >> +      */
> >
> > yuck :-), but yeah.
> 
> I'm sure we covered this ad nauseum when PTI was being developed, but
> we were kind of in a rush, so:
> 
> Why do we do INVPCID at all?  The fallback path for non-INVPCID
> systems uses invalidate_user_asid(), which should be faster than the
> invpcid path.  And doesn't do a redundant flush in this case.

I don't remember; and you forgot to (re)add dhansen.

Logically INVPCID_SINGLE should be faster since it pokes out a single
translation in another PCID instead of killing all user translations.

Is it just a matter of (current) chips implementing INVLPCID_SINGLE
inefficient, or something else?
