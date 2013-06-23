Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail-la0-f51.google.com ([209.85.215.51]:52767 "EHLO
	mail-la0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751803Ab3FWPI4 (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Sun, 23 Jun 2013 11:08:56 -0400
Received: by mail-la0-f51.google.com with SMTP id fq12so9120989lab.24
        for <linux-arch@vger.kernel.org>; Sun, 23 Jun 2013 08:08:54 -0700 (PDT)
Message-ID: <51C70F82.4030101@cogentembedded.com>
Date: Sun, 23 Jun 2013 19:08:50 +0400
From: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
MIME-Version: 1.0
Subject: Re: [PATCH 07/45] CPU hotplug: Expose the new debug config option
References: <20130623133642.19094.16038.stgit@srivatsabhat.in.ibm.com> <20130623133928.19094.8259.stgit@srivatsabhat.in.ibm.com>
In-Reply-To: <20130623133928.19094.8259.stgit@srivatsabhat.in.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: "Srivatsa S. Bhat" <srivatsa.bhat@linux.vnet.ibm.com>
Cc: tglx@linutronix.de, peterz@infradead.org, tj@kernel.org, oleg@redhat.com, paulmck@linux.vnet.ibm.com, rusty@rustcorp.com.au, mingo@kernel.org, akpm@linux-foundation.org, namhyung@kernel.org, walken@google.com, vincent.guittot@linaro.org, laijs@cn.fujitsu.com, rostedt@goodmis.org, wangyun@linux.vnet.ibm.com, xiaoguangrong@linux.vnet.ibm.com, sbw@mit.edu, fweisbec@gmail.com, zhong@linux.vnet.ibm.com, nikunj@linux.vnet.ibm.com, linux-pm@vger.kernel.org, linux-arch@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, "Paul E. McKenney" <paul.mckenney@linaro.org>, Akinobu Mita <akinobu.mita@gmail.com>, Catalin Marinas <catalin.marinas@arm.com>
Message-ID: <20130623150850.ier8RiH_ATQCFE7my3MPr1q3K_bR4rtDs_dJkiaysaw@z>

Hello.

On 23-06-2013 17:39, Srivatsa S. Bhat wrote:

> Now that we have all the pieces of the CPU hotplug debug infrastructure
> in place, expose the feature by growing a new Kconfig option,
> CONFIG_DEBUG_HOTPLUG_CPU.

> Cc: Andrew Morton <akpm@linux-foundation.org>
> Cc: "Paul E. McKenney" <paul.mckenney@linaro.org>
> Cc: Akinobu Mita <akinobu.mita@gmail.com>
> Cc: Catalin Marinas <catalin.marinas@arm.com>
> Cc: Michel Lespinasse <walken@google.com>
> Signed-off-by: Srivatsa S. Bhat <srivatsa.bhat@linux.vnet.ibm.com>
> ---

>   lib/Kconfig.debug |    9 +++++++++
>   1 file changed, 9 insertions(+)

> diff --git a/lib/Kconfig.debug b/lib/Kconfig.debug
> index 566cf2b..6be1e72 100644
> --- a/lib/Kconfig.debug
> +++ b/lib/Kconfig.debug
> @@ -512,6 +512,15 @@ config DEBUG_PREEMPT
>   	  if kernel code uses it in a preemption-unsafe way. Also, the kernel
>   	  will detect preemption count underflows.
>
> +config DEBUG_HOTPLUG_CPU
> +	bool "Debug CPU hotplug"
> +	depends on HOTPLUG_CPU
> +	default n

     It's the default default, no need to specify it.

WBR, Sergei

