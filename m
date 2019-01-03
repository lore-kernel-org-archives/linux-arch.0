From: Masahiro Yamada <yamada.masahiro@socionext.com>
Subject: [PATCH 5/5] kbuild: warn redundant generic-y
Date: Thu,  3 Jan 2019 10:10:40 +0900
Message-ID: <1546477840-14278-5-git-send-email-yamada.masahiro@socionext.com>
References: <1546477840-14278-1-git-send-email-yamada.masahiro@socionext.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1546477840-14278-1-git-send-email-yamada.masahiro@socionext.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: linux-kbuild@vger.kernel.org
Cc: linux-arch@vger.kernel.org, Masahiro Yamada <yamada.masahiro@socionext.com>, linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-arch.vger.kernel.org

The generic-y is redundant under the following condition:

 - arch has its own implementation

 - the same header is added to generated-y

 - the same header is added to mandatory-y

If a redundant generic-y is found, the warning like follows is displayed:

  scripts/Makefile.asm-generic:20: redundant generic-y found in arch/arm/include/asm/Kbuild: timex.h

I fixed up arch Kbuild files found by this.

Suggested-by: Sam Ravnborg <sam@ravnborg.org>
Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
---

Changes in v2: None

 arch/arc/include/asm/Kbuild      | 4 ----
 arch/arm/include/asm/Kbuild      | 1 -
 arch/h8300/include/asm/Kbuild    | 1 -
 arch/openrisc/include/asm/Kbuild | 2 --
 arch/parisc/include/asm/Kbuild   | 2 --
 arch/powerpc/include/asm/Kbuild  | 1 -
 arch/s390/include/asm/Kbuild     | 1 -
 arch/um/include/asm/Kbuild       | 2 --
 arch/xtensa/include/asm/Kbuild   | 1 -
 scripts/Makefile.asm-generic     | 6 ++++++
 10 files changed, 6 insertions(+), 15 deletions(-)

diff --git a/arch/arc/include/asm/Kbuild b/arch/arc/include/asm/Kbuild
index feed50c..caa2702 100644
--- a/arch/arc/include/asm/Kbuild
+++ b/arch/arc/include/asm/Kbuild
@@ -3,23 +3,19 @@ generic-y += bugs.h
 generic-y += compat.h
 generic-y += device.h
 generic-y += div64.h
-generic-y += dma-mapping.h
 generic-y += emergency-restart.h
 generic-y += extable.h
-generic-y += fb.h
 generic-y += ftrace.h
 generic-y += hardirq.h
 generic-y += hw_irq.h
 generic-y += irq_regs.h
 generic-y += irq_work.h
-generic-y += kmap_types.h
 generic-y += local.h
 generic-y += local64.h
 generic-y += mcs_spinlock.h
 generic-y += mm-arch-hooks.h
 generic-y += msi.h
 generic-y += parport.h
-generic-y += pci.h
 generic-y += percpu.h
 generic-y += preempt.h
 generic-y += topology.h
diff --git a/arch/arm/include/asm/Kbuild b/arch/arm/include/asm/Kbuild
index 1d66db9..a8a4eb7 100644
--- a/arch/arm/include/asm/Kbuild
+++ b/arch/arm/include/asm/Kbuild
@@ -18,7 +18,6 @@ generic-y += segment.h
 generic-y += serial.h
 generic-y += simd.h
 generic-y += sizes.h
-generic-y += timex.h
 generic-y += trace_clock.h
 
 generated-y += mach-types.h
diff --git a/arch/h8300/include/asm/Kbuild b/arch/h8300/include/asm/Kbuild
index a5d0b29..ed6f2bf 100644
--- a/arch/h8300/include/asm/Kbuild
+++ b/arch/h8300/include/asm/Kbuild
@@ -17,7 +17,6 @@ generic-y += fb.h
 generic-y += ftrace.h
 generic-y += futex.h
 generic-y += hardirq.h
-generic-y += hash.h
 generic-y += hw_irq.h
 generic-y += irq_regs.h
 generic-y += irq_work.h
diff --git a/arch/openrisc/include/asm/Kbuild b/arch/openrisc/include/asm/Kbuild
index eb87cd8..5be3f32 100644
--- a/arch/openrisc/include/asm/Kbuild
+++ b/arch/openrisc/include/asm/Kbuild
@@ -15,7 +15,6 @@ generic-y += fb.h
 generic-y += ftrace.h
 generic-y += hardirq.h
 generic-y += hw_irq.h
