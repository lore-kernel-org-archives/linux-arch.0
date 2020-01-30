From: Palmer Dabbelt <palmerdabbelt@google.com>
Subject: Re: [PATCH] riscv: Use flush_icache_mm for flush_icache_user_range
Date: Thu, 30 Jan 2020 09:40:51 -0800 (PST)
Message-ID: <mhng-19381e7d-faca-4e0d-87e6-29d43d7796e0@palmerdabbelt-glaptop1>
References: <20200124161810.24322-1-guoren@linux.alibaba.com>
Mime-Version: 1.0 (MHng)
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mail-wr1-f65.google.com ([209.85.221.65]:46046 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727346AbgA3Rky (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 30 Jan 2020 12:40:54 -0500
Received: by mail-wr1-f65.google.com with SMTP id a6so5106149wrx.12
        for <linux-arch@vger.kernel.org>; Thu, 30 Jan 2020 09:40:53 -0800 (PST)
In-Reply-To: <20200124161810.24322-1-guoren@linux.alibaba.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
Cc: linux-riscv@lists.infradead.org, linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org, linux-csky@vger.kernel.org, guoren@linux.alibaba.com, Andrew Waterman <andrew@sifive.com>, palmer@sifive.com

On Fri, 24 Jan 2020 16:18:10 GMT (+0000), guoren@linux.alibaba.com wrote:
> The only call path is:
>
> __access_remote_vm -> copy_to_user_page -> flush_icache_user_range
>
> Seems it's ok to use flush_icache_mm instead of flush_icache_all and
> it could reduce flush_icache_all called on other harts.
>
> I think the patch is the fixup for the commit 08f051eda33b.
>
> Signed-off-by: Guo Ren <guoren@linux.alibaba.com>
> Cc: Andrew Waterman <andrew@sifive.com>
> Cc: Palmer Dabbelt <palmer@sifive.com>
> ---
>  arch/riscv/include/asm/cacheflush.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/arch/riscv/include/asm/cacheflush.h b/arch/riscv/include/asm/cacheflush.h
> index b69aecbb36d3..26589623fd57 100644
> --- a/arch/riscv/include/asm/cacheflush.h
> +++ b/arch/riscv/include/asm/cacheflush.h
> @@ -85,7 +85,7 @@ static inline void flush_dcache_page(struct page *page)
>   * so instead we just flush the whole thing.
>   */
>  #define flush_icache_range(start, end) flush_icache_all()
> -#define flush_icache_user_range(vma, pg, addr, len) flush_icache_all()
> +#define flush_icache_user_range(vma, pg, addr, len) flush_icache_mm(vma->vm_mm, 0)
>
>  void dma_wbinv_range(unsigned long start, unsigned long end);
>  void dma_wb_range(unsigned long start, unsigned long end);

Reviewed-by: Palmer Dabbelt <palmerdabbelt@google.com>

I've added this to for-next with some minor modifications as
4d99abce8ce80e866020ffa5b2bd790269235f37.  It missed the PR I'm sending
now-ish, but I'll include it as part of the next one even if it's during an
early RC.

Thanks!
