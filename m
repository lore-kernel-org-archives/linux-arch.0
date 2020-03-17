Return-Path: <SRS0=zClU=5C=vger.kernel.org=linux-arch-owner@kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:57516 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726476AbgCQVxF (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Tue, 17 Mar 2020 17:53:05 -0400
Date: Tue, 17 Mar 2020 21:52:57 +0000
From: Will Deacon <will@kernel.org>
Subject: Re: [PATCH 6/9] arm64/build: Use common DISCARDS in linker script
Message-ID: <20200317215256.GA20788@willie-the-truck>
References: <20200228002244.15240-1-keescook@chromium.org>
 <20200228002244.15240-7-keescook@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200228002244.15240-7-keescook@chromium.org>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Kees Cook <keescook@chromium.org>
Cc: Borislav Petkov <bp@suse.de>, "H.J. Lu" <hjl.tools@gmail.com>, Russell King <linux@armlinux.org.uk>, Catalin Marinas <catalin.marinas@arm.com>, Mark Rutland <mark.rutland@arm.com>, Peter Collingbourne <pcc@google.com>, James Morse <james.morse@arm.com>, Arnd Bergmann <arnd@arndb.de>, Masahiro Yamada <masahiroy@kernel.org>, x86@kernel.org, linux-arm-kernel@lists.infradead.org, linux-arch@vger.kernel.org, linux-kbuild@vger.kernel.org, clang-built-linux@googlegroups.com, linux-kernel@vger.kernel.org
Message-ID: <20200317215257.7sbS50Q0mydB0Ixhn6mylJhuByWAcPbOLcujDTuPc1M@z>

On Thu, Feb 27, 2020 at 04:22:41PM -0800, Kees Cook wrote:
> Use the common DISCARDS rule for the linker script in an effort to
> regularize the linker script to prepare for warning on orphaned
> sections.
> 
> Signed-off-by: Kees Cook <keescook@chromium.org>
> ---
>  arch/arm64/kernel/vmlinux.lds.S | 8 ++------
>  1 file changed, 2 insertions(+), 6 deletions(-)
> 
> diff --git a/arch/arm64/kernel/vmlinux.lds.S b/arch/arm64/kernel/vmlinux.lds.S
> index 497f9675071d..c61d9ab3211c 100644
> --- a/arch/arm64/kernel/vmlinux.lds.S
> +++ b/arch/arm64/kernel/vmlinux.lds.S
> @@ -6,6 +6,7 @@
>   */
>  
>  #define RO_EXCEPTION_TABLE_ALIGN	8
> +#define RUNTIME_DISCARD_EXIT
>  
>  #include <asm-generic/vmlinux.lds.h>
>  #include <asm/cache.h>
> @@ -19,7 +20,6 @@
>  
>  /* .exit.text needed in case of alternative patching */
>  #define ARM_EXIT_KEEP(x)	x
> -#define ARM_EXIT_DISCARD(x)
>  
>  OUTPUT_ARCH(aarch64)
>  ENTRY(_text)
> @@ -94,12 +94,8 @@ SECTIONS
>  	 * matching the same input section name.  There is no documented
>  	 * order of matching.
>  	 */
> +	DISCARDS
>  	/DISCARD/ : {
> -		ARM_EXIT_DISCARD(EXIT_TEXT)
> -		ARM_EXIT_DISCARD(EXIT_DATA)
> -		EXIT_CALL
> -		*(.discard)
> -		*(.discard.*)
>  		*(.interp .dynamic)
>  		*(.dynsym .dynstr .hash .gnu.hash)
>  		*(.eh_frame)

Acked-by: Will Deacon <will@kernel.org>

Will
