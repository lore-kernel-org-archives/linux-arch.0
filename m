Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:49028 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725792AbfEEGRx (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Sun, 5 May 2019 02:17:53 -0400
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x4566w3g174846
        for <linux-arch@vger.kernel.org>; Sun, 5 May 2019 02:17:52 -0400
Received: from e06smtp07.uk.ibm.com (e06smtp07.uk.ibm.com [195.75.94.103])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2s9r8x3mkp-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-arch@vger.kernel.org>; Sun, 05 May 2019 02:17:52 -0400
Received: from localhost
        by e06smtp07.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-arch@vger.kernel.org> from <rppt@linux.ibm.com>;
        Sun, 5 May 2019 07:17:50 +0100
Date: Sun, 5 May 2019 09:17:37 +0300
From: Mike Rapoport <rppt@linux.ibm.com>
Subject: Re: [PATCH 08/15] mips: switch to generic version of pte allocation
References: <1556810922-20248-1-git-send-email-rppt@linux.ibm.com>
 <1556810922-20248-9-git-send-email-rppt@linux.ibm.com>
 <20190502190945.rrrxfxo3rbhgc3cx@pburton-laptop>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190502190945.rrrxfxo3rbhgc3cx@pburton-laptop>
Message-ID: <20190505061737.GD15755@rapoport-lnx>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Paul Burton <paul.burton@mips.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, Arnd Bergmann <arnd@arndb.de>, Catalin Marinas <catalin.marinas@arm.com>, Geert Uytterhoeven <geert@linux-m68k.org>, Greentime Hu <green.hu@gmail.com>, Guan Xuetao <gxt@pku.edu.cn>, Guo Ren <guoren@kernel.org>, Helge Deller <deller@gmx.de>, Ley Foon Tan <lftan@altera.com>, Matthew Wilcox <willy@infradead.org>, Matt Turner <mattst88@gmail.com>, Michael Ellerman <mpe@ellerman.id.au>, Michal Hocko <mhocko@suse.com>, Palmer Dabbelt <palmer@sifive.com>, Richard Kuo <rkuo@codeaurora.org>, Richard Weinberger <richard@nod.at>, Russell King <linux@armlinux.org.uk>, Sam Creasey <sammy@sammy.net>, "x86@kernel.org" <x86@kernel.org>, "linux-alpha@vger.kernel.org" <linux-alpha@vger.kernel.org>, "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "linux-hexagon@vger.kernel.org" <linux-hexagon@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-m68k@lists.linux-m68k.org" <linux-m68k@lists.linux-m68k.org>, "linux-mips@vger.kernel.org" <linux-mips@vger.kernel.org>, "linux-parisc@vger.kernel.org" <linux-parisc@vger.kernel.org>, "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>, "linux-riscv@lists.infradead.org" <linux-riscv@lists.infradead.org>, "linux-um@lists.infradead.org" <linux-um@lists.infradead.org>, "nios2-dev@lists.rocketboards.org" <nios2-dev@lists.rocketboards.org>
Message-ID: <20190505061737.uH9uyycl0pzJEqyEKhv1eBU22pdKCPq_S_Bhl8imSbk@z>

On Thu, May 02, 2019 at 07:09:47PM +0000, Paul Burton wrote:
> Hi Mike,
> 
> On Thu, May 02, 2019 at 06:28:35PM +0300, Mike Rapoport wrote:
> > MIPS allocates kernel PTE pages with
> > 
> > 	__get_free_pages(GFP_KERNEL | __GFP_ZERO, PTE_ORDER)
> > 
> > and user PTE pages with
> > 
> > 	alloc_pages(GFP_KERNEL | __GFP_ZERO, PTE_ORDER)
> 
> That bit isn't quite true - we don't use __GFP_ZERO in pte_alloc_one() &
> instead call clear_highpage() on the allocated page. Not that I have a
> problem with using __GFP_ZERO - it seems like the more optimal choice.
> It just might be worth mentioning the change & expected equivalent
> behavior.

You are right, I'll fix the changelog.
 
> Otherwise:
> 
>     Acked-by: Paul Burton <paul.burton@mips.com>

Thanks.

> Thanks,
>     Paul
> 

-- 
Sincerely yours,
Mike.
