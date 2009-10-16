From: Arun R Bharadwaj <arun@linux.vnet.ibm.com>
Subject: [v9 PATCH 7/9]: POWER: add a default_idle idle loop for POWER.
Date: Fri, 16 Oct 2009 15:16:46 +0530
Message-ID: <20091016094646.GI27350@linux.vnet.ibm.com>
References: <20091016093850.GB27350@linux.vnet.ibm.com>
Reply-To: arun@linux.vnet.ibm.com
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linuxppc-dev-bounces+glppd-linuxppc64-dev=m.gmane.org@lists.ozlabs.org>
Content-Disposition: inline
In-Reply-To: <20091016093850.GB27350@linux.vnet.ibm.com>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>
Sender: linuxppc-dev-bounces+glppd-linuxppc64-dev=m.gmane.org@lists.ozlabs.org
Errors-To: linuxppc-dev-bounces+glppd-linuxppc64-dev=m.gmane.org@lists.ozlabs.org
To: Peter Zijlstra <a.p.zijlstra@chello.nl>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Ingo Molnar <mingo@elte.hu>, Vaidyanathan Srinivasan <svaidy@linux.vnet.ibm.com>, Dipankar
Cc: linux-arch@vger.kernel.org, linux-acpi@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
List-Id: linux-arch.vger.kernel.org

* Arun R Bharadwaj <arun@linux.vnet.ibm.com> [2009-10-16 15:08:50]:

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
