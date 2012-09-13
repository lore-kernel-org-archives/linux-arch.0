From: Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH 3/3] mm: Introduce HAVE_ARCH_TRANSPARENT_HUGEPAGE
Date: Thu, 13 Sep 2012 14:40:25 -0700
Message-ID: <20120913144025.b1760af4.akpm@linux-foundation.org>
References: <1347382036-18455-1-git-send-email-will.deacon@arm.com>
	<1347382036-18455-4-git-send-email-will.deacon@arm.com>
	<20120913120514.135d2c38.akpm@linux-foundation.org>
	<20120914072732.637f4225c32565468f468305@canb.auug.org.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mail.linuxfoundation.org ([140.211.169.12]:50559 "EHLO
	mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752799Ab2IMVk1 (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Thu, 13 Sep 2012 17:40:27 -0400
In-Reply-To: <20120914072732.637f4225c32565468f468305@canb.auug.org.au>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Stephen Rothwell <sfr@canb.auug.org.au>
Cc: Will Deacon <will.deacon@arm.com>, linux-mm@kvack.org, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, mhocko@suse.cz, Steve Capper <steve.capper@arm.com>, Gerald Schaefer <gerald.schaefer@de.ibm.com>

On Fri, 14 Sep 2012 07:27:32 +1000
Stephen Rothwell <sfr@canb.auug.org.au> wrote:

> Hi Andrew,
> 
> On Thu, 13 Sep 2012 12:05:14 -0700 Andrew Morton <akpm@linux-foundation.org> wrote:
> >
> > diff -puN arch/x86/Kconfig~mm-introduce-have_arch_transparent_hugepage arch/x86/Kconfig
> > --- a/arch/x86/Kconfig~mm-introduce-have_arch_transparent_hugepage
> > +++ a/arch/x86/Kconfig
> > @@ -83,7 +83,6 @@ config X86
> >  	select IRQ_FORCED_THREADING
> >  	select USE_GENERIC_SMP_HELPERS if SMP
> >  	select HAVE_BPF_JIT if X86_64
> > -	select HAVE_ARCH_TRANSPARENT_HUGEPAGE
> 
> Why not
> 	select HAVE_ARCH_TRANSPARENT_HUGEPAGE if MMU
> 

Well, this is in arch/x86/Kconfig, where MMU is known to always be set.

Yes, I think Gerald's patch will suffice:

--- a/arch/Kconfig~thp-x86-introduce-have_arch_transparent_hugepage
+++ a/arch/Kconfig
@@ -326,4 +326,7 @@ config HAVE_RCU_USER_QS
 	  are already protected inside rcu_irq_enter/rcu_irq_exit() but
 	  preemption or signal handling on irq exit still need to be protected.
 
+config HAVE_ARCH_TRANSPARENT_HUGEPAGE
+	bool
+
 source "kernel/gcov/Kconfig"
--- a/arch/x86/Kconfig~thp-x86-introduce-have_arch_transparent_hugepage
+++ a/arch/x86/Kconfig
@@ -83,6 +83,7 @@ config X86
 	select IRQ_FORCED_THREADING
 	select USE_GENERIC_SMP_HELPERS if SMP
 	select HAVE_BPF_JIT if X86_64
+	select HAVE_ARCH_TRANSPARENT_HUGEPAGE
 	select CLKEVT_I8253
 	select ARCH_HAVE_NMI_SAFE_CMPXCHG
 	select GENERIC_IOMAP
--- a/mm/Kconfig~thp-x86-introduce-have_arch_transparent_hugepage
+++ a/mm/Kconfig
@@ -318,7 +318,7 @@ config NOMMU_INITIAL_TRIM_EXCESS
 
 config TRANSPARENT_HUGEPAGE
 	bool "Transparent Hugepage Support"
-	depends on X86 && MMU
+	depends on HAVE_ARCH_TRANSPARENT_HUGEPAGE
 	select COMPACTION
 	help
 	  Transparent Hugepages allows the kernel to use huge pages and
_
