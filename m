From: Catalin Marinas <catalin.marinas@arm.com>
Subject: Re: [PATCH, REBASED] asm-generic, mm: PTE_SPECIAL cleanup
Date: Fri, 7 Dec 2012 14:30:03 +0000
Message-ID: <20121207143002.GB21233@arm.com>
References: <1354881321-29363-1-git-send-email-kirill.shutemov@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: 8BIT
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from service87.mimecast.com ([91.220.42.44]:44767 "EHLO
	service87.mimecast.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932744Ab2LGOaK convert rfc822-to-8bit (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Fri, 7 Dec 2012 09:30:10 -0500
In-Reply-To: <1354881321-29363-1-git-send-email-kirill.shutemov@linux.intel.com>
Content-Disposition: inline
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, "linux-mm@kvack.org" <linux-mm@kvack.org>, Arnd Bergmann <arnd@arndb.de>, "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>

On Fri, Dec 07, 2012 at 11:55:21AM +0000, Kirill A. Shutemov wrote:
> diff --git a/arch/Kconfig b/arch/Kconfig
> index 6887f57..fc21a52 100644
> --- a/arch/Kconfig
> +++ b/arch/Kconfig
> @@ -364,4 +364,10 @@ config CLONE_BACKWARDS2
>         help
>           Architecture has the first two arguments of clone(2) swapped.
> 
> +config HAVE_PTE_SPECIAL
> +       bool
> +       help
> +         An arch should select this symbol if it provides pte_special() and
> +         mkspecial().
> +
>  source "kernel/gcov/Kconfig"
...
> diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
> index ef90d61..1e2d450 100644
> --- a/arch/arm64/Kconfig
> +++ b/arch/arm64/Kconfig
> @@ -32,7 +32,8 @@ config ARM64
>         select RTC_LIB
>         select SPARSE_IRQ
>         select SYSCTL_EXCEPTION_TRACE
> -       select CLONE_BACKWARDS
> +       select CHAVE_SPARSE_IRQLONE_BACKWARDS
> +       select HAVE_SPARSE_IRQ
>         help
>           ARM 64-bit (AArch64) Linux support.

Something wrong with your diff. Is it rebased on -next? It doesn't seem
to select HAVE_PTE_SPECIAL and it shouldn't remove other stuff.

-- 
Catalin
