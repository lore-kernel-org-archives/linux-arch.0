From: Catalin Marinas <catalin.marinas@arm.com>
Subject: Re: [PATCH, REBASED] asm-generic, mm: PTE_SPECIAL cleanup
Date: Fri, 7 Dec 2012 15:50:18 +0000
Message-ID: <20121207155018.GD21233@arm.com>
References: <1354881321-29363-1-git-send-email-kirill.shutemov@linux.intel.com>
 <20121207143002.GB21233@arm.com>
 <20121207144112.GA17044@otc-wbsnb-06>
Mime-Version: 1.0
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: 8BIT
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from service87.mimecast.com ([91.220.42.44]:48910 "EHLO
	service87.mimecast.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1030409Ab2LGPu2 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Fri, 7 Dec 2012 10:50:28 -0500
In-Reply-To: <20121207144112.GA17044@otc-wbsnb-06>
Content-Disposition: inline
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, "linux-mm@kvack.org" <linux-mm@kvack.org>, Arnd Bergmann <arnd@arndb.de>, "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>

On Fri, Dec 07, 2012 at 02:41:12PM +0000, Kirill A. Shutemov wrote:
> diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
> index ef90d61..2b823e5 100644
> --- a/arch/arm64/Kconfig
> +++ b/arch/arm64/Kconfig
> @@ -33,6 +33,7 @@ config ARM64
>  	select SPARSE_IRQ
>  	select SYSCTL_EXCEPTION_TRACE
>  	select CLONE_BACKWARDS
> +	select HAVE_PTE_SPECIAL
>  	help
>  	  ARM 64-bit (AArch64) Linux support.

Another minor thing, please keep the arm64 Kconfig selects in
alphabetical order. I know Al Viro's patch in -next didn't but I'll push
a patch to correct this.

Otherwise:

Acked-by: Catalin Marinas <catalin.marinas@arm.com>
