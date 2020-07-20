Return-Path: <SRS0=C7+S=A7=vger.kernel.org=linux-arch-owner@kernel.org>
Received: from szxga07-in.huawei.com ([45.249.212.35]:50906 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726225AbgGTCCS (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Sun, 19 Jul 2020 22:02:18 -0400
Subject: Re: [PATCH v2 4/4] mm/vmalloc: Hugepage vmalloc mappings
References: <20200413125303.423864-1-npiggin@gmail.com>
 <20200413125303.423864-5-npiggin@gmail.com>
From: Zefan Li <lizefan@huawei.com>
Message-ID: <0e43e743-7c78-fb86-6c36-f42e6184d32c@huawei.com>
Date: Mon, 20 Jul 2020 10:02:13 +0800
MIME-Version: 1.0
In-Reply-To: <20200413125303.423864-5-npiggin@gmail.com>
Content-Type: text/plain; charset="gbk"
Content-Transfer-Encoding: 7bit
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Nicholas Piggin <npiggin@gmail.com>, linux-mm@kvack.org
Cc: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, linux-arm-kernel@lists.infradead.org, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>
Message-ID: <20200720020213.pDgVfbEXxOk4uEFx4MzWTzekWDTPEuvMmwJ6rPU5wAw@z>

> +static int vmap_pages_range_noflush(unsigned long start, unsigned long end,
> +				    pgprot_t prot, struct page **pages,
> +				    unsigned int page_shift)
> +{
> +	if (page_shift == PAGE_SIZE) {

Is this a typo of PAGE_SHIFT?

> +		return vmap_small_pages_range_noflush(start, end, prot, pages);
> +	} else {
> +		unsigned long addr = start;
> +		unsigned int i, nr = (end - start) >> page_shift;
> +
> +		for (i = 0; i < nr; i++) {
> +			int err;
> +
> +			err = vmap_range_noflush(addr,
> +					addr + (1UL << page_shift),
> +					__pa(page_address(pages[i])), prot,
> +					page_shift);
> +			if (err)
> +				return err;
> +
> +			addr += 1UL << page_shift;
> +		}
> +
> +		return 0;
> +	}
> +}
> +
