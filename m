From: Nathan Chancellor <natechancellor@gmail.com>
Subject: Re: [PATCH v2 20/20] arm64: vdso32: Enable Clang Compilation
Date: Mon, 9 Mar 2020 18:40:39 -0700
Message-ID: <20200310014039.GA12211@ubuntu-m2-xlarge-x86>
References: <20200306133242.26279-1-vincenzo.frascino@arm.com>
 <20200306133242.26279-21-vincenzo.frascino@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-mips-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20200306133242.26279-21-vincenzo.frascino@arm.com>
Sender: linux-mips-owner@vger.kernel.org
To: Vincenzo Frascino <vincenzo.frascino@arm.com>
Cc: linux-arch@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, linux-mips@vger.kernel.org, clang-built-linux@googlegroups.com, x86@kernel.org, Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will.deacon@arm.com>, Arnd Bergmann <arnd@arndb.de>, Russell King <linux@armlinux.org.uk>, Paul Burton <paul.burton@mips.com>, Thomas Gleixner <tglx@linutronix.de>, Andy Lutomirski <luto@kernel.org>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, Stephen Boyd <sboyd@kernel.org>, Mark Salyzyn <salyzyn@android.com>, Kees Cook <keescook@chromium.org>, Peter Collingbourne <pcc@google.com>, Dmitry Safonov <0x7f454c46@gmail.com>, Andrei Vagin <avagin@openvz.org>, Nick Desaulniers <ndesaulniers@google.com>
List-Id: linux-arch.vger.kernel.org

On Fri, Mar 06, 2020 at 01:32:42PM +0000, Vincenzo Frascino wrote:
> Enable Clang Compilation for the vdso32 library.
> 
> Cc: Catalin Marinas <catalin.marinas@arm.com>
> Cc: Will Deacon <will@kernel.org>
> Signed-off-by: Vincenzo Frascino <vincenzo.frascino@arm.com>
> ---
>  arch/arm64/kernel/vdso32/Makefile | 13 ++++++++++++-
>  1 file changed, 12 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/arm64/kernel/vdso32/Makefile b/arch/arm64/kernel/vdso32/Makefile
> index 04df57b43cb1..650cfc5757eb 100644
> --- a/arch/arm64/kernel/vdso32/Makefile
> +++ b/arch/arm64/kernel/vdso32/Makefile
> @@ -10,7 +10,18 @@ include $(srctree)/lib/vdso/Makefile
>  
>  # Same as cc-*option, but using CC_COMPAT instead of CC
>  ifeq ($(CONFIG_CC_IS_CLANG), y)
> -CC_COMPAT ?= $(CC)
> +COMPAT_GCC_TOOLCHAIN_DIR := $(dir $(shell which $(CROSS_COMPILE_COMPAT)elfedit))
> +COMPAT_GCC_TOOLCHAIN := $(realpath $(COMPAT_GCC_TOOLCHAIN_DIR)/..)
> +
> +CLANG_CC_COMPAT := $(CC)
> +CLANG_CC_COMPAT += --target=$(notdir $(CROSS_COMPILE_COMPAT:%-=%))
> +CLANG_CC_COMPAT += --prefix=$(COMPAT_GCC_TOOLCHAIN_DIR)
> +CLANG_CC_COMPAT += -no-integrated-as -Qunused-arguments
> +ifneq ($(COMPAT_GCC_TOOLCHAIN),)
> +CLANG_CC_COMPAT += --gcc-toolchain=$(COMPAT_GCC_TOOLCHAIN)
> +endif
> +
> +CC_COMPAT ?= $(CLANG_CC_COMPAT)
>  else
>  CC_COMPAT ?= $(CROSS_COMPILE_COMPAT)gcc
>  endif
> -- 
> 2.25.1
> 
If CC_COMPAT is ever specified on the command line as clang (maybe by
some unsuspecting user), we'd loose all of the above flags. Maybe it
would be better to build a set of COMPAT_CLANG_FLAGS and append them to
CC_COMPAT, maybe like below?

Regardless, the current approach works in my testing with clang 9.0.1
and master (clang 11.0.0). This patch specifically is:

Reviewed-by: Nathan Chancellor <natechancellor@gmail.com>
Tested-by: Nathan Chancellor <natechancellor@gmail.com> # build

==================================================================================

diff --git a/arch/arm64/kernel/vdso32/Makefile b/arch/arm64/kernel/vdso32/Makefile
index 650cfc5757eb..df5145fab287 100644
--- a/arch/arm64/kernel/vdso32/Makefile
+++ b/arch/arm64/kernel/vdso32/Makefile
@@ -13,15 +13,16 @@ ifeq ($(CONFIG_CC_IS_CLANG), y)
 COMPAT_GCC_TOOLCHAIN_DIR := $(dir $(shell which $(CROSS_COMPILE_COMPAT)elfedit))
 COMPAT_GCC_TOOLCHAIN := $(realpath $(COMPAT_GCC_TOOLCHAIN_DIR)/..)
 
-CLANG_CC_COMPAT := $(CC)
-CLANG_CC_COMPAT += --target=$(notdir $(CROSS_COMPILE_COMPAT:%-=%))
-CLANG_CC_COMPAT += --prefix=$(COMPAT_GCC_TOOLCHAIN_DIR)
-CLANG_CC_COMPAT += -no-integrated-as -Qunused-arguments
+COMPAT_CLANG_FLAGS := --target=$(notdir $(CROSS_COMPILE_COMPAT:%-=%))
+COMPAT_CLANG_FLAGS += --prefix=$(COMPAT_GCC_TOOLCHAIN_DIR)
+COMPAT_CLANG_FLAGS += -no-integrated-as -Qunused-arguments
 ifneq ($(COMPAT_GCC_TOOLCHAIN),)
-CLANG_CC_COMPAT += --gcc-toolchain=$(COMPAT_GCC_TOOLCHAIN)
+COMPAT_CLANG_FLAGS += --gcc-toolchain=$(COMPAT_GCC_TOOLCHAIN)
 endif
 
-CC_COMPAT ?= $(CLANG_CC_COMPAT)
+CC_COMPAT ?= $(CC)
+CC_COMPAT += $(COMPAT_CLANG_FLAGS)
+
 else
 CC_COMPAT ?= $(CROSS_COMPILE_COMPAT)gcc
 endif
