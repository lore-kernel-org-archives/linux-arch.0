Return-Path: <SRS0=MbEv=AF=vger.kernel.org=linux-arch-owner@kernel.org>
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58076 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389773AbgFXVVR (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 24 Jun 2020 17:21:17 -0400
Date: Wed, 24 Jun 2020 23:20:55 +0200
From: Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH 06/22] kbuild: lto: limit inlining
Message-ID: <20200624212055.GU4817@hirez.programming.kicks-ass.net>
References: <20200624203200.78870-1-samitolvanen@google.com>
 <20200624203200.78870-7-samitolvanen@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200624203200.78870-7-samitolvanen@google.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Sami Tolvanen <samitolvanen@google.com>
Cc: Masahiro Yamada <masahiroy@kernel.org>, Will Deacon <will@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "Paul E. McKenney" <paulmck@kernel.org>, Kees Cook <keescook@chromium.org>, Nick Desaulniers <ndesaulniers@google.com>, clang-built-linux@googlegroups.com, kernel-hardening@lists.openwall.com, linux-arch@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org, x86@kernel.org, George Burgess IV <gbiv@google.com>
Message-ID: <20200624212055.ZERTu6IQ4x-0ZQ1CDTGAhOdl8NZoLeXCo2Unu7o14qs@z>

On Wed, Jun 24, 2020 at 01:31:44PM -0700, Sami Tolvanen wrote:
> This change limits function inlining across translation unit
> boundaries in order to reduce the binary size with LTO.
> 
> The -import-instr-limit flag defines a size limit, as the number
> of LLVM IR instructions, for importing functions from other TUs.
> The default value is 100, and decreasing it to 5 reduces the size
> of a stripped arm64 defconfig vmlinux by 11%.

Is that also the right number for x86? What about the effect on
performance? What did 6 do? or 4?

> Suggested-by: George Burgess IV <gbiv@google.com>
> Signed-off-by: Sami Tolvanen <samitolvanen@google.com>
> ---
>  Makefile | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/Makefile b/Makefile
> index 3a7e5e5c17b9..ee66513a5b66 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -894,6 +894,10 @@ else
>  CC_FLAGS_LTO_CLANG := -flto
>  endif
>  CC_FLAGS_LTO_CLANG += -fvisibility=default
> +
> +# Limit inlining across translation units to reduce binary size
> +LD_FLAGS_LTO_CLANG := -mllvm -import-instr-limit=5
> +KBUILD_LDFLAGS += $(LD_FLAGS_LTO_CLANG)
>  endif
>  
>  ifdef CONFIG_LTO
> -- 
> 2.27.0.212.ge8ba1cc988-goog
> 
