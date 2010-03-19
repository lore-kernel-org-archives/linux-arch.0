From: David Miller <davem@davemloft.net>
Subject: Re: perf_arch_fetch_caller_regs...
Date: Thu, 18 Mar 2010 21:51:34 -0700 (PDT)
Message-ID: <20100318.215134.200355129.davem@davemloft.net>
References: <20100318.210241.179917441.davem@davemloft.net>
	<20100319043202.GA3850@brick.ozlabs.ibm.com>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from 74-93-104-97-Washington.hfc.comcastbusiness.net ([74.93.104.97]:44108
	"EHLO sunset.davemloft.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751132Ab0CSEvL (ORCPT
	<rfc822;linux-arch@vger.kernel.org>);
	Fri, 19 Mar 2010 00:51:11 -0400
In-Reply-To: <20100319043202.GA3850@brick.ozlabs.ibm.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: paulus@samba.org
Cc: fweisbec@gmail.com, mingo@elte.hu, linux-arch@vger.kernel.org

From: Paul Mackerras <paulus@samba.org>
Date: Fri, 19 Mar 2010 15:32:02 +1100

> On Thu, Mar 18, 2010 at 09:02:41PM -0700, David Miller wrote:
>> I noticed that the powerpc assembler Paul posted the past few days
>> ignores this "ip" arg passed down and computes it by hand as it
>> walks up the stack chain in assembler.  PowerPC therefore might be
>> getting similar inefficiences due to this CALLER_ADDR? stuff.
> 
> Well, it would except that CALLER_ADDR1, 2, etc. turn into (0) on
> powerpc because we use the generic definition and we don't define
> CONFIG_FRAME_POINTER (it's meaningless on powerpc because the ABI
> defines that each stack frame always has a pointer to the previous
> frame).
> 
> I should fix CALLER_ADDRx on powerpc one day, then we will have the
> extra inefficiency.

Gosh, that CONFIG_FRAME_POINTER dependency is 'nifty', how does the
CALLER_ADDR{1,2} usage made by the scheduler tracepoints work on
powerpc then?

I suppose I could define HAVE_ARCH_CALLER_ADDR and optimize them
on sparc64, similar to what SH is doing.
