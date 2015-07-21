From: rkuo <rkuo@codeaurora.org>
Subject: Re: [PATCH 00/28] arch: Provide atomic logic ops
Date: Tue, 21 Jul 2015 16:13:14 -0500
Message-ID: <20150721211314.GA29874@codeaurora.org>
References: <20150716172110.587529075@infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from smtp.codeaurora.org ([198.145.29.96]:34050 "EHLO
	smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754802AbbGUVNV (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Tue, 21 Jul 2015 17:13:21 -0400
Content-Disposition: inline
In-Reply-To: <20150716172110.587529075@infradead.org>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Peter Zijlstra <peterz@infradead.org>
Cc: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, rth@twiddle.net, vgupta@synopsys.com, linux@arm.linux.org.uk, will.deacon@arm.com, hskinnemoen@gmail.com, realmz6@gmail.com, dhowells@redhat.com, tony.luck@intel.com, geert@linux-m68k.org, james.hogan@imgtec.com, ralf@linux-mips.org, jejb@parisc-linux.org, benh@kernel.crashing.org, heiko.carstens@de.ibm.com, davem@davemloft.net, cmetcalf@ezchip.com, ysato@users.sourceforge.jp, mingo@kernel.org

On Thu, Jul 16, 2015 at 07:21:10PM +0200, Peter Zijlstra wrote:
> Currently there is an incoherent mess of atomic_{set,clear}_mask() and
> atomic_or() (but no atomic_{and,nand,xor}()) in the tree.
> 
> Those archs that implement atomic_{set,clear}_mask() are not even consistent on
> its signature.
> 
> Implement atomic_{or,and,xor}() on all archs and deprecate
> atomic_{set,clear}_mask().
> 
> The series has been compile tested by the build-bot, no known failures at this time.
> 
> I would like to take this through tip; I'll ask Ingo to put it in a separate
> branch such that people can pull in that branch if there is conflicting work
> elsewhere (Will has some for Argh64).
> 
> 
> Changes since lst time:
> 
>  - Quite a few build fails fixed, most notable would be that each arch
>    now defines CONFIG_ARCH_HAS_ATOMIC_OR for a little while -- we take it
>    out again later.
> 
>  - FRV has some extra magic that allows the inline assembly to correctly
>    work as inline functions.
> 
>  - TILE patch contributed by Chris -- Thanks!
> 
>  - A little extention to lib/atomic64_test.c that compile tests the new
>    primitives.
> 
>  - Alpha, fixed ASM due to fallout from actually trying to compile things.
> 
>  - H8300, somehow I had overlooked it previously.
> 
>  - Added atomic_andnot() to a few archs that have that instruction to test that.
> 

Hexagon parts built and tested fine; thanks!

Acked-by: Richard Kuo <rkuo@codeaurora.org>


-- 
Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum, 
a Linux Foundation Collaborative Project
