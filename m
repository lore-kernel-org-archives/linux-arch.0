From: Rob Fowler <rjf@renci.org>
Subject: Re: [patch 0/3] [Announcement] Performance Counters for
 Linux
Date: Wed, 10 Dec 2008 11:27:21 -0500
Message-ID: <493FEDE9.5080209@renci.org>
References: <20081204225345.654705757@linutronix.de>
	<7c86c4470812051836t37e86565w3b92fd06fc905430@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <perfmon2-devel-bounces@lists.sourceforge.net>
In-Reply-To: <7c86c4470812051836t37e86565w3b92fd06fc905430@mail.gmail.com>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/perfmon2-devel>,
	<mailto:perfmon2-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=perfmon2-devel>
List-Post: <mailto:perfmon2-devel@lists.sourceforge.net>
List-Help: <mailto:perfmon2-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/perfmon2-devel>,
	<mailto:perfmon2-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: perfmon2-devel-bounces@lists.sourceforge.net
To: eranian@gmail.com
Cc: linux-arch@vger.kernel.org, Peter Zijlstra <a.p.zijlstra@chello.nl>, Ingo Molnar <mingo@elte.hu>, LKML <linux-kernel@vger.kernel.org>, Steven Rostedt <rostedt@goodmis.org>, Eric Dumazet <dada1@cosmosbay.com>, Andrew Morton <akpm@linux-foundation.org>, Paul Mackerras <paulus@samba.org>, Peter Anvin <hpa@zytor.com>, Thomas Gleixner <tglx@linutronix.de>, David Miller <davem@davemloft.net>, perfmon2-devel <perfmon2-devel@lists.sourceforge.net>, Arjan van de Veen <arjan@infradead.org>
List-Id: linux-arch.vger.kernel.org

My reaction is more from a downstream tool developer and end user perspective.

What I don't see in the new proposal is support for real end users of hardware
performance counter information.  There is a long-existing community that is using the
counters, including the hardware designers, driver writers, tool developers, and
performance tuning specialists working for both vendors and end customers.   Not
everyone is in the same camp, as each the hardware capabilities change from revision to
revision of the chips as features are added, architectures evolve, and implementations are
cleaned up.  System vendors have their own tools and developers (SpeedShop, Vtune, Tprof, Sun Studio
Code Analyst, etc). There are academic and open source efforts with long histories (PAPI,
oprofile, HPCToolkit (Rice, not IBM), etc). We've lived with proprietary drivers/APIs and with
a succession of open-source drivers (pci, perfctr, oprofile, perfmon).  (My apologies to
readers/developers whose favorite tool(s) I haven't mentioned.)  Out-and-out religious wars
have not erupted, but there are a lot of healthy disagreements. A significant part of this
community has been converging around Perfmon2/3, not because it is a thing of beauty, but
because it is a tool that exposes the full HPM capabilities (which are often ugly) in a useful
way for a community of tool developers and end users.

Before considering this new proposal seriously, I'd need to see it proven.  This means
that it needs to be developed, by the proposers, enough to be used seriously.  I've
got collaborators that measure compute resources in units of tens of TeraFLOP-years, so
my definition of "seriously" is that the HPM tool chain has to work with low overhead
on huge clusters of multi-core, multi-socket machines and it has to be able to provide
performance insights that will let us get even more performance out of applications
that already do pretty well.  Google and other large users have similar notions of "serious".

Here's my set of strawman requirements:

-- Can it support a *completely* functional PAPI?  There are a lot of tools (HPCToolkit,
    TAU, etc.) built on this layer.

-- Means to support IBS/EBS profiling and efficiently record execution contexts?  Can it
    support event-based call stack profiling?

-- Can it supplant or support oprofile by supporting the tools (Code Analyst, etc) that
    depend on it?

-- Kernel and daemon profiling capabilities?

-- Does it have sufficiently low overhead?  Six years ago DCPI/ProfileMe was capable of
    collecting around 5000 samples/second on a quad socket 1GHz Alpha EV67 system with
    about a 1.5% overhead.  That's the gold standard. Oprofile and pfmon are not far off
    that mark.

-- Does it even scale within one box?  My workhorse systems today are quad-socket Barcelonas.
    I'm reliably using multiple, cooperating (Some measure on-core, others measure off-core events.)
    instances of pfmon to collect profiles using  all 64 (4 per core x 16 cores) counters
    productively with low overhead.  Real soon now I will have similar expectations
    regarding multi-socket Nehalems where the resources will be 7 (heterogeneous) counters per
    core plus 8 "uncore" counters (I prefer "nest", Alex Mericas' terminology.) per socket.


Regards,
Rob


stephane eranian wrote:
> Hello,
> 
> I have been reading all the threads after this unexpected announcement
> of a competing proposal for an interface to access the performance counters.
> I would like to respond to some of the things I have seen.
> 

  <<<<<< Details of Stephane's comment's elided >>>>>>

> 
> In summary, although the idea of simplifying tools by moving the
> complexity elsewhere is legitimate, pushing it down to the kernel
> is the wrong approach in my opinion, perfmon has avoided that as much
> as possible for good reasons. We have shown , with libpfm,
> that a large part of complexity can easily be encapsulated into a user
> library. I also don't think the approach of managing events
> independently of each others works for all processors. As pointed out
> by others, there are other factors at stake and they may not
> even be on the same core.
> 
> S. Eranian
> 
> ------------------------------------------------------------------------------
> SF.Net email is Sponsored by MIX09, March 18-20, 2009 in Las Vegas, Nevada.
> The future of the web can't happen without you.  Join us at MIX09 to help
> pave the way to the Next Web now. Learn more and register at
> http://ad.doubleclick.net/clk;208669438;13503038;i?http://2009.visitmix.com/
> _______________________________________________
> perfmon2-devel mailing list
> perfmon2-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/perfmon2-devel

-- 
Robert J. Fowler
Chief Domain Scientist, HPC
Renaissance Computing Institute
The University of North Carolina at Chapel Hill
100 Europa Dr, Suite 540
Chapel Hill, NC 27517
V: 919.445.9670
F: 919 445.9669
rjf@renci.org

------------------------------------------------------------------------------
SF.Net email is Sponsored by MIX09, March 18-20, 2009 in Las Vegas, Nevada.
The future of the web can't happen without you.  Join us at MIX09 to help
pave the way to the Next Web now. Learn more and register at
http://ad.doubleclick.net/clk;208669438;13503038;i?http://2009.visitmix.com/
