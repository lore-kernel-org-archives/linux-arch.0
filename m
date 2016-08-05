Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail-pa0-f68.google.com ([209.85.220.68]:33353 "EHLO
	mail-pa0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753746AbcHENsZ (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Fri, 5 Aug 2016 09:48:25 -0400
Date: Fri, 5 Aug 2016 23:32:52 +1000
From: Nicholas Piggin <npiggin@gmail.com>
Subject: Re: [RFC][PATCH 0/5] kbuild changes, thin archives, --gc-sections
Message-ID: <20160805233252.50cb8cce@roar.ozlabs.ibm.com>
In-Reply-To: <1470399123-8455-1-git-send-email-npiggin@gmail.com>
References: <1470399123-8455-1-git-send-email-npiggin@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: linux-kbuild@vger.kernel.org
Cc: linux-arch@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, Stephen Rothwell <sfr@canb.auug.org.au>, Arnd Bergmann <arnd@arndb.de>, Nicolas Pitre <nico@linaro.org>, Segher Boessenkool <segher@kernel.crashing.org>, Alan Modra <amodra@gmail.com>
Message-ID: <20160805133252.yFSFtRf6c3J0MV0p5hNXobr7pjTfcvw6IUDLA_cIfko@z>

On Fri,  5 Aug 2016 22:11:58 +1000
Nicholas Piggin <npiggin@gmail.com> wrote:

> Hello,
> 
> I have 3 different things in this patchset. All arch specific, but all
> involve kbuild changes, so I'd like to discuss them with kbuild
> maintainers. The goal has been to improve long standing linking
> difficulties with the powerpc kernel.

Here's a 30 second hack of an x86 patch. It seems to build and
boot defconfig in a really quick kvm test.

For x86-64 machine building x86 target, defconfig,

make -j8 vmlinux time:
              orig      thinarc   thinarc+dce
real     4m58.865s    4m59.747s     5m20.028s
user    15m14.428s   15m13.868s    15m17.012s
sys      0m57.296s    0m55.904s     0m58.416s

build output directory size:
              orig      thinarc   thinarc+dce
              317M         257M          285M

vmlinux size:
    text     data      bss       dec   filename
10192338  4360136  1105920  15658394   vmlinux
10186739  4356040  1105920  15648699   vmlinux.thinarc
 9580486  3759880  1011712  14352078   vmlinux.thinarc+dce

Thanks,
Nick


diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
index 0a7b885..845069e 100644
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -51,6 +51,8 @@ config X86
 	select ARCH_WANT_IPC_PARSE_VERSION	if X86_32
 	select ARCH_WANT_OPTIONAL_GPIOLIB
 	select BUILDTIME_EXTABLE_SORT
+	select THIN_ARCHIVES
+	select LINKER_DCE
 	select CLKEVT_I8253
 	select CLKSRC_I8253			if X86_32
 	select CLOCKSOURCE_VALIDATE_LAST_CYCLE
diff --git a/arch/x86/kernel/vmlinux.lds.S b/arch/x86/kernel/vmlinux.lds.S
index 9297a00..7395dd8 100644
--- a/arch/x86/kernel/vmlinux.lds.S
+++ b/arch/x86/kernel/vmlinux.lds.S
@@ -92,7 +92,7 @@ SECTIONS
 	.text :  AT(ADDR(.text) - LOAD_OFFSET) {
 		_text = .;
 		/* bootstrapping code */
-		HEAD_TEXT
+		KEEP(HEAD_TEXT)
 		. = ALIGN(8);
 		_stext = .;
 		TEXT_TEXT
@@ -321,7 +321,7 @@ SECTIONS
 	.bss : AT(ADDR(.bss) - LOAD_OFFSET) {
 		__bss_start = .;
 		*(.bss..page_aligned)
-		*(.bss)
+		*(.bss .bss.*)
 		. = ALIGN(PAGE_SIZE);
 		__bss_stop = .;
 	}
