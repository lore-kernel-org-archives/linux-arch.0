From: Arun R Bharadwaj <arun@linux.vnet.ibm.com>
Subject: [v10 PATCH 7/9]: POWER: add a default_idle idle loop for POWER
Date: Wed, 2 Dec 2009 15:31:54 +0530
Message-ID: <20091202100154.GH27251@linux.vnet.ibm.com>
References: <20091202095427.GA27251@linux.vnet.ibm.com>
Reply-To: arun@linux.vnet.ibm.com
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Return-path: <linux-acpi-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20091202095427.GA27251@linux.vnet.ibm.com>
Sender: linux-acpi-owner@vger.kernel.org
To: Peter Zijlstra <a.p.zijlstra@chello.nl>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Ingo Molnar <mingo@elte.hu>, Vaidyanathan Srinivasan <svaidy@linux.vnet.ibm.com>, Dipankar
Cc: linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, linux-arch@vger.kernel.org, linux-acpi@vger.kernel.org
List-Id: linux-arch.vger.kernel.org

* Arun R Bharadwaj <arun@linux.vnet.ibm.com> [2009-12-02 15:24:27]:

In arch/powerpc/kernel/idle.c create a default_idle() routine by moving
the failover condition of the cpu_idle() idle loop. This is needed by
cpuidle infrastructure to call default_idle when other idle routines
are not yet registered. Functionality remains the same, but the code is
slightly moved around.


Signed-off-by: Arun R Bharadwaj <arun@linux.vnet.ibm.com>
---
 arch/powerpc/Kconfig              |    3 +++
 arch/powerpc/include/asm/system.h |    1 +
 arch/powerpc/kernel/idle.c        |    6 ++++++
 3 files changed, 10 insertions(+)

Index: linux.trees.git/arch/powerpc/Kconfig
===================================================================
--- linux.trees.git.orig/arch/powerpc/Kconfig
+++ linux.trees.git/arch/powerpc/Kconfig
@@ -94,6 +94,9 @@ config ARCH_HAS_ILOG2_U64
 config ARCH_HAS_CPU_IDLE_WAIT
 	def_bool y
 
+config ARCH_HAS_DEFAULT_IDLE
+	def_bool y
+
 config GENERIC_HWEIGHT
 	bool
 	default y
Index: linux.trees.git/arch/powerpc/include/asm/system.h
===================================================================
--- linux.trees.git.orig/arch/powerpc/include/asm/system.h
+++ linux.trees.git/arch/powerpc/include/asm/system.h
@@ -218,6 +218,7 @@ extern unsigned long klimit;
 extern void *alloc_maybe_bootmem(size_t size, gfp_t mask);
 extern void *zalloc_maybe_bootmem(size_t size, gfp_t mask);
 
+extern void default_idle(void);
 extern int powersave_nap;	/* set if nap mode can be used in idle loop */
 
 /*
Index: linux.trees.git/arch/powerpc/kernel/idle.c
===================================================================
--- linux.trees.git.orig/arch/powerpc/kernel/idle.c
+++ linux.trees.git/arch/powerpc/kernel/idle.c
@@ -121,6 +121,12 @@ void cpu_idle_wait(void)
 }
 EXPORT_SYMBOL_GPL(cpu_idle_wait);
 
+void default_idle(void)
+{
+	HMT_low();
+	HMT_very_low();
+}
+
 int powersave_nap;
 
 #ifdef CONFIG_SYSCTL
