Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from e33.co.us.ibm.com ([32.97.110.151]:53377 "EHLO
	e33.co.us.ibm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932196Ab3BIAks (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Fri, 8 Feb 2013 19:40:48 -0500
Received: from /spool/local
	by e33.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
	for <linux-arch@vger.kernel.org> from <paulmck@linux.vnet.ibm.com>;
	Fri, 8 Feb 2013 17:40:48 -0700
Date: Fri, 8 Feb 2013 16:16:49 -0800
From: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
Subject: Re: [PATCH v5 45/45] Documentation/cpu-hotplug: Remove references to
 stop_machine()
Message-ID: <20130209001649.GS2666@linux.vnet.ibm.com>
Reply-To: paulmck@linux.vnet.ibm.com
References: <20130122073210.13822.50434.stgit@srivatsabhat.in.ibm.com>
 <20130122074543.13822.44724.stgit@srivatsabhat.in.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20130122074543.13822.44724.stgit@srivatsabhat.in.ibm.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: "Srivatsa S. Bhat" <srivatsa.bhat@linux.vnet.ibm.com>
Cc: tglx@linutronix.de, peterz@infradead.org, tj@kernel.org, oleg@redhat.com, rusty@rustcorp.com.au, mingo@kernel.org, akpm@linux-foundation.org, namhyung@kernel.org, rostedt@goodmis.org, wangyun@linux.vnet.ibm.com, xiaoguangrong@linux.vnet.ibm.com, rjw@sisk.pl, sbw@mit.edu, fweisbec@gmail.com, linux@arm.linux.org.uk, nikunj@linux.vnet.ibm.com, linux-pm@vger.kernel.org, linux-arch@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linuxppc-dev@lists.ozlabs.org, netdev@vger.kernel.org, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Message-ID: <20130209001649.nppV280aRYioB2H6pCrmqLpCm6G3idZOCXmc_Pv30N4@z>

On Tue, Jan 22, 2013 at 01:15:48PM +0530, Srivatsa S. Bhat wrote:
> Since stop_machine() is no longer used in the CPU offline path, we cannot
> disable CPU hotplug using preempt_disable()/local_irq_disable() etc. We
> need to use the newly introduced get/put_online_cpus_atomic() APIs.
> Reflect this in the documentation.
> 
> Cc: Rob Landley <rob@landley.net>
> Cc: linux-doc@vger.kernel.org
> Signed-off-by: Srivatsa S. Bhat <srivatsa.bhat@linux.vnet.ibm.com>

Reviewed-by: Paul E. McKenney <paulmck@linux.vnet.ibm.com>

> ---
> 
>  Documentation/cpu-hotplug.txt |   17 +++++++++++------
>  1 file changed, 11 insertions(+), 6 deletions(-)
> 
> diff --git a/Documentation/cpu-hotplug.txt b/Documentation/cpu-hotplug.txt
> index 9f40135..7f907ec 100644
> --- a/Documentation/cpu-hotplug.txt
> +++ b/Documentation/cpu-hotplug.txt
> @@ -113,13 +113,15 @@ Never use anything other than cpumask_t to represent bitmap of CPUs.
>  	#include <linux/cpu.h>
>  	get_online_cpus() and put_online_cpus():
> 
> -The above calls are used to inhibit cpu hotplug operations. While the
> +The above calls are used to inhibit cpu hotplug operations, when invoked from
> +non-atomic context (because the above functions can sleep). While the
>  cpu_hotplug.refcount is non zero, the cpu_online_mask will not change.
> -If you merely need to avoid cpus going away, you could also use
> -preempt_disable() and preempt_enable() for those sections.
> -Just remember the critical section cannot call any
> -function that can sleep or schedule this process away. The preempt_disable()
> -will work as long as stop_machine_run() is used to take a cpu down.
> +
> +However, if you are executing in atomic context (ie., you can't afford to
> +sleep), and you merely need to avoid cpus going offline, you can use
> +get_online_cpus_atomic() and put_online_cpus_atomic() for those sections.
> +Just remember the critical section cannot call any function that can sleep or
> +schedule this process away.
> 
>  CPU Hotplug - Frequently Asked Questions.
> 
> @@ -360,6 +362,9 @@ A: There are two ways.  If your code can be run in interrupt context, use
>  		return err;
>  	}
> 
> +   If my_func_on_cpu() itself cannot block, use get/put_online_cpus_atomic()
> +   instead of get/put_online_cpus() to prevent CPUs from going offline.
> +
>  Q: How do we determine how many CPUs are available for hotplug.
>  A: There is no clear spec defined way from ACPI that can give us that
>     information today. Based on some input from Natalie of Unisys,
> 

