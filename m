From: Vineet Gupta <vgupta@synopsys.com>
Subject: Re: [PATCH -v2 00/33] implement atomic_fetch_$op
Date: Wed, 8 Jun 2016 19:54:31 +0530
Message-ID: <57582A9F.2060307@synopsys.com>
References: <20160531101925.702692792@infradead.org>
 <C2D7FE5348E1B147BCA15975FBA23075F4EAF393@us01wembx1.internal.synopsys.com>
 <20160602093304.GX3190@twins.programming.kicks-ass.net>
 <20160608124312.GA30927@twins.programming.kicks-ass.net>
 <20160608125530.GB11563@gmail.com>
 <20160608133242.GS30154@twins.programming.kicks-ass.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mail-pa0-f65.google.com ([209.85.220.65]:34203 "EHLO
	mail-pa0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1423856AbcFHOYm (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Wed, 8 Jun 2016 10:24:42 -0400
In-Reply-To: <20160608133242.GS30154@twins.programming.kicks-ass.net>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@kernel.org>
Cc: "torvalds@linux-foundation.org" <torvalds@linux-foundation.org>, "tglx@linutronix.de" <tglx@linutronix.de>, "will.deacon@arm.com" <will.deacon@arm.com>, "paulmck@linux.vnet.ibm.com" <paulmck@linux.vnet.ibm.com>, "boqun.feng@gmail.com" <boqun.feng@gmail.com>, "waiman.long@hpe.com" <waiman.long@hpe.com>, "fweisbec@gmail.com" <fweisbec@gmail.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>, "rth@twiddle.net" <rth@twiddle.net>, "linux@arm.linux.org.uk" <linux@arm.linux.org.uk>, "egtvedt@samfundet.no" <egtvedt@samfundet.no>, "realmz6@gmail.com" <realmz6@gmail.com>, "ysato@users.sourceforge.jp" <ysato@users.sourceforge.jp>, "rkuo@codeaurora.org" <rkuo@codeaurora.org>, "tony.luck@intel.com" <tony.luck@intel.com>, "geert@linux-m68k.org" <geert@linux-m68k.o>

On Wednesday 08 June 2016 07:02 PM, Peter Zijlstra wrote:
> On Wed, Jun 08, 2016 at 02:55:30PM +0200, Ingo Molnar wrote:
> 
>> I'd much prefer to have all of these in the locking tree (i.e. tip:locking/core), 
>> to make it less painful all around.
> 
> All the fetch_op stuff, yes certainly. But Vineet wanted to munge
> arch/arc/include/asm/atomic.h a bit in 4.7, which would make applying
> the arc fetch_op patch tricky.
> 

My patches are in linux-next already. I was hoping to squeeze in a different fix
before sending the pull request to Linus. But I don't want to stall you, will do
that first thing tomorrow morning. OK ?
