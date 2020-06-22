From: Fangrui Song <maskray@google.com>
Subject: Re: [PATCH v2 3/3] x86/boot: Warn on orphan section placement
Date: Mon, 22 Jun 2020 15:06:28 -0700
Message-ID: <20200622220628.t5fklwmbtqoird5f@google.com>
References: <20200622205341.2987797-1-keescook@chromium.org>
 <20200622205341.2987797-4-keescook@chromium.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43692 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730689AbgFVWGd (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 22 Jun 2020 18:06:33 -0400
Received: from mail-pf1-x443.google.com (mail-pf1-x443.google.com [IPv6:2607:f8b0:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 010E0C061573
        for <linux-arch@vger.kernel.org>; Mon, 22 Jun 2020 15:06:33 -0700 (PDT)
Received: by mail-pf1-x443.google.com with SMTP id a127so9028828pfa.12
        for <linux-arch@vger.kernel.org>; Mon, 22 Jun 2020 15:06:32 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20200622205341.2987797-4-keescook@chromium.org>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Kees Cook <keescook@chromium.org>
Cc: Borislav Petkov <bp@suse.de>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, x86@kernel.org, Arnd Bergmann <arnd@arndb.de>, Nick Desaulniers <ndesaulniers@google.com>, Nathan Chancellor <natechancellor@gmail.com>, clang-built-linux@googlegroups.com, linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org

On 2020-06-22, Kees Cook wrote:
>We don't want to depend on the linker's orphan section placement
>heuristics as these can vary between linkers, and may change between
>versions. All sections need to be explicitly named in the linker
>script.
>
>Add the common debugging sections. Discard the unused note, rel, plt,
>dyn, and hash sections that are not needed in the compressed vmlinux.
>Disable .eh_frame generation in the linker and enable orphan section
>warnings.
>
>Signed-off-by: Kees Cook <keescook@chromium.org>
>---
> arch/x86/boot/compressed/Makefile      |  3 ++-
> arch/x86/boot/compressed/vmlinux.lds.S | 11 +++++++++++
> 2 files changed, 13 insertions(+), 1 deletion(-)
>
>diff --git a/arch/x86/boot/compressed/Makefile b/arch/x86/boot/compressed/Makefile
>index 7619742f91c9..646720a05f89 100644
>--- a/arch/x86/boot/compressed/Makefile
>+++ b/arch/x86/boot/compressed/Makefile
>@@ -48,6 +48,7 @@ GCOV_PROFILE := n
> UBSAN_SANITIZE :=n
>
> KBUILD_LDFLAGS := -m elf_$(UTS_MACHINE)
>+KBUILD_LDFLAGS += $(call ld-option,--no-ld-generated-unwind-info)
> # Compressed kernel should be built as PIE since it may be loaded at any
> # address by the bootloader.
> ifeq ($(CONFIG_X86_32),y)
>@@ -59,7 +60,7 @@ else
> KBUILD_LDFLAGS += $(shell $(LD) --help 2>&1 | grep -q "\-z noreloc-overflow" \
> 	&& echo "-z noreloc-overflow -pie --no-dynamic-linker")
> endif
>-LDFLAGS_vmlinux := -T
>+LDFLAGS_vmlinux := --orphan-handling=warn -T
>
> hostprogs	:= mkpiggy
> HOST_EXTRACFLAGS += -I$(srctree)/tools/include
>diff --git a/arch/x86/boot/compressed/vmlinux.lds.S b/arch/x86/boot/compressed/vmlinux.lds.S
>index 8f1025d1f681..6fe3ecdfd685 100644
>--- a/arch/x86/boot/compressed/vmlinux.lds.S
>+++ b/arch/x86/boot/compressed/vmlinux.lds.S
>@@ -75,5 +75,16 @@ SECTIONS
> 	. = ALIGN(PAGE_SIZE);	/* keep ZO size page aligned */
> 	_end = .;
>
>+	STABS_DEBUG
>+	DWARF_DEBUG
>+
> 	DISCARDS
>+	/DISCARD/ : {
>+		*(.note.*)
>+		*(.rela.*) *(.rela_*)
>+		*(.rel.*) *(.rel_*)
>+		*(.plt) *(.plt.*)
>+		*(.dyn*)
>+		*(.hash) *(.gnu.hash)
>+	}
> }
>-- 
>2.25.1

LLD may report warnings for 3 synthetic sections if they are orphans:

ld.lld: warning: <internal>:(.symtab) is being placed in '.symtab'
ld.lld: warning: <internal>:(.shstrtab) is being placed in '.shstrtab'
ld.lld: warning: <internal>:(.strtab) is being placed in '.strtab'

Are they described?
