Return-Path: <SRS0=Roe3=6Z=vger.kernel.org=linux-arch-owner@kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:50784 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726173AbgEKHvY (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Mon, 11 May 2020 03:51:24 -0400
Date: Mon, 11 May 2020 08:51:15 +0100
From: Will Deacon <will@kernel.org>
Subject: Re: [PATCH 02/31] arm64: fix the flush_icache_range arguments in
 machine_kexec
Message-ID: <20200511075115.GA16134@willie-the-truck>
References: <20200510075510.987823-1-hch@lst.de>
 <20200510075510.987823-3-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200510075510.987823-3-hch@lst.de>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Christoph Hellwig <hch@lst.de>, james.morse@arm.com, catalin.marinas@arm.com
Cc: Andrew Morton <akpm@linux-foundation.org>, Arnd Bergmann <arnd@arndb.de>, Roman Zippel <zippel@linux-m68k.org>, Jessica Yu <jeyu@kernel.org>, Michal Simek <monstr@monstr.eu>, x86@kernel.org, linux-alpha@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-c6x-dev@linux-c6x.org, linux-hexagon@vger.kernel.org, linux-ia64@vger.kernel.org, linux-m68k@lists.linux-m68k.org, linux-mips@vger.kernel.org, openrisc@lists.librecores.org, linuxppc-dev@lists.ozlabs.org, linux-riscv@lists.infradead.org, linux-sh@vger.kernel.org, sparclinux@vger.kernel.org, linux-arch@vger.kernel.org, linux-mm@kvack.org, linux-um@lists.infradead.org, linux-xtensa@linux-xtensa.org, linux-fsdevel@vger.kernel.org
Message-ID: <20200511075115.xLeZwMwAM-OtG8FZ_JeluIGYmnqyP0FASdQCsYId9qo@z>

[+James and Catalin]

On Sun, May 10, 2020 at 09:54:41AM +0200, Christoph Hellwig wrote:
> The second argument is the end "pointer", not the length.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>  arch/arm64/kernel/machine_kexec.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/arch/arm64/kernel/machine_kexec.c b/arch/arm64/kernel/machine_kexec.c
> index 8e9c924423b4e..a0b144cfaea71 100644
> --- a/arch/arm64/kernel/machine_kexec.c
> +++ b/arch/arm64/kernel/machine_kexec.c
> @@ -177,6 +177,7 @@ void machine_kexec(struct kimage *kimage)
>  	 * the offline CPUs. Therefore, we must use the __* variant here.
>  	 */
>  	__flush_icache_range((uintptr_t)reboot_code_buffer,
> +			     (uintptr_t)reboot_code_buffer +
>  			     arm64_relocate_new_kernel_size);

Urgh, well spotted. It's annoyingly different from __flush_dcache_area().

But now I'm wondering what this code actually does... the loop condition
in invalidate_icache_by_line works with 64-bit arithmetic, so we could
spend a /very/ long time here afaict. It's also a bit annoying that we
do a bunch of redundant D-cache maintenance too.

Should we use invalidate_icache_range() here instead? (and why does that
thing need to toggle uaccess)? Argh, too many questions!

Will
