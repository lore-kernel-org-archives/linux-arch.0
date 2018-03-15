From: Peter Zijlstra <peterz@infradead.org>
Subject: Re: arc_usr_cmpxchg and preemption
Date: Thu, 15 Mar 2018 12:28:29 +0100
Message-ID: <20180315112829.GW4064@hirez.programming.kicks-ass.net>
References: <1521045375.11552.27.camel@synopsys.com>
 <fdf30e76-f75d-9dda-26ca-ac011c41ee64@synopsys.com>
 <20180314175352.GP4064@hirez.programming.kicks-ass.net>
 <1521059931.11552.51.camel@synopsys.com>
 <20180315081845.GS4064@hirez.programming.kicks-ass.net>
 <1521105128.11552.64.camel@synopsys.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-snps-arc-bounces+gla-linux-snps-arc=m.gmane.org@lists.infradead.org>
Content-Disposition: inline
In-Reply-To: <1521105128.11552.64.camel@synopsys.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-snps-arc>,
 <mailto:linux-snps-arc-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-snps-arc/>
List-Post: <mailto:linux-snps-arc@lists.infradead.org>
List-Help: <mailto:linux-snps-arc-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-snps-arc>,
 <mailto:linux-snps-arc-request@lists.infradead.org?subject=subscribe>
Sender: "linux-snps-arc" <linux-snps-arc-bounces@lists.infradead.org>
Errors-To: linux-snps-arc-bounces+gla-linux-snps-arc=m.gmane.org@lists.infradead.org
To: Alexey Brodkin <Alexey.Brodkin@synopsys.com>
Cc: "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>, "Vineet.Gupta1@synopsys.com" <Vineet.Gupta1@synopsys.com>, "linux-snps-arc@lists.infradead.org" <linux-snps-arc@lists.infradead.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
List-Id: linux-arch.vger.kernel.org

On Thu, Mar 15, 2018 at 09:12:09AM +0000, Alexey Brodkin wrote:
> On Thu, 2018-03-15 at 09:18 +0100, Peter Zijlstra wrote:

> > Also, it might make sense to stuff this implementation in some lib/ file
> > somewhere and make all platforms that need it use the same code, afaict
> > there really isn't anything platform specific to it.
> 
> Not clear which part do you mean here.
> Are you talking about entire cmpxchg syscall implementation?

Yep.

> Do you think there're many users of that quite an inefficient
> [compared to proper HW version] atomic exchange?

I think there's a bunch of architectures that are in the same boat.
m68k, arm, mips was mentioned. Sure, the moment an arch has hardware
support you don't need the syscall anymore.

I was just thinking it would be good to have a common implementation (if
possible) rather than 4-5 different copies of basically the same thing.
