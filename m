From: Paul Burton <paul.burton@mips.com>
Subject: Re: [PATCH 01/15] asm-generic, x86: introduce generic
 pte_{alloc,free}_one[_kernel]
Date: Thu, 2 May 2019 19:03:11 +0000
Message-ID: <20190502190310.voenw3pwgpelmdgw@pburton-laptop>
References: <1556810922-20248-1-git-send-email-rppt@linux.ibm.com>
 <1556810922-20248-2-git-send-email-rppt@linux.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1556810922-20248-2-git-send-email-rppt@linux.ibm.com>
Content-Language: en-US
Content-ID: <FEE563E1598F8E42B0910251031F2C94@namprd22.prod.outlook.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Mike Rapoport <rppt@linux.ibm.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, Arnd Bergmann <arnd@arndb.de>, Catalin Marinas <catalin.marinas@arm.com>, Geert Uytterhoeven <geert@linux-m68k.org>, Greentime Hu <green.hu@gmail.com>, Guan Xuetao <gxt@pku.edu.cn>, Guo Ren <guoren@kernel.org>, Helge Deller <deller@gmx.de>, Ley Foon Tan <lftan@altera.com>, Matthew Wilcox <willy@infradead.org>, Matt Turner <mattst88@gmail.com>, Michael Ellerman <mpe@ellerman.id.au>, Michal Hocko <mhocko@suse.com>, Palmer Dabbelt <palmer@sifive.com>, Richard Kuo <rkuo@codeaurora.org>, Richard Weinberger <richard@nod.at>, Russell King <linux@armlinux.org.uk>, Sam Creasey <sammy@sammy.net>, "x86@kernel.org" <x86@kernel.org>, "linux-alpha@vger.kernel.org" <linux-alpha@vger.kernel.org>, linux-arch@vger.ke
List-Id: linux-arch.vger.kernel.org

Hi Mike,

On Thu, May 02, 2019 at 06:28:28PM +0300, Mike Rapoport wrote:
> +/**
> + * pte_free_kernel - free PTE-level user page table page
> + * @mm: the mm_struct of the current context
> + * @pte_page: the `struct page` representing the page table
> + */
> +static inline void pte_free(struct mm_struct *mm, struct page *pte_page)
> +{
> +	pgtable_page_dtor(pte_page);
> +	__free_page(pte_page);
> +}

Nit: the comment names the wrong function (s/pte_free_kernel/pte_free/).

Thanks,
    Paul
