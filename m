Return-Path: <linux-arch-owner@vger.kernel.org>
Message-ID: <42462275.1000101@yahoo.com.au>
Date: Sun, 27 Mar 2005 13:03:17 +1000
From: Nick Piggin <nickpiggin@yahoo.com.au>
MIME-Version: 1.0
Subject: Re: [patch] sched: remove scheduler locking from arch code
References: <4245631A.1070806@yahoo.com.au>
In-Reply-To: <4245631A.1070806@yahoo.com.au>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
To: Ingo Molnar <mingo@elte.hu>
Cc: linux-arch@vger.kernel.org, "David S. Miller" <davem@davemloft.net>, Russell King <rmk@arm.linux.org.uk>
List-ID: <linux-arch.vger.kernel.org>

Nick Piggin wrote:

> Index: linux-2.6/include/linux/init_task.h
> ===================================================================
> --- linux-2.6.orig/include/linux/init_task.h	2005-03-26 19:24:10.000000000 +1100
> +++ linux-2.6/include/linux/init_task.h	2005-03-26 23:55:46.000000000 +1100
> @@ -74,14 +74,13 @@ extern struct group_info init_groups;
>  	.usage		= ATOMIC_INIT(2),				\
>  	.flags		= 0,						\
>  	.lock_depth	= -1,						\
> -	.prio		= MAX_PRIO-20,					\
> -	.static_prio	= MAX_PRIO-20,					\
> +	.prio		= MAX_PRIO-29,					\
> +	.static_prio	= MAX_PRIO-29,					\
>  	.policy		= SCHED_NORMAL,					\
>  	.cpus_allowed	= CPU_MASK_ALL,					\
>  	.mm		= NULL,						\
>  	.active_mm	= &init_mm,					\
>  	.run_list	= LIST_HEAD_INIT(tsk.run_list),			\
> -	.time_slice	= HZ,						\
>  	.tasks		= LIST_HEAD_INIT(tsk.tasks),			\
>  	.ptrace_children= LIST_HEAD_INIT(tsk.ptrace_children),		\
>  	.ptrace_list	= LIST_HEAD_INIT(tsk.ptrace_list),		\

This hunk crept in from another patch. I'll fix that up.
