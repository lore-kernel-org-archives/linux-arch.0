From: Russell King <rmk+lkml@arm.linux.org.uk>
Subject: Re: [PATCH] Drop superfluous casts in nr_free_pages() callers
Date: Mon, 3 Aug 2009 18:24:59 +0100
Message-ID: <20090803172459.GC32479@flint.arm.linux.org.uk>
References: <alpine.LRH.2.00.0908031808440.11620@vixen.sonytel.be>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from caramon.arm.linux.org.uk ([78.32.30.218]:44369 "EHLO
	caramon.arm.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751992AbZHCRZS (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Mon, 3 Aug 2009 13:25:18 -0400
Content-Disposition: inline
In-Reply-To: <alpine.LRH.2.00.0908031808440.11620@vixen.sonytel.be>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Geert Uytterhoeven <Geert.Uytterhoeven@sonycom.com>
Cc: Christoph Lameter <cl@linux-foundation.org>, Andrew Morton <akpm@linux-foundation.org>, linux-arch@vger.kernel.org, Linux Kernel Development <linux-kernel@vger.kernel.org>

On Mon, Aug 03, 2009 at 06:11:42PM +0200, Geert Uytterhoeven wrote:
> diff --git a/arch/arm/mm/init.c b/arch/arm/mm/init.c
> index 8277802..bc927ee 100644
> --- a/arch/arm/mm/init.c
> +++ b/arch/arm/mm/init.c
> @@ -536,8 +536,8 @@ void __init mem_init(void)
>  
>  	printk(KERN_NOTICE "Memory: %luKB available (%dK code, "
>  		"%dK data, %dK init, %luK highmem)\n",
> -		(unsigned long) nr_free_pages() << (PAGE_SHIFT-10),
> -		codesize >> 10, datasize >> 10, initsize >> 10,
> +		nr_free_pages() << (PAGE_SHIFT-10), codesize >> 10,
> +		datasize >> 10, initsize >> 10,
>  		(unsigned long) (totalhigh_pages << (PAGE_SHIFT-10)));
>  
>  	if (PAGE_SIZE >= 16384 && num_physpages <= 128) {

Acked-by: Russell King <rmk+kernel@arm.linux.org.uk>

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:
