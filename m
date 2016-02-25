From: Vineet Gupta <vgupta@synopsys.com>
Subject: Re: Interesting csd deadlock on ARC
Date: Thu, 25 Feb 2016 21:28:02 +0530
Message-ID: <56CF248A.3070805@synopsys.com>
References: <56C6BA82.1060909@synopsys.com> <56CBEC66.2030401@synopsys.com>
 <20160223095824.GH6356@twins.programming.kicks-ass.net>
 <56CD36CD.2080303@synopsys.com>
 <20160225140654.GL6357@twins.programming.kicks-ass.net>
 <56CF0E6B.5020903@synopsys.com>
 <20160225143046.GR19428@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20160225143046.GR19428@n2100.arm.linux.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
To: Russell King - ARM Linux <linux@arm.linux.org.uk>
Cc: Peter Zijlstra <peterz@infradead.org>, Will Deacon <Will.Deacon@arm.com>, "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>, Marc Zyngier <marc.zyngier@arm.com>, Frederic Weisbecker <fweisbec@gmail.com>, lkml <linux-kernel@vger.kernel.org>, Noam Camus <noamc@ezchip.com>, arcml <linux-snps-arc@lists.infradead.org>
List-Id: linux-arch.vger.kernel.org

On Thursday 25 February 2016 08:00 PM, Russell King - ARM Linux wrote:
> On Thu, Feb 25, 2016 at 07:53:39PM +0530, Vineet Gupta wrote:
>> But then ARM CONFIG_SMP on UP hardware will still crap out because there
>> is no way to send IPI to self. Same as the bug in above discussion. I'm
>> surprised they way ARM guys worked around it.
> 
> We haven't worked around it - the code which provoked the oops that was
> seen (in the cpufreq code) was changed not to call it, which has the
> effect of making the problem "go away", at least for now.
> 
> We still have the problem that if it does get called on UP, it'll blow
> up - and I don't see any point in complicating the code for something
> that never happens right now.

Right so my statement "workaround" was technically incorrect. But like you say,
it's a ticking bomb which will certainly go off on your SMP on UP systems the
moment someone adds irq_work_queue_on() in some obscure corner of generic code.

And I think this merits fixing in generic code !

-Vineet
