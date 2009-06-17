From: Tejun Heo <tj@kernel.org>
Subject: [PATCH 7/9] alpha: kill unnecessary __used attribute in PER_CPU_ATTRIBUTES
Date: Wed, 17 Jun 2009 12:40:58 +0900
Message-ID: <1245210060-24344-8-git-send-email-tj@kernel.org>
References: <1245210060-24344-1-git-send-email-tj@kernel.org>
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from hera.kernel.org ([140.211.167.34]:48447 "EHLO hera.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758514AbZFQDmR (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Tue, 16 Jun 2009 23:42:17 -0400
In-Reply-To: <1245210060-24344-1-git-send-email-tj@kernel.org>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: linux-kernel@vger.kernel.org, x86@kernel.org, linux-arch@vger.kernel.org, mingo@elte.hu, kyle@mcmartin.ca, cl@linux-foundation.org, Jesper.Nilsson@axis.com, benh@kernel.crashing.org
Cc: Tejun Heo <tj@kernel.org>, Ivan Kokshaysky <ink@jurassic.park.msu.ru>, Richard Henderson <rth@twiddle.net>

With the previous percpu variable definition change, all percpu
variables are global and there's no need to specify __used, which only
triggers on recent compilers anyway.  Kill it.

[ Impact: remove unnecessary percpu attribute ]

Signed-off-by: Tejun Heo <tj@kernel.org>
Cc: Ivan Kokshaysky <ink@jurassic.park.msu.ru>
Cc: Richard Henderson <rth@twiddle.net>
---
 arch/alpha/include/asm/percpu.h |    5 -----
 1 files changed, 0 insertions(+), 5 deletions(-)

diff --git a/arch/alpha/include/asm/percpu.h b/arch/alpha/include/asm/percpu.h
index 06c5c7a..7f0a9c4 100644
--- a/arch/alpha/include/asm/percpu.h
+++ b/arch/alpha/include/asm/percpu.h
@@ -30,7 +30,6 @@ extern unsigned long __per_cpu_offset[NR_CPUS];
 
 #ifndef MODULE
 #define SHIFT_PERCPU_PTR(var, offset) RELOC_HIDE(&per_cpu_var(var), (offset))
-#define PER_CPU_ATTRIBUTES
 #else
 /*
  * To calculate addresses of locally defined variables, GCC uses 32-bit
@@ -49,8 +48,6 @@ extern unsigned long __per_cpu_offset[NR_CPUS];
 		: "=&r"(__ptr), "=&r"(tmp_gp));		\
 	(typeof(&per_cpu_var(var)))(__ptr + (offset)); })
 
-#define PER_CPU_ATTRIBUTES	__used
-
 #endif /* MODULE */
 
 /*
@@ -71,8 +68,6 @@ extern unsigned long __per_cpu_offset[NR_CPUS];
 #define __get_cpu_var(var)		per_cpu_var(var)
 #define __raw_get_cpu_var(var)		per_cpu_var(var)
 
-#define PER_CPU_ATTRIBUTES
-
 #endif /* SMP */
 
 #ifdef CONFIG_SMP
-- 
1.6.0.2
