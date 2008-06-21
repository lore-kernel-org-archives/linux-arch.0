From: Peter Zijlstra <a.p.zijlstra@chello.nl>
Subject: Re: [RFC PATCH]rcu,alpha: avoid smp_read_barrier_depends in
	rcu_dereference when pointer==NULL
Date: Sat, 21 Jun 2008 14:52:25 +0200
Message-ID: <1214052746.3223.218.camel@lappy.programming.kicks-ass.net>
References: <485CCFB9.9050208@cn.fujitsu.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from casper.infradead.org ([85.118.1.10]:40327 "EHLO
	casper.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750773AbYFUMwx (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Sat, 21 Jun 2008 08:52:53 -0400
In-Reply-To: <485CCFB9.9050208@cn.fujitsu.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Lai Jiangshan <laijs@cn.fujitsu.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>, linux-arch@vger.kernel.org, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>

On Sat, 2008-06-21 at 17:54 +0800, Lai Jiangshan wrote:
> Hi, Paul and Alpha hackers
> 
> memory barrier is expensive, I think it's worth that adding an if-statement
> to avoid it when pointer == NULL.
> 
> This patch change nothing in UP or in other architectures for compiler's
> optimization.

I suspect this optimization is invalid in the case where the loaded
value is used as an offset (either pointer or array index). But I'm
afraid I'll have to defer to Paul for explanations..


> 			Thanks, Lai Jiangshan
> 
> 
> Signed-off-by: Lai Jiangshan <laijs@cn.fujitsu.com>
> ---
> diff --git a/include/linux/rcupdate.h b/include/linux/rcupdate.h
> index d42dbec..8979f29 100644
> --- a/include/linux/rcupdate.h
> +++ b/include/linux/rcupdate.h
> @@ -143,7 +143,8 @@ struct rcu_head {
>  
>  #define rcu_dereference(p)     ({ \
>  				typeof(p) _________p1 = ACCESS_ONCE(p); \
> -				smp_read_barrier_depends(); \
> +				if (_________p1) \
> +					smp_read_barrier_depends(); \
>  				(_________p1); \
>  				})
>  
> 
> 
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
