From: Peter Zijlstra <peterz@infradead.org>
Subject: Re: arc_usr_cmpxchg and preemption
Date: Wed, 14 Mar 2018 18:53:52 +0100
Message-ID: <20180314175352.GP4064@hirez.programming.kicks-ass.net>
References: <1521045375.11552.27.camel@synopsys.com>
 <fdf30e76-f75d-9dda-26ca-ac011c41ee64@synopsys.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-snps-arc-bounces+gla-linux-snps-arc=m.gmane.org@lists.infradead.org>
Content-Disposition: inline
In-Reply-To: <fdf30e76-f75d-9dda-26ca-ac011c41ee64@synopsys.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-snps-arc>,
 <mailto:linux-snps-arc-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-snps-arc/>
List-Post: <mailto:linux-snps-arc@lists.infradead.org>
List-Help: <mailto:linux-snps-arc-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-snps-arc>,
 <mailto:linux-snps-arc-request@lists.infradead.org?subject=subscribe>
Sender: "linux-snps-arc" <linux-snps-arc-bounces@lists.infradead.org>
Errors-To: linux-snps-arc-bounces+gla-linux-snps-arc=m.gmane.org@lists.infradead.org
To: Vineet Gupta <Vineet.Gupta1@synopsys.com>
Cc: "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>, "linux-snps-arc@lists.infradead.org" <linux-snps-arc@lists.infradead.org>, Alexey Brodkin <Alexey.Brodkin@synopsys.com>, lkml <linux-kernel@vger.kernel.org>
List-Id: linux-arch.vger.kernel.org

On Wed, Mar 14, 2018 at 09:58:19AM -0700, Vineet Gupta wrote:

> Well it is broken wrt the semantics the syscall is supposed to provide.
> Preemption disabling is what prevents a concurrent thread from coming in and
> modifying the same location (Imagine a variable which is being cmpxchg
> concurrently by 2 threads).
> 
> One approach is to do it the MIPS way, emulate the llsc flag - set it under
> preemption disabled section and clear it in switch_to

*shudder*... just catch the -EFAULT, force the write fault and retry.

Something like:

int sys_cmpxchg(u32 __user *user_ptr, u32 old, u32 new)
{
	u32 val;
	int ret;

again:
	ret = 0;

	preempt_disable();
	val = get_user(user_ptr);
	if (val == old)
		ret = put_user(new, user_ptr);
	preempt_enable();

	if (ret == -EFAULT) {
		struct page *page;
		ret = get_user_pages_fast((unsigned long)user_ptr, 1, 1, &page);
		if (ret < 0)
			return ret;
		put_page(page);
		goto again;
	}

	return ret;
}
