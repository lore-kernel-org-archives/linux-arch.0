From: Paul Mackerras <paulus@samba.org>
Subject: Re: perf_arch_fetch_caller_regs...
Date: Fri, 19 Mar 2010 15:32:02 +1100
Message-ID: <20100319043202.GA3850@brick.ozlabs.ibm.com>
References: <20100318.210241.179917441.davem@davemloft.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from ozlabs.org ([203.10.76.45]:34945 "EHLO ozlabs.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750751Ab0CSEcK (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Fri, 19 Mar 2010 00:32:10 -0400
Content-Disposition: inline
In-Reply-To: <20100318.210241.179917441.davem@davemloft.net>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: David Miller <davem@davemloft.net>
Cc: fweisbec@gmail.com, mingo@elte.hu, linux-arch@vger.kernel.org

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

Well, it would except that CALLER_ADDR1, 2, etc. turn into (0) on
powerpc because we use the generic definition and we don't define
CONFIG_FRAME_POINTER (it's meaningless on powerpc because the ABI
defines that each stack frame always has a pointer to the previous
frame).

I should fix CALLER_ADDRx on powerpc one day, then we will have the
extra inefficiency.

Paul.
