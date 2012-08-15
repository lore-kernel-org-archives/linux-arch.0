From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH v2 06/31] arm64: MMU fault handling and page table management
Date: Wed, 15 Aug 2012 13:47:00 +0000
Message-ID: <201208151347.01169.arnd@arndb.de>
References: <1344966752-16102-1-git-send-email-catalin.marinas@arm.com> <1344966752-16102-7-git-send-email-catalin.marinas@arm.com>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="windows-1252"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1344966752-16102-7-git-send-email-catalin.marinas@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Catalin Marinas <catalin.marinas@arm.com>
Cc: linux-arch@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, Will Deacon <will.deacon@arm.com>
List-Id: linux-arch.vger.kernel.org

On Tuesday 14 August 2012, Catalin Marinas wrote:
> +
> +pgd_t *pgd_alloc(struct mm_struct *mm)
> +{
> +	pgd_t *new_pgd;
> +
> +	new_pgd = (pgd_t *)__get_free_pages(GFP_KERNEL, PGD_ORDER);
> +	if (!new_pgd)
> +		return NULL;
> +
> +	memset(new_pgd, 0, PAGE_SIZE << PGD_ORDER);
> +
> +	return new_pgd;
> +}
> +
> +void pgd_free(struct mm_struct *mm, pgd_t *pgd)
> +{
> +	free_pages((unsigned long)pgd, PGD_ORDER);
> +}
 
According to the documentation, you should only need 8kb for the pgd on
a 64kb page system. Is it required that you use up a full page here?

	Arnd
