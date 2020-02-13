From: Nathan Chancellor <natechancellor@gmail.com>
Subject: Re: [PATCH 19/19] arm64: vdso32: Enable Clang Compilation
Date: Thu, 13 Feb 2020 11:44:54 -0700
Message-ID: <20200213184454.GA4663@ubuntu-m2-xlarge-x86>
References: <20200213161614.23246-1-vincenzo.frascino@arm.com>
 <20200213161614.23246-20-vincenzo.frascino@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mail-oi1-f193.google.com ([209.85.167.193]:39409 "EHLO
        mail-oi1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725781AbgBMSo6 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 13 Feb 2020 13:44:58 -0500
Content-Disposition: inline
In-Reply-To: <20200213161614.23246-20-vincenzo.frascino@arm.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Vincenzo Frascino <vincenzo.frascino@arm.com>
Cc: linux-arch@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, linux-mips@vger.kernel.org, clang-built-linux@googlegroups.com, x86@kernel.org, catalin.marinas@arm.com, will.deacon@arm.com, arnd@arndb.de, linux@armlinux.org.uk, paul.burton@mips.com, tglx@linutronix.de, luto@kernel.org, mingo@redhat.com, bp@alien8.de, sboyd@kernel.org, salyzyn@android.com, pcc@google.com, 0x7f454c46@gmail.com, ndesaulniers@google.com, avagin@openvz.org

On Thu, Feb 13, 2020 at 04:16:14PM +0000, Vincenzo Frascino wrote:
> Enable Clang Compilation for the vdso32 library.
> 
> Cc: Catalin Marinas <catalin.marinas@arm.com>
> Cc: Will Deacon <will@kernel.org>
> Signed-off-by: Vincenzo Frascino <vincenzo.frascino@arm.com>
> ---
>  arch/arm64/kernel/vdso32/Makefile | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/arm64/kernel/vdso32/Makefile b/arch/arm64/kernel/vdso32/Makefile
> index 04df57b43cb1..209639101044 100644
> --- a/arch/arm64/kernel/vdso32/Makefile
> +++ b/arch/arm64/kernel/vdso32/Makefile
> @@ -11,8 +11,10 @@ include $(srctree)/lib/vdso/Makefile
>  # Same as cc-*option, but using CC_COMPAT instead of CC
>  ifeq ($(CONFIG_CC_IS_CLANG), y)
>  CC_COMPAT ?= $(CC)
> +LD_COMPAT ?= $(CROSS_COMPILE_COMPAT)gcc

Well this is unfortunate :/

It looks like adding the --target flag to VDSO_LDFLAGS allows
clang to link the vDSO just fine although it does warn that -nostdinc
is unused:

clang-11: warning: argument unused during compilation: '-nostdinc'
[-Wunused-command-line-argument]

It would be nice if the logic of commit fe00e50b2db8 ("ARM: 8858/1:
vdso: use $(LD) instead of $(CC) to link VDSO") could be adopted here
but I get that this Makefile is its own beast :) at the very least, I
think that the --target flag should be added to VDSO_LDFLAGS so that gcc
is not a requirement for this but I am curious if you tried that already
and noticed any issues with it.

Cheers,
Nathan

>  else
>  CC_COMPAT ?= $(CROSS_COMPILE_COMPAT)gcc
> +LD_COMPAT ?= $(CC_COMPAT)
>  endif
>  
>  cc32-option = $(call try-run,\
> @@ -171,7 +173,7 @@ quiet_cmd_vdsold_and_vdso_check = LD32    $@
>        cmd_vdsold_and_vdso_check = $(cmd_vdsold); $(cmd_vdso_check)
>  
>  quiet_cmd_vdsold = LD32    $@
> -      cmd_vdsold = $(CC_COMPAT) -Wp,-MD,$(depfile) $(VDSO_LDFLAGS) \
> +      cmd_vdsold = $(LD_COMPAT) -Wp,-MD,$(depfile) $(VDSO_LDFLAGS) \
>                     -Wl,-T $(filter %.lds,$^) $(filter %.o,$^) -o $@
>  quiet_cmd_vdsocc = CC32    $@
>        cmd_vdsocc = $(CC_COMPAT) -Wp,-MD,$(depfile) $(VDSO_CFLAGS) -c -o $@ $<
> -- 
> 2.25.0
> 
