From: Catalin Marinas <catalin.marinas@arm.com>
Subject: Re: [PATCH v2 10/19] arm64: mte: Handle synchronous and asynchronous
 tag check faults
Date: Thu, 27 Feb 2020 11:50:31 +0000
Message-ID: <20200227115031.GC3281767@arrakis.emea.arm.com>
References: <20200226180526.3272848-1-catalin.marinas@arm.com>
 <20200226180526.3272848-11-catalin.marinas@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from foss.arm.com ([217.140.110.172]:49170 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728918AbgB0Luf (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Thu, 27 Feb 2020 06:50:35 -0500
Content-Disposition: inline
In-Reply-To: <20200226180526.3272848-11-catalin.marinas@arm.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: linux-arm-kernel@lists.infradead.org
Cc: Will Deacon <will@kernel.org>, Vincenzo Frascino <vincenzo.frascino@arm.com>, Szabolcs Nagy <szabolcs.nagy@arm.com>, Richard Earnshaw <Richard.Earnshaw@arm.com>, Kevin Brodsky <kevin.brodsky@arm.com>, Andrey Konovalov <andreyknvl@google.com>, Peter Collingbourne <pcc@google.com>, linux-mm@kvack.org, linux-arch@vger.kernel.org

On Wed, Feb 26, 2020 at 06:05:17PM +0000, Catalin Marinas wrote:
> diff --git a/arch/arm64/kernel/Makefile b/arch/arm64/kernel/Makefile
> index fc6488660f64..d4a378bc0a60 100644
> --- a/arch/arm64/kernel/Makefile
> +++ b/arch/arm64/kernel/Makefile
> @@ -63,6 +63,7 @@ obj-$(CONFIG_CRASH_CORE)		+= crash_core.o
>  obj-$(CONFIG_ARM_SDE_INTERFACE)		+= sdei.o
>  obj-$(CONFIG_ARM64_SSBD)		+= ssbd.o
>  obj-$(CONFIG_ARM64_PTR_AUTH)		+= pointer_auth.o
> +obj-$(CONFIG_ARM64_MTE)			+= mte.o
>  
>  obj-y					+= vdso/ probes/
>  obj-$(CONFIG_COMPAT_VDSO)		+= vdso32/
> diff --git a/arch/arm64/kernel/entry.S b/arch/arm64/kernel/entry.S
> index 9461d812ae27..9338b340e869 100644
> --- a/arch/arm64/kernel/entry.S
> +++ b/arch/arm64/kernel/entry.S
[...]
> @@ -738,6 +763,8 @@ work_pending:
>   */
>  ret_to_user:
>  	disable_daif
> +	/* Check for asynchronous tag check faults in the uaccess routines */
> +	check_mte_async_tcf x1, x2
>  	gic_prio_kentry_setup tmp=x3
>  	ldr	x1, [tsk, #TSK_TI_FLAGS]
>  	and	x2, x1, #_TIF_WORK_MASK

I got this wrong, check_mte_async expects the flags as the first
argument (one may experience weird behaviour with overriding the TIF
flags; thanks to Kevin for debugging). The diff below should fix it:

diff --git a/arch/arm64/kernel/entry.S b/arch/arm64/kernel/entry.S
index 9338b340e869..6e7f315911e8 100644
--- a/arch/arm64/kernel/entry.S
+++ b/arch/arm64/kernel/entry.S
@@ -764,9 +764,9 @@ work_pending:
 ret_to_user:
 	disable_daif
 	/* Check for asynchronous tag check faults in the uaccess routines */
-	check_mte_async_tcf x1, x2
 	gic_prio_kentry_setup tmp=x3
 	ldr	x1, [tsk, #TSK_TI_FLAGS]
+	check_mte_async_tcf x1, x2
 	and	x2, x1, #_TIF_WORK_MASK
 	cbnz	x2, work_pending
 finish_ret_to_user:
