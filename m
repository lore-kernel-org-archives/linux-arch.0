Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:57824 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725792AbfEEGPm (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Sun, 5 May 2019 02:15:42 -0400
Received: from pps.filterd (m0098414.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x4566etu020181
        for <linux-arch@vger.kernel.org>; Sun, 5 May 2019 02:15:40 -0400
Received: from e06smtp07.uk.ibm.com (e06smtp07.uk.ibm.com [195.75.94.103])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2s9r1av04c-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-arch@vger.kernel.org>; Sun, 05 May 2019 02:15:40 -0400
Received: from localhost
        by e06smtp07.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-arch@vger.kernel.org> from <rppt@linux.ibm.com>;
        Sun, 5 May 2019 07:15:38 +0100
Date: Sun, 5 May 2019 09:15:26 +0300
From: Mike Rapoport <rppt@linux.ibm.com>
Subject: Re: [PATCH 01/15] asm-generic, x86: introduce generic
 pte_{alloc,free}_one[_kernel]
References: <1556810922-20248-1-git-send-email-rppt@linux.ibm.com>
 <1556810922-20248-2-git-send-email-rppt@linux.ibm.com>
 <20190502190310.voenw3pwgpelmdgw@pburton-laptop>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190502190310.voenw3pwgpelmdgw@pburton-laptop>
Message-ID: <20190505061525.GC15755@rapoport-lnx>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Paul Burton <paul.burton@mips.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, Arnd Bergmann <arnd@arndb.de>, Catalin Marinas <catalin.marinas@arm.com>, Geert Uytterhoeven <geert@linux-m68k.org>, Greentime Hu <green.hu@gmail.com>, Guan Xuetao <gxt@pku.edu.cn>, Guo Ren <guoren@kernel.org>, Helge Deller <deller@gmx.de>, Ley Foon Tan <lftan@altera.com>, Matthew Wilcox <willy@infradead.org>, Matt Turner <mattst88@gmail.com>, Michael Ellerman <mpe@ellerman.id.au>, Michal Hocko <mhocko@suse.com>, Palmer Dabbelt <palmer@sifive.com>, Richard Kuo <rkuo@codeaurora.org>, Richard Weinberger <richard@nod.at>, Russell King <linux@armlinux.org.uk>, Sam Creasey <sammy@sammy.net>, "x86@kernel.org" <x86@kernel.org>, "linux-alpha@vger.kernel.org" <linux-alpha@vger.kernel.org>, "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "linux-hexagon@vger.kernel.org" <linux-hexagon@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-m68k@lists.linux-m68k.org" <linux-m68k@lists.linux-m68k.org>, "linux-mips@vger.kernel.org" <linux-mips@vger.kernel.org>, "linux-parisc@vger.kernel.org" <linux-parisc@vger.kernel.org>, "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>, "linux-riscv@lists.infradead.org" <linux-riscv@lists.infradead.org>, "linux-um@lists.infradead.org" <linux-um@lists.infradead.org>, "nios2-dev@lists.rocketboards.org" <nios2-dev@lists.rocketboards.org>
Message-ID: <20190505061526.nSfaLDk6ogIQcbvcaFF3nwDNHbFNeIwAR2mqBh32JEQ@z>

On Thu, May 02, 2019 at 07:03:11PM +0000, Paul Burton wrote:
> Hi Mike,
> 
> On Thu, May 02, 2019 at 06:28:28PM +0300, Mike Rapoport wrote:
> > +/**
> > + * pte_free_kernel - free PTE-level user page table page
> > + * @mm: the mm_struct of the current context
> > + * @pte_page: the `struct page` representing the page table
> > + */
> > +static inline void pte_free(struct mm_struct *mm, struct page *pte_page)
> > +{
> > +	pgtable_page_dtor(pte_page);
> > +	__free_page(pte_page);
> > +}
> 
> Nit: the comment names the wrong function (s/pte_free_kernel/pte_free/).

Argh, evil copy-paste :)
Thanks!
 
> Thanks,
>     Paul
> 

-- 
Sincerely yours,
Mike.
