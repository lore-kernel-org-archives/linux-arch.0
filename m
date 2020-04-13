Return-Path: <SRS0=XT2V=55=kvack.org=owner-linux-mm@kernel.org>
Date: Mon, 13 Apr 2020 06:41:06 -0700
From: Matthew Wilcox <willy@infradead.org>
Subject: Re: [PATCH v2 4/4] mm/vmalloc: Hugepage vmalloc mappings
Message-ID: <20200413134106.GN21484@bombadil.infradead.org>
References: <20200413125303.423864-1-npiggin@gmail.com>
 <20200413125303.423864-5-npiggin@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200413125303.423864-5-npiggin@gmail.com>
Sender: owner-linux-mm@kvack.org
To: Nicholas Piggin <npiggin@gmail.com>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, linux-arm-kernel@lists.infradead.org, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>
List-ID: <linux-arch.vger.kernel.org>
Message-ID: <20200413134106.4ssnec2wrKquszS4_mcLnwnSWES7Kr3f-HklW0Aj32w@z>

On Mon, Apr 13, 2020 at 10:53:03PM +1000, Nicholas Piggin wrote:
> +static int vmap_pages_range_noflush(unsigned long start, unsigned long end,
> +				    pgprot_t prot, struct page **pages,
> +				    unsigned int page_shift)
> +{
> +	if (page_shift == PAGE_SIZE) {

... I think you meant 'page_shift == PAGE_SHIFT'

Overall I like this series, although it's a bit biased towards CPUs
which have page sizes which match PMD/PUD sizes.  It doesn't offer the
possibility of using 64kB page sizes on ARM, for example.  But it's a
step in the right direction.
