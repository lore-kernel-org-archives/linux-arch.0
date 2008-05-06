From: Michal Simek <monstr@seznam.cz>
Subject: Re: [PATCH] Microblaze: implement dma-coherent API and refactor cache
 flush code.
Date: Tue, 06 May 2008 11:28:22 +0200
Message-ID: <482024B6.5070704@seznam.cz>
References: <20080505223706.1236C1C8004E@mail131-sin.bigfish.com>
Reply-To: monstr@seznam.cz
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from smtp1.wifiinternet.cz ([89.31.47.1]:64149 "EHLO
	bor.wifiinternet.cz" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1765677AbYEFJ10 (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Tue, 6 May 2008 05:27:26 -0400
In-Reply-To: <20080505223706.1236C1C8004E@mail131-sin.bigfish.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Stephen Neuendorffer <stephen.neuendorffer@xilinx.com>
Cc: arnd@arndb.de, linux-arch@vger.kernel.org, John Linn <linnj@xilinx.com>, john.williams@petalogix.com, matthew@wil.cx, will.newton@gmail.com, drepper@redhat.com, microblaze-uclinux@itee.uq.edu.au, grant.likely@secretlab.ca, linux-kernel@vger.kernel.org

Hi Steve,

>  arch/microblaze/kernel/cpu/cache.c  |   37 +---------
>  arch/microblaze/kernel/setup.c      |    4 +-
>  arch/microblaze/mm/dma-coherent.c   |  122

dma-coherent.c is dead for now.

> diff --git a/arch/microblaze/kernel/setup.c
> b/arch/microblaze/kernel/setup.c
> index 43d53d9..241fb21 100644
> --- a/arch/microblaze/kernel/setup.c
> +++ b/arch/microblaze/kernel/setup.c
> @@ -51,10 +51,10 @@ void __init setup_arch(char **cmdline_p)
>  	/* irq_early_init(); */
>  	setup_cpuinfo();
>  
> -	__flush_icache_all();
> +	__invalidate_icache_all();
>  	__enable_icache();
>  
> -	__flush_dcache_all();
> +	__invalidate_icache_all();
>  	__enable_dcache();

here is bug.

>  	panic_timeout = 120;
> diff --git a/arch/microblaze/mm/dma-coherent.c
> b/arch/microblaze/mm/dma-coherent.c

removed.

M
