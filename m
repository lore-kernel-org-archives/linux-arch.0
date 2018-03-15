From: Peter Zijlstra <peterz@infradead.org>
Subject: Re: arc_usr_cmpxchg and preemption
Date: Thu, 15 Mar 2018 09:18:45 +0100
Message-ID: <20180315081845.GS4064@hirez.programming.kicks-ass.net>
References: <1521045375.11552.27.camel@synopsys.com>
 <fdf30e76-f75d-9dda-26ca-ac011c41ee64@synopsys.com>
 <20180314175352.GP4064@hirez.programming.kicks-ass.net>
 <1521059931.11552.51.camel@synopsys.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-snps-arc-bounces+gla-linux-snps-arc=m.gmane.org@lists.infradead.org>
Content-Disposition: inline
In-Reply-To: <1521059931.11552.51.camel@synopsys.com>
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

On Wed, Mar 14, 2018 at 08:38:53PM +0000, Alexey Brodkin wrote:
> > int sys_cmpxchg(u32 __user *user_ptr, u32 old, u32 new)
> > {
> > 	u32 val;
> > 	int ret;
> > 
> > again:
> > 	ret = 0;
> > 
> > 	preempt_disable();
> > 	val = get_user(user_ptr);
> > 	if (val == old)
> > 		ret = put_user(new, user_ptr);
> > 	preempt_enable();
> > 
> > 	if (ret == -EFAULT) {
> > 		struct page *page;
> > 		ret = get_user_pages_fast((unsigned long)user_ptr, 1, 1, &page);
> > 		if (ret < 0)
> > 			return ret;
> > 		put_page(page);
> > 		goto again;
> 
> I guess this jump we need to do only once, right?

Typically, yes. It is theoretically possible for the page to get
paged-out right after we do put_page() and before we do get/put_user(),
But if that happens the machine likely has bigger problems than having
to do this loop again.

FWIW, look at kernel/futex.c for working examples of this pattern, the
above was written purely from memory and could contain a fail or two ;-)

Also, it might make sense to stuff this implementation in some lib/ file
somewhere and make all platforms that need it use the same code, afaict
there really isn't anything platform specific to it.
