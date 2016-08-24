From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH] arm: add an option for erratum 657417
Date: Wed, 24 Aug 2016 09:41:39 +0200
Message-ID: <3214675.EzzC1Ail5Z@wuerfel>
References: <1470989957-23671-1-git-send-email-npiggin@gmail.com>
 <2466265.8og15RQ8jv@wuerfel> <20160824140044.266d045d@roar.ozlabs.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20160824140044.266d045d@roar.ozlabs.ibm.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Nicholas Piggin <npiggin@gmail.com>
Cc: Nicolas Pitre <nicolas.pitre@linaro.org>, linux-arch@vger.kernel.org, Segher Boessenkool <segher@kernel.crashing.org>, Alan Modra <amodra@gmail.com>, linux-kbuild@vger.kernel.org, Russell King <linux@armlinux.org.uk>, Julian Brown <julian@codesourcery.com>, Michal Marek <mmarek@suse.com>, Stephen Rothwell <sfr@canb.auug.org.au>, Sam Ravnborg <sam@ravnborg.org>, linux-arm-kernel@lists.infradead.org
List-Id: linux-arch.vger.kernel.org

On Wednesday, August 24, 2016 2:00:44 PM CEST Nicholas Piggin wrote:
> On Tue, 23 Aug 2016 14:01:29 +0200
> Arnd Bergmann <arnd@arndb.de> wrote:
> 
> > On Friday, August 12, 2016 6:19:17 PM CEST Nicholas Piggin wrote:
> > > Erratum 657417 is worked around by the linker by inserting additional
> > > branch trampolines to avoid problematic branch target locations. This
> > > results in much higher linking time and presumably slower and larger
> > > generated code. The workaround also seems to only be required when
> > > linking thumb2 code, but the linker applies it for non-thumb2 code as
> > > well.
> > > 
> > > The workaround today is left to the linker to apply, which is overly
> > > conservative.
> > > 
> > > https://sourceware.org/ml/binutils/2009-05/msg00297.html
> > > 
> > > This patch adds an option which defaults to "y" in cases where we
> > > could possibly be running Cortex A8 and using Thumb2 instructions.
> > > In reality the workaround might not be required at all for the kernel
> > > if virtual instruction memory is linear in physical memory. However it
> > > is more conservative to keep the workaround, and it may be the case
> > > that the TLB lookup would be required in order to catch branches to
> > > unmapped or no-execute pages.
> > > 
> > > In an allyesconfig build, this workaround causes a large load on
> > > the linker's branch stub hash and slows down the final link by a
> > > factor of 5.
> > > 
> > > Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
> > >   
> > 
> > Thanks a lot for finding this issue. I can confirm that your patch
> > helps noticeably in all configurations, reducing time for a relink
> > from 18 minutes to 9 minutes on my machine in the best case, but
> > the factor 10 slowdown of the final link with your thin archives
> > and gc-sections patches remains.
> > 
> > I suspect there is still something else going on besides the 657417
> > slowing things down, but it's also possible that I'm doing something
> > wrong here.
> 
> Okay, I was only testing thin archives. gc-sections I didn't look at.
> With thin archives, one final arm allyesconfig link with this patch is
> not showing a regression. gc-sections must be causing something else
> ARM specific, because powerpc seems to link fast with gc-sections.

Ok, I see. For completeness, here are my results with thin archives and
without gc-sections on ARM:

|| no THUMB2, thin archives, no gc-sections, before: 144 seconds

09:29:51   LINK    vmlinux
09:29:51  AR      built-in.o
09:29:52  LD      vmlinux.o
09:30:12   MODPOST vmlinux.o
09:30:14  GEN     .version
09:30:14   CHK     include/generated/compile.h
  UPD     include/generated/compile.h
09:30:14   CC      init/version.o
09:30:15   AR      init/built-in.o
09:30:43  KSYM    .tmp_kallsyms1.o
09:31:28  KSYM    .tmp_kallsyms2.o
09:31:40  LD      vmlinux
09:32:13  SORTEX  vmlinux
09:32:13  SYSMAP  System.map
09:32:15   OBJCOPY arch/arm/boot/Image

|| no THUMB2, thin archives, no gc-sections, after: 70 seconds

09:33:54   LINK    vmlinux
09:33:54  AR      built-in.o
09:33:55  LD      vmlinux.o
09:34:13   MODPOST vmlinux.o
09:34:15  GEN     .version
09:34:16   CHK     include/generated/compile.h
  UPD     include/generated/compile.h
09:34:16   CC      init/version.o
09:34:16   AR      init/built-in.o
09:34:24  KSYM    .tmp_kallsyms1.o
09:34:43  KSYM    .tmp_kallsyms2.o
09:34:55  LD      vmlinux
09:35:03  SORTEX  vmlinux
09:35:03  SYSMAP  System.map
09:35:04   OBJCOPY arch/arm/boot/Image

