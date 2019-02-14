Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail-pf1-f194.google.com ([209.85.210.194]:34420 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2503210AbfBNUts (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 14 Feb 2019 15:49:48 -0500
Received: by mail-pf1-f194.google.com with SMTP id j18so3694114pfe.1
        for <linux-arch@vger.kernel.org>; Thu, 14 Feb 2019 12:49:47 -0800 (PST)
Date: Thu, 14 Feb 2019 12:49:45 -0800 (PST)
Subject: Re: [PATCH 4/4] riscv: switch over to generic free_initmem()
In-Reply-To: <1550159977-8949-5-git-send-email-rppt@linux.ibm.com>
From: Palmer Dabbelt <palmer@sifive.com>
Message-ID: <mhng-e6dedfc5-937e-42e5-90d6-4ce400cbc6fb@palmer-si-x1c4>
Mime-Version: 1.0 (MHng)
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
Cc: akpm@linux-foundation.org, Christoph Hellwig <hch@lst.de>, rkuo@codeaurora.org, linux-arch@vger.kernel.org, linux-hexagon@vger.kernel.org, linux-kernel@vger.kernel.org, linux-mm@kvack.org, linux-riscv@lists.infradead.org, rppt@linux.ibm.com
Message-ID: <20190214204945.9sQOyZA4NRE-FyRJ6M9qVOpeb_VUdGDafszzPGmgrbM@z>

On Thu, 14 Feb 2019 07:59:37 PST (-0800), rppt@linux.ibm.com wrote:
> The riscv version of free_initmem() differs from the generic one only in
> that it sets the freed memory to zero.
>
> Make ricsv use the generic version and poison the freed memory.
>
> Signed-off-by: Mike Rapoport <rppt@linux.ibm.com>
> ---
>  arch/riscv/mm/init.c | 5 -----
>  1 file changed, 5 deletions(-)
>
> diff --git a/arch/riscv/mm/init.c b/arch/riscv/mm/init.c
> index 658ebf6..2af0010 100644
> --- a/arch/riscv/mm/init.c
> +++ b/arch/riscv/mm/init.c
> @@ -60,11 +60,6 @@ void __init mem_init(void)
>  	mem_init_print_info(NULL);
>  }
>
> -void free_initmem(void)
> -{
> -	free_initmem_default(0);
> -}
> -
>  #ifdef CONFIG_BLK_DEV_INITRD
>  void free_initrd_mem(unsigned long start, unsigned long end)
>  {

Reviewed-by: Palmer Dabbelt <palmer@sifive.com>

I'm going to assume this goes in with the rest of the patch set, thanks!
