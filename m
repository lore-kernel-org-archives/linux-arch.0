Return-Path: <SRS0=eK+U=AG=vger.kernel.org=linux-arch-owner@kernel.org>
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52072 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390330AbgFYI6T (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 25 Jun 2020 04:58:19 -0400
Date: Thu, 25 Jun 2020 10:57:45 +0200
From: Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH 00/22] add support for Clang LTO
Message-ID: <20200625085745.GD117543@hirez.programming.kicks-ass.net>
References: <20200624203200.78870-1-samitolvanen@google.com>
 <20200624211540.GS4817@hirez.programming.kicks-ass.net>
 <CAKwvOdmxz91c-M8egR9GdR1uOjeZv7-qoTP=pQ55nU8TCpkK6g@mail.gmail.com>
 <20200625080313.GY4817@hirez.programming.kicks-ass.net>
 <20200625082433.GC117543@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200625082433.GC117543@hirez.programming.kicks-ass.net>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Nick Desaulniers <ndesaulniers@google.com>
Cc: Sami Tolvanen <samitolvanen@google.com>, Masahiro Yamada <masahiroy@kernel.org>, Will Deacon <will@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "Paul E. McKenney" <paulmck@kernel.org>, Kees Cook <keescook@chromium.org>, clang-built-linux <clang-built-linux@googlegroups.com>, Kernel Hardening <kernel-hardening@lists.openwall.com>, linux-arch <linux-arch@vger.kernel.org>, Linux ARM <linux-arm-kernel@lists.infradead.org>, Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, linux-pci@vger.kernel.org, "maintainer:X86 ARCHITECTURE (32-BIT AND 64-BIT)" <x86@kernel.org>
Message-ID: <20200625085745.MP7QIq3OcdG6JjBuEhhgiHOEQ4WS-fMTdzrBcjLclvU@z>

On Thu, Jun 25, 2020 at 10:24:33AM +0200, Peter Zijlstra wrote:
> On Thu, Jun 25, 2020 at 10:03:13AM +0200, Peter Zijlstra wrote:

> > I'm sure Will will respond, but the basic issue is the trainwreck C11
> > made of dependent loads.
> > 
> > Anyway, here's a link to the last time this came up:
> > 
> >   https://lore.kernel.org/linux-arm-kernel/20171116174830.GX3624@linux.vnet.ibm.com/
> 
> Another good read:
> 
>   https://lore.kernel.org/lkml/20150520005510.GA23559@linux.vnet.ibm.com/
> 
> and having (partially) re-read that, I now worry intensily about things
> like latch_tree_find(), cyc2ns_read_begin, __ktime_get_fast_ns().
> 
> It looks like kernel/time/sched_clock.c uses raw_read_seqcount() which
> deviates from the above patterns by, for some reason, using a primitive
> that includes an extra smp_rmb().
> 
> And this is just the few things I could remember off the top of my head,
> who knows what else is out there.

As an example, let us consider __ktime_get_fast_ns(), the critical bit
is:

		seq = raw_read_seqcount_latch(&tkf->seq);
		tkr = tkf->base + (seq & 0x01);
		now = tkr->base;

And we hard rely on that being a dependent load, so:

  LOAD	seq, (tkf->seq)
  LOAD  tkr, tkf->base
  AND   seq, 1
  MUL   seq, sizeof(tk_read_base)
  ADD	tkr, seq
  LOAD  now, (tkr->base)

Such that we obtain 'now' as a direct dependency on 'seq'. This ensures
the loads are ordered.

A compiler can wreck this by translating it into something like:

  LOAD	seq, (tkf->seq)
  LOAD  tkr, tkf->base
  AND   seq, 1
  CMP	seq, 0
  JE	1f
  ADD	tkr, sizeof(tk_read_base)
1:
  LOAD  now, (tkr->base)

Because now the machine can speculate and load now before seq, breaking
the ordering.
