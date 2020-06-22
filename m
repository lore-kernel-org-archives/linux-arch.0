Return-Path: <SRS0=TrJs=AD=vger.kernel.org=linux-arch-owner@kernel.org>
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47020 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731098AbgFVW1u (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 22 Jun 2020 18:27:50 -0400
Received: from mail-pf1-x444.google.com (mail-pf1-x444.google.com [IPv6:2607:f8b0:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C145C061795
        for <linux-arch@vger.kernel.org>; Mon, 22 Jun 2020 15:27:50 -0700 (PDT)
Received: by mail-pf1-x444.google.com with SMTP id x22so9077073pfn.3
        for <linux-arch@vger.kernel.org>; Mon, 22 Jun 2020 15:27:50 -0700 (PDT)
Date: Mon, 22 Jun 2020 15:27:47 -0700
From: Kees Cook <keescook@chromium.org>
Subject: Re: [PATCH v2 1/3] vmlinux.lds.h: Add .gnu.version* to DISCARDS
Message-ID: <202006221524.CEB86E036B@keescook>
References: <20200622205341.2987797-1-keescook@chromium.org>
 <20200622205341.2987797-2-keescook@chromium.org>
 <20200622220043.6j3vl6v7udmk2ppp@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200622220043.6j3vl6v7udmk2ppp@google.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Fangrui Song <maskray@google.com>
Cc: Borislav Petkov <bp@suse.de>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, x86@kernel.org, Arnd Bergmann <arnd@arndb.de>, Nick Desaulniers <ndesaulniers@google.com>, Nathan Chancellor <natechancellor@gmail.com>, clang-built-linux@googlegroups.com, linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org
Message-ID: <20200622222747.ODvzgfRbaN_ywnyA2G8q-5a-kEfUkrQyA9IlYZqzaes@z>

On Mon, Jun 22, 2020 at 03:00:43PM -0700, Fangrui Song wrote:
> On 2020-06-22, Kees Cook wrote:
> > For vmlinux linking, no architecture uses the .gnu.version* section,
> > so remove it via the common DISCARDS macro in preparation for adding
> > --orphan-handling=warn more widely.
> > 
> > Signed-off-by: Kees Cook <keescook@chromium.org>
> > ---
> > include/asm-generic/vmlinux.lds.h | 1 +
> > 1 file changed, 1 insertion(+)
> > 
> > diff --git a/include/asm-generic/vmlinux.lds.h b/include/asm-generic/vmlinux.lds.h
> > index db600ef218d7..6fbe9ed10cdb 100644
> > --- a/include/asm-generic/vmlinux.lds.h
> > +++ b/include/asm-generic/vmlinux.lds.h
> > @@ -934,6 +934,7 @@
> > 	*(.discard)							\
> > 	*(.discard.*)							\
> > 	*(.modinfo)							\
> > +	*(.gnu.version*)						\
> > 	}
> > 
> > /**
> > -- 
> > 2.25.1
> 
> I wonder what lead to .gnu.version{,_d,_r} sections in the kernel.

This looks like a bug in bfd.ld? There are no versioned symbols in any
of the input files (and no output section either!)

The link command is:
$ ld -m elf_x86_64 --no-ld-generated-unwind-info -z noreloc-overflow -pie \
--no-dynamic-linker   --orphan-handling=warn -T \
arch/x86/boot/compressed/vmlinux.lds \
arch/x86/boot/compressed/kernel_info.o \
arch/x86/boot/compressed/head_64.o arch/x86/boot/compressed/misc.o \
arch/x86/boot/compressed/string.o arch/x86/boot/compressed/cmdline.o \
arch/x86/boot/compressed/error.o arch/x86/boot/compressed/piggy.o \
arch/x86/boot/compressed/cpuflags.o \
arch/x86/boot/compressed/early_serial_console.o \
arch/x86/boot/compressed/kaslr.o arch/x86/boot/compressed/kaslr_64.o \
arch/x86/boot/compressed/mem_encrypt.o \
arch/x86/boot/compressed/pgtable_64.o arch/x86/boot/compressed/acpi.o \
-o arch/x86/boot/compressed/vmlinux

None of the inputs have the section:

$ for i in arch/x86/boot/compressed/kernel_info.o \
arch/x86/boot/compressed/head_64.o arch/x86/boot/compressed/misc.o \
arch/x86/boot/compressed/string.o arch/x86/boot/compressed/cmdline.o \
arch/x86/boot/compressed/error.o arch/x86/boot/compressed/piggy.o \
arch/x86/boot/compressed/cpuflags.o \
arch/x86/boot/compressed/early_serial_console.o \
arch/x86/boot/compressed/kaslr.o arch/x86/boot/compressed/kaslr_64.o \
arch/x86/boot/compressed/mem_encrypt.o \
arch/x86/boot/compressed/pgtable_64.o arch/x86/boot/compressed/acpi.o \
; do echo -n $i": "; readelf -Vs $i | grep 'version'; done
arch/x86/boot/compressed/kernel_info.o: No version information found in this file.
arch/x86/boot/compressed/head_64.o: No version information found in this file.
arch/x86/boot/compressed/misc.o: No version information found in this file.
arch/x86/boot/compressed/string.o: No version information found in this file.
arch/x86/boot/compressed/cmdline.o: No version information found in this file.
arch/x86/boot/compressed/error.o: No version information found in this file.
arch/x86/boot/compressed/piggy.o: No version information found in this file.
arch/x86/boot/compressed/cpuflags.o: No version information found in this file.
arch/x86/boot/compressed/early_serial_console.o: No version information found in this file.
arch/x86/boot/compressed/kaslr.o: No version information found in this file.
arch/x86/boot/compressed/kaslr_64.o: No version information found in this file.
arch/x86/boot/compressed/mem_encrypt.o: No version information found in this file.
arch/x86/boot/compressed/pgtable_64.o: No version information found in this file.
arch/x86/boot/compressed/acpi.o: No version information found in this file.

And it's not in the output:

$ readelf -Vs arch/x86/boot/compressed/vmlinux | grep version
No version information found in this file.

So... for the kernel we need to silence it right now.

-- 
Kees Cook
