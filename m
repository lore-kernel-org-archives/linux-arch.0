Return-Path: <SRS0=AQMQ=AK=vger.kernel.org=linux-arch-owner@kernel.org>
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46780 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1733227AbgF2Tco (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 29 Jun 2020 15:32:44 -0400
From: Arvind Sankar <nivedita@alum.mit.edu>
Date: Mon, 29 Jun 2020 11:54:01 -0400
Subject: Re: [PATCH v4 14/17] arm/build: Warn on orphan section placement
Message-ID: <20200629155401.GB900899@rani.riverdale.lan>
References: <20200629061840.4065483-1-keescook@chromium.org>
 <20200629061840.4065483-15-keescook@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200629061840.4065483-15-keescook@chromium.org>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Kees Cook <keescook@chromium.org>
Cc: Will Deacon <will@kernel.org>, Catalin Marinas <catalin.marinas@arm.com>, Mark Rutland <mark.rutland@arm.com>, Ard Biesheuvel <ardb@kernel.org>, Peter Collingbourne <pcc@google.com>, James Morse <james.morse@arm.com>, Borislav Petkov <bp@suse.de>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Russell King <linux@armlinux.org.uk>, Masahiro Yamada <masahiroy@kernel.org>, Arvind Sankar <nivedita@alum.mit.edu>, Nick Desaulniers <ndesaulniers@google.com>, Nathan Chancellor <natechancellor@gmail.com>, Arnd Bergmann <arnd@arndb.de>, x86@kernel.org, clang-built-linux@googlegroups.com, linux-arch@vger.kernel.org, linux-efi@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Message-ID: <20200629155401.AnQTIBapXa47hivejIG72dC3ToWFtIsDUJHm92srGkc@z>

On Sun, Jun 28, 2020 at 11:18:37PM -0700, Kees Cook wrote:
> We don't want to depend on the linker's orphan section placement
> heuristics as these can vary between linkers, and may change between
> versions. All sections need to be explicitly named in the linker
> script.
> 
> Specifically, this would have made a recently fixed bug very obvious:
> 
> ld: warning: orphan section `.fixup' from `arch/arm/lib/copy_from_user.o' being placed in section `.fixup'
> 
> Discard unneeded sections .iplt, .rel.iplt, .igot.plt, and .modinfo.
> 
> Add missing text stub sections .vfp11_veneer and .v4_bx.
> 
> Add debug sections explicitly.
> 
> Finally enable orphan section warning.

This is unrelated to this patch as such, but I noticed that ARM32/64 places
the .got section inside .text -- is that expected on ARM?
