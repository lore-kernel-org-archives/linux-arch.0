From: David Miller <davem@davemloft.net>
Subject: perf_arch_fetch_caller_regs...
Date: Thu, 18 Mar 2010 21:02:41 -0700 (PDT)
Message-ID: <20100318.210241.179917441.davem@davemloft.net>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from 74-93-104-97-Washington.hfc.comcastbusiness.net ([74.93.104.97]:50405
	"EHLO sunset.davemloft.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750695Ab0CSECT (ORCPT
	<rfc822;linux-arch@vger.kernel.org>);
	Fri, 19 Mar 2010 00:02:19 -0400
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: fweisbec@gmail.com
Cc: mingo@elte.hu, paulus@samba.org, linux-arch@vger.kernel.org


Can we please remove the CALLER_ADDR0 et al. evaluations at the top
level in perf_fetch_caller_regs()?

I take great pains to avoid having to flush the register windows on
sparc64 even when fetching callchains et al and any
__builtin_return_address() with an argument greater than zero is going
to force a register window flush to get emitted by gcc undoing all of
my hard work :-)

You guys can put it into the x86 perf_fetch_caller_regs() or similar.

If you need it to be evaluated at the call site, make the inline
overridable by the platform headers.

I noticed that the powerpc assembler Paul posted the past few days
ignores this "ip" arg passed down and computes it by hand as it
walks up the stack chain in assembler.  PowerPC therefore might be
getting similar inefficiences due to this CALLER_ADDR? stuff.

Thanks.