-generic-y += irq.h
 generic-y += irq_regs.h
 generic-y += irq_work.h
 generic-y += kdebug.h
@@ -34,7 +33,6 @@ generic-y += qrwlock_types.h
 generic-y += qrwlock.h
 generic-y += sections.h
 generic-y += segment.h
-generic-y += string.h
 generic-y += switch_to.h
 generic-y += topology.h
 generic-y += trace_clock.h
diff --git a/arch/parisc/include/asm/Kbuild b/arch/parisc/include/asm/Kbuild
index 0b1e354..6f49e77 100644
--- a/arch/parisc/include/asm/Kbuild
+++ b/arch/parisc/include/asm/Kbuild
@@ -1,7 +1,6 @@
 generated-y += syscall_table_32.h
 generated-y += syscall_table_64.h
 generated-y += syscall_table_c32.h
-generic-y += barrier.h
 generic-y += current.h
 generic-y += device.h
 generic-y += div64.h
@@ -20,7 +19,6 @@ generic-y += percpu.h
 generic-y += preempt.h
 generic-y += seccomp.h
 generic-y += segment.h
-generic-y += topology.h
 generic-y += trace_clock.h
 generic-y += user.h
 generic-y += vga.h
diff --git a/arch/powerpc/include/asm/Kbuild b/arch/powerpc/include/asm/Kbuild
index 77ff7fb..a0c132b 100644
--- a/arch/powerpc/include/asm/Kbuild
+++ b/arch/powerpc/include/asm/Kbuild
@@ -5,7 +5,6 @@ generated-y += syscall_table_spu.h
 generic-y += div64.h
 generic-y += export.h
 generic-y += irq_regs.h
-generic-y += irq_work.h
 generic-y += local64.h
 generic-y += mcs_spinlock.h
 generic-y += preempt.h
diff --git a/arch/s390/include/asm/Kbuild b/arch/s390/include/asm/Kbuild
index e323977..12d77cb 100644
--- a/arch/s390/include/asm/Kbuild
+++ b/arch/s390/include/asm/Kbuild
@@ -20,7 +20,6 @@ generic-y += local.h
 generic-y += local64.h
 generic-y += mcs_spinlock.h
 generic-y += mm-arch-hooks.h
-generic-y += preempt.h
 generic-y += rwsem.h
 generic-y += trace_clock.h
 generic-y += unaligned.h
diff --git a/arch/um/include/asm/Kbuild b/arch/um/include/asm/Kbuild
index b10dde6..00bcbe2 100644
--- a/arch/um/include/asm/Kbuild
+++ b/arch/um/include/asm/Kbuild
@@ -10,9 +10,7 @@ generic-y += exec.h
 generic-y += extable.h
 generic-y += ftrace.h
 generic-y += futex.h
-generic-y += hardirq.h
 generic-y += hw_irq.h
-generic-y += io.h
 generic-y += irq_regs.h
 generic-y += irq_work.h
 generic-y += kdebug.h
diff --git a/arch/xtensa/include/asm/Kbuild b/arch/xtensa/include/asm/Kbuild
index e255683..322b2fd 100644
--- a/arch/xtensa/include/asm/Kbuild
+++ b/arch/xtensa/include/asm/Kbuild
@@ -15,7 +15,6 @@ generic-y += irq_work.h
 generic-y += kdebug.h
 generic-y += kmap_types.h
 generic-y += kprobes.h
-generic-y += linkage.h
 generic-y += local.h
 generic-y += local64.h
 generic-y += mcs_spinlock.h
diff --git a/scripts/Makefile.asm-generic b/scripts/Makefile.asm-generic
index a62d282..c7d2b7a 100644
--- a/scripts/Makefile.asm-generic
+++ b/scripts/Makefile.asm-generic
@@ -14,6 +14,12 @@ src := $(subst /generated,,$(obj))
 
 include scripts/Kbuild.include
 
+redundant := $(filter $(mandatory-y) $(generated-y), $(generic-y))
+redundant += $(foreach f, $(generic-y), $(if $(wildcard $(srctree)/$(src)/$(f)),$(f)))
+redundant := $(sort $(redundant))
+$(if $(redundant),\
+	$(warning redundant generic-y found in $(src)/Kbuild: $(redundant)))
+
 # If arch does not implement mandatory headers, fallback to asm-generic ones.
 mandatory-y := $(filter-out $(generated-y), $(mandatory-y))
 generic-y   += $(foreach f, $(mandatory-y), $(if $(wildcard $(srctree)/$(src)/$(f)),,$(f)))
-- 
2.7.4
