From: Frederic Weisbecker <fweisbec@gmail.com>
Subject: Re: perf_arch_fetch_caller_regs...
Date: Fri, 19 Mar 2010 05:24:16 +0100
Message-ID: <20100319042414.GA23574@nowhere>
References: <20100318.210241.179917441.davem@davemloft.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mail-bw0-f209.google.com ([209.85.218.209]:43073 "EHLO
	mail-bw0-f209.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750730Ab0CSEYM (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Fri, 19 Mar 2010 00:24:12 -0400
Received: by bwz1 with SMTP id 1so2666432bwz.21
        for <linux-arch@vger.kernel.org>; Thu, 18 Mar 2010 21:24:09 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20100318.210241.179917441.davem@davemloft.net>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: David Miller <davem@davemloft.net>
Cc: mingo@elte.hu, paulus@samba.org, linux-arch@vger.kernel.org

On Thu, Mar 18, 2010 at 09:02:41PM -0700, David Miller wrote:
> 
> Can we please remove the CALLER_ADDR0 et al. evaluations at the top
> level in perf_fetch_caller_regs()?
> 
> I take great pains to avoid having to flush the register windows on
> sparc64 even when fetching callchains et al and any
> __builtin_return_address() with an argument greater than zero is going
> to force a register window flush to get emitted by gcc undoing all of
> my hard work :-)


Ah. But does that really cause bad things? I mean you don't need
to save all the ix/ox/lx registers, only the instruction pointer,
frame pointer, flags, and something that can help user_mode() to
return 0.

I don't know deeply this area, but the frame pointer is
part of the window in the ix things, right? And the CALLER
thing screws up the frame pointer and makes it hard to rewind
precisely?


> 
> You guys can put it into the x86 perf_fetch_caller_regs() or similar.
> 
> If you need it to be evaluated at the call site, make the inline
> overridable by the platform headers.
> 
> I noticed that the powerpc assembler Paul posted the past few days
> ignores this "ip" arg passed down and computes it by hand as it
> walks up the stack chain in assembler.  PowerPC therefore might be
> getting similar inefficiences due to this CALLER_ADDR? stuff.


Yeah, ok if this is that a burden/useless for archs then I'm going to
remove it.

BTW, I'm reworking this to make it a macro for various reasons
(weak and export_symbol being unfriendly together in the same
file and regular software events are going to need it. So I
can't anymore put the export_symbol in another file than
perf_event.c. Since it's impossible I need perf_fetch_caller_regs()
to be a macro now...)
