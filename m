From: Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH] arch: all: include: asm: bitops: Use bool instead of int
 for all bit test functions
Date: Mon, 29 Aug 2016 15:46:04 +0200
Message-ID: <20160829134604.GT10153@twins.programming.kicks-ass.net>
References: <1472362755-26776-1-git-send-email-chengang@emindsoft.com.cn>
 <201608291503.41630.arnd@arndb.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from merlin.infradead.org ([205.233.59.134]:40400 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933461AbcH2NsI (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 29 Aug 2016 09:48:08 -0400
Content-Disposition: inline
In-Reply-To: <201608291503.41630.arnd@arndb.de>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Arnd Bergmann <arnd@arndb.de>
Cc: chengang@emindsoft.com.cn, akpm@linux-foundation.org, minchan@kernel.org, vbabka@suse.cz, gi-oh.kim@profitbricks.com, iamjoonsoo.kim@lge.com, hillf.zj@alibaba-inc.com, mgorman@techsingularity.net, mhocko@suse.com, rientjes@google.com, linux-kernel@vger.kernel.org, rth@twiddle.net, ink@jurassic.park.msu.ru, mattst88@gmail.com, vgupta@synopsys.com, linux@armlinux.org.uk, catalin.marinas@arm.com, will.deacon@arm.com, hskinnemoen@gmail.com, egtvedt@samfundet.no, realmz6@gmail.com, ysato@users.sourceforge.jp, rkuo@codeaurora.org, tony.luck@intel.com, fenghua.yu@intel.com, geert@linux-m68k.org, james.hogan@imgtec.com, ralf@linux-mips.org, dhowells@redhat.com, deller@gmx.de, benh@kernel.crashing.org, paulus@samba.org, mpe@ellerman.id.au, schwidefsky@de.ibm.com, heiko.carstens@de.ibm.com

On Mon, Aug 29, 2016 at 03:03:41PM +0200, Arnd Bergmann wrote:
> - Change the Documentation/atomic_ops.txt file accordingly

Not sure that really matters; that document is so out of date its nearly
useless :-(

Rewriting it is somewhere on the TODO list...