The final 'LD' step is much faster here as you also found, and now
the time for the complete link is mainly the initial 'LD vmlinux.o'
step, which did not get faster with your patch.

> Can you send your latest ARM patch to enable this and I'll have a look
> at it?

See below. I have not updated the patch description yet, but included
the changes that Nico suggested. The test above used the same patch
but left out the 'select LD_DEAD_CODE_DATA_ELIMINATION' line.

	Arnd

commit 0cfcd63ca78c8f754e57bc8b0c9f6a18dfd2caa4
Author: Arnd Bergmann <arnd@arndb.de>
Date:   Sat Aug 6 22:46:26 2016 +0200

    [EXPERIMENTAL] enable thin archives and --gc-sections on ARM
    
    This goes on top of Nick's latest version of "[PATCH 0/6 v2] kbuild changes,
    thin archives, --gc-sections" and enables both features on ARM.
    
    It's a bit half-baked, these are known problems:
    
    - as big-endian support is still broken, I disable it in Kconfig
      so an allyesconfig build ends up as little-endian
    
    - I've thrown in a change to include/asm-generic/vmlinux.lds.h
      but don't know whether this is the right way or not. We have
      to keep .text.fixup linked together with .text, but I separate
      out .text.unlikely and .text.hot again. This has not caused
      any link failures for me (yet).
    
    - I mark a ton of sections as KEEP() in vmlinux.lds.S. Some of
      them might not actually be needed, and I have not spent much
      time checking what they actually are. However, I did build
      a few hundred randconfigs without new issues.
    
    Signed-off-by: Arnd Bergmann <arnd@arndb.de>

diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index b62ae32f8a1e..9bf37a6e7384 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -83,6 +83,7 @@ config ARM
 	select HAVE_UID16
 	select HAVE_VIRT_CPU_ACCOUNTING_GEN
 	select IRQ_FORCED_THREADING
+	select LD_DEAD_CODE_DATA_ELIMINATION
 	select MODULES_USE_ELF_REL
 	select NO_BOOTMEM
 	select OF_EARLY_FLATTREE if OF
@@ -92,6 +93,7 @@ config ARM
 	select PERF_USE_VMALLOC
 	select RTC_LIB
 	select SYS_SUPPORTS_APM_EMULATION
+	select THIN_ARCHIVES
 	# Above selects are sorted alphabetically; please add new ones
 	# according to that.  Thanks.
 	help
diff --git a/arch/arm/kernel/Makefile b/arch/arm/kernel/Makefile
index ad325a8c7e1e..b7f2a41fd940 100644
--- a/arch/arm/kernel/Makefile
+++ b/arch/arm/kernel/Makefile
@@ -13,6 +13,9 @@ endif
 
 CFLAGS_REMOVE_return_address.o = -pg
 
+ccflags-y              += -fno-function-sections -fno-data-sections
+subdir-ccflags-y       += -fno-function-sections -fno-data-sections
+
 # Object file lists.
 
 obj-y		:= elf.o entry-common.o irq.o opcodes.o \
diff --git a/arch/arm/kernel/vmlinux-xip.lds.S b/arch/arm/kernel/vmlinux-xip.lds.S
index 56c8bdf776bd..4b515ae498e2 100644
--- a/arch/arm/kernel/vmlinux-xip.lds.S
+++ b/arch/arm/kernel/vmlinux-xip.lds.S
@@ -12,17 +12,17 @@
 #define PROC_INFO							\
 	. = ALIGN(4);							\
 	VMLINUX_SYMBOL(__proc_info_begin) = .;				\
-	*(.proc.info.init)						\
+	KEEP(*(.proc.info.init))					\
 	VMLINUX_SYMBOL(__proc_info_end) = .;
 
 #define IDMAP_TEXT							\
 	ALIGN_FUNCTION();						\
 	VMLINUX_SYMBOL(__idmap_text_start) = .;				\
-	*(.idmap.text)							\
+	KEEP(*(.idmap.text))						\
 	VMLINUX_SYMBOL(__idmap_text_end) = .;				\
 	. = ALIGN(PAGE_SIZE);						\
 	VMLINUX_SYMBOL(__hyp_idmap_text_start) = .;			\
-	*(.hyp.idmap.text)						\
+	KEEP(*(.hyp.idmap.text))					\
 	VMLINUX_SYMBOL(__hyp_idmap_text_end) = .;
 
 #ifdef CONFIG_HOTPLUG_CPU
@@ -114,7 +114,7 @@ SECTIONS
 	__ex_table : AT(ADDR(__ex_table) - LOAD_OFFSET) {
 		__start___ex_table = .;
 #ifdef CONFIG_MMU
-		*(__ex_table)
+		KEEP(*(__ex_table))
 #endif
 		__stop___ex_table = .;
 	}
