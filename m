From: Zefan Li <lizefan@huawei.com>
Subject: Re: [PATCH v2 4/4] mm/vmalloc: Hugepage vmalloc mappings
Date: Mon, 20 Jul 2020 10:02:13 +0800
Message-ID: <0e43e743-7c78-fb86-6c36-f42e6184d32c@huawei.com>
References: <20200413125303.423864-1-npiggin@gmail.com>
 <20200413125303.423864-5-npiggin@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="gbk"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20200413125303.423864-5-npiggin@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Nicholas Piggin <npiggin@gmail.com>, linux-mm@kvack.org
Cc: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, linux-arm-kernel@lists.infradead.org, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>
List-Id: linux-arch.vger.kernel.org

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
