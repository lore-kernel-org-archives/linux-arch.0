From: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
Subject: Re: [RFC PATCH for 4.14 1/2] membarrier: Remove unused code for
 architectures without membarrier hooks
Date: Fri, 6 Oct 2017 14:08:01 -0700
Message-ID: <20171006210801.GL3521@linux.vnet.ibm.com>
References: <20171005223327.3500-1-mathieu.desnoyers@efficios.com>
Reply-To: paulmck@linux.vnet.ibm.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:34248 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751484AbdJFVII (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 6 Oct 2017 17:08:08 -0400
Received: from pps.filterd (m0098396.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id v96L7PPj011950
        for <linux-arch@vger.kernel.org>; Fri, 6 Oct 2017 17:08:08 -0400
Received: from e13.ny.us.ibm.com (e13.ny.us.ibm.com [129.33.205.203])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2dedey3j0d-1
        (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
        for <linux-arch@vger.kernel.org>; Fri, 06 Oct 2017 17:08:08 -0400
Received: from localhost
        by e13.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-arch@vger.kernel.org> from <paulmck@linux.vnet.ibm.com>;
        Fri, 6 Oct 2017 17:08:06 -0400
Content-Disposition: inline
In-Reply-To: <20171005223327.3500-1-mathieu.desnoyers@efficios.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: Peter Zijlstra <peterz@infradead.org>, linux-kernel@vger.kernel.org, Boqun Feng <boqun.feng@gmail.com>, Andrew Hunter <ahh@google.com>, Maged Michael <maged.michael@gmail.com>, gromer@google.com, Avi Kivity <avi@scylladb.com>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>, Dave Watson <davejwatson@fb.com>, Alan Stern <stern@rowland.harvard.edu>, Will Deacon <will.deacon@arm.com>, Andy Lutomirski <luto@kernel.org>, Ingo Molnar <mingo@redhat.com>, Alexander Viro <viro@zeniv.linux.org.uk>, linuxppc-dev@lists.ozlabs.org, linux-arch@vger.kernel.org

On Thu, Oct 05, 2017 at 06:33:26PM -0400, Mathieu Desnoyers wrote:
> Architectures without membarrier hooks don't need to emit the
> empty membarrier_arch_switch_mm() static inline when
> CONFIG_MEMBARRIER=y.
> 
> Adapt the CONFIG_MEMBARRIER=n counterpart to only emit the empty
> membarrier_arch_switch_mm() for architectures with membarrier hooks.
> 
> Reported-by: Nicholas Piggin <npiggin@gmail.com>
> Signed-off-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>

Queued for further review and testing, targeting v4.15.  Please let me
know if you need it sooner.

							Thanx, Paul

> CC: Peter Zijlstra <peterz@infradead.org>
> CC: Paul E. McKenney <paulmck@linux.vnet.ibm.com>
> CC: Boqun Feng <boqun.feng@gmail.com>
> CC: Andrew Hunter <ahh@google.com>
> CC: Maged Michael <maged.michael@gmail.com>
> CC: gromer@google.com
> CC: Avi Kivity <avi@scylladb.com>
> CC: Benjamin Herrenschmidt <benh@kernel.crashing.org>
> CC: Paul Mackerras <paulus@samba.org>
> CC: Michael Ellerman <mpe@ellerman.id.au>
> CC: Dave Watson <davejwatson@fb.com>
> CC: Alan Stern <stern@rowland.harvard.edu>
> CC: Will Deacon <will.deacon@arm.com>
> CC: Andy Lutomirski <luto@kernel.org>
> CC: Ingo Molnar <mingo@redhat.com>
> CC: Alexander Viro <viro@zeniv.linux.org.uk>
> CC: linuxppc-dev@lists.ozlabs.org
> CC: linux-arch@vger.kernel.org
> ---
>  include/linux/sched/mm.h | 6 ++----
>  1 file changed, 2 insertions(+), 4 deletions(-)
> 
> diff --git a/include/linux/sched/mm.h b/include/linux/sched/mm.h
> index d5a9ab8f3836..b2767ecb21a8 100644
> --- a/include/linux/sched/mm.h
> +++ b/include/linux/sched/mm.h
> @@ -215,10 +215,6 @@ static inline void memalloc_noreclaim_restore(unsigned int flags)
>  #ifdef CONFIG_ARCH_HAS_MEMBARRIER_HOOKS
>  #include <asm/membarrier.h>
>  #else
> -static inline void membarrier_arch_switch_mm(struct mm_struct *prev,
> -		struct mm_struct *next, struct task_struct *tsk)
> -{
> -}
>  static inline void membarrier_arch_fork(struct task_struct *t,
>  		unsigned long clone_flags)
>  {
> @@ -247,10 +243,12 @@ static inline void membarrier_execve(struct task_struct *t)
>  	membarrier_arch_execve(t);
>  }
>  #else
> +#ifdef CONFIG_ARCH_HAS_MEMBARRIER_HOOKS
>  static inline void membarrier_arch_switch_mm(struct mm_struct *prev,
>  		struct mm_struct *next, struct task_struct *tsk)
>  {
>  }
> +#endif
>  static inline void membarrier_fork(struct task_struct *t,
>  		unsigned long clone_flags)
>  {
> -- 
> 2.11.0
> 