@@ -126,12 +126,12 @@ SECTIONS
 	. = ALIGN(8);
 	.ARM.unwind_idx : {
 		__start_unwind_idx = .;
-		*(.ARM.exidx*)
+		KEEP(*(.ARM.exidx*))
 		__stop_unwind_idx = .;
 	}
 	.ARM.unwind_tab : {
 		__start_unwind_tab = .;
-		*(.ARM.extab*)
+		KEEP(*(.ARM.extab*))
 		__stop_unwind_tab = .;
 	}
 #endif
@@ -146,7 +146,7 @@ SECTIONS
 	 */
 	__vectors_start = .;
 	.vectors 0xffff0000 : AT(__vectors_start) {
-		*(.vectors)
+		KEEP(*(.vectors))
 	}
 	. = __vectors_start + SIZEOF(.vectors);
 	__vectors_end = .;
@@ -169,24 +169,24 @@ SECTIONS
 	}
 	.init.arch.info : {
 		__arch_info_begin = .;
-		*(.arch.info.init)
+		KEEP(*(.arch.info.init))
 		__arch_info_end = .;
 	}
 	.init.tagtable : {
 		__tagtable_begin = .;
-		*(.taglist.init)
+		KEEP(*(.taglist.init))
 		__tagtable_end = .;
 	}
 #ifdef CONFIG_SMP_ON_UP
 	.init.smpalt : {
 		__smpalt_begin = .;
-		*(.alt.smp.init)
+		KEEP(*(.alt.smp.init))
 		__smpalt_end = .;
 	}
 #endif
 	.init.pv_table : {
 		__pv_table_begin = .;
-		*(.pv_table)
+		KEEP(*(.pv_table))
 		__pv_table_end = .;
 	}
 	.init.data : {
diff --git a/arch/arm/kernel/vmlinux.lds.S b/arch/arm/kernel/vmlinux.lds.S
index 7396a5f00c5f..abb59e4c12db 100644
--- a/arch/arm/kernel/vmlinux.lds.S
+++ b/arch/arm/kernel/vmlinux.lds.S
@@ -17,7 +17,7 @@
 #define PROC_INFO							\
 	. = ALIGN(4);							\
 	VMLINUX_SYMBOL(__proc_info_begin) = .;				\
-	*(.proc.info.init)						\
+	KEEP(*(.proc.info.init))					\
 	VMLINUX_SYMBOL(__proc_info_end) = .;
 
 #define HYPERVISOR_TEXT							\
@@ -169,7 +169,7 @@ SECTIONS
 	 */
 	__vectors_start = .;
 	.vectors 0xffff0000 : AT(__vectors_start) {
-		*(.vectors)
+		KEEP(*(.vectors))
 	}
 	. = __vectors_start + SIZEOF(.vectors);
 	__vectors_end = .;
@@ -192,24 +192,24 @@ SECTIONS
 	}
 	.init.arch.info : {
 		__arch_info_begin = .;
-		*(.arch.info.init)
+		KEEP(*(.arch.info.init))
 		__arch_info_end = .;
 	}
 	.init.tagtable : {
 		__tagtable_begin = .;
-		*(.taglist.init)
+		KEEP(*(.taglist.init))
 		__tagtable_end = .;
 	}
 #ifdef CONFIG_SMP_ON_UP
 	.init.smpalt : {
 		__smpalt_begin = .;
-		*(.alt.smp.init)
+		KEEP(*(.alt.smp.init))
 		__smpalt_end = .;
 	}
 #endif
 	.init.pv_table : {
 		__pv_table_begin = .;
-		*(.pv_table)
+		KEEP(*(.pv_table))
 		__pv_table_end = .;
 	}
 	.init.data : {
diff --git a/arch/arm/mm/Kconfig b/arch/arm/mm/Kconfig
index 6a09cc204b07..7117b8e99de8 100644
--- a/arch/arm/mm/Kconfig
+++ b/arch/arm/mm/Kconfig
@@ -717,6 +717,7 @@ config SWP_EMULATE
 config CPU_BIG_ENDIAN
 	bool "Build big-endian kernel"
 	depends on ARCH_SUPPORTS_BIG_ENDIAN
+	depends on !THIN_ARCHIVES
 	help
 	  Say Y if you plan on running a kernel in big-endian mode.
 	  Note that your board must be properly built and your board
diff --git a/include/asm-generic/vmlinux.lds.h b/include/asm-generic/vmlinux.lds.h
index 9136c3afd3c6..e01f0b00a678 100644
--- a/include/asm-generic/vmlinux.lds.h
+++ b/include/asm-generic/vmlinux.lds.h
@@ -433,7 +433,9 @@
  * during second ld run in second ld pass when generating System.map */
 #define TEXT_TEXT							\
 		ALIGN_FUNCTION();					\
-		*(.text.hot .text .text.fixup .text.unlikely .text.*)	\
+		*(.text.hot .text.hot.*)				\
+		*(.text.unlikely .text.unlikely.*)			\
+		*(.text .text.*)					\
 		*(.ref.text)						\
 	MEM_KEEP(init.text)						\
 	MEM_KEEP(exit.text)						\
