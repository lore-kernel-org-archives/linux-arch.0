Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail-eopbgr740135.outbound.protection.outlook.com ([40.107.74.135]:50333
        "EHLO NAM01-BN3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726120AbfEBTJv (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Thu, 2 May 2019 15:09:51 -0400
From: Paul Burton <paul.burton@mips.com>
Subject: Re: [PATCH 08/15] mips: switch to generic version of pte allocation
Date: Thu, 2 May 2019 19:09:47 +0000
Message-ID: <20190502190945.rrrxfxo3rbhgc3cx@pburton-laptop>
References: <1556810922-20248-1-git-send-email-rppt@linux.ibm.com>
 <1556810922-20248-9-git-send-email-rppt@linux.ibm.com>
In-Reply-To: <1556810922-20248-9-git-send-email-rppt@linux.ibm.com>
Content-Language: en-US
Content-Type: text/plain; charset="us-ascii"
Content-ID: <5F06A475B76E7846961ABC0FB62B828B@namprd22.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Mike Rapoport <rppt@linux.ibm.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, Arnd Bergmann <arnd@arndb.de>, Catalin Marinas <catalin.marinas@arm.com>, Geert Uytterhoeven <geert@linux-m68k.org>, Greentime Hu <green.hu@gmail.com>, Guan Xuetao <gxt@pku.edu.cn>, Guo Ren <guoren@kernel.org>, Helge Deller <deller@gmx.de>, Ley Foon Tan <lftan@altera.com>, Matthew Wilcox <willy@infradead.org>, Matt Turner <mattst88@gmail.com>, Michael Ellerman <mpe@ellerman.id.au>, Michal Hocko <mhocko@suse.com>, Palmer Dabbelt <palmer@sifive.com>, Richard Kuo <rkuo@codeaurora.org>, Richard Weinberger <richard@nod.at>, Russell King <linux@armlinux.org.uk>, Sam Creasey <sammy@sammy.net>, "x86@kernel.org" <x86@kernel.org>, "linux-alpha@vger.kernel.org" <linux-alpha@vger.kernel.org>, "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "linux-hexagon@vger.kernel.org" <linux-hexagon@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-m68k@lists.linux-m68k.org" <linux-m68k@lists.linux-m68k.org>, "linux-mips@vger.kernel.org" <linux-mips@vger.kernel.org>, "linux-parisc@vger.kernel.org" <linux-parisc@vger.kernel.org>, "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>, "linux-riscv@lists.infradead.org" <linux-riscv@lists.infradead.org>, "linux-um@lists.infradead.org" <linux-um@lists.infradead.org>, "nios2-dev@lists.rocketboards.org" <nios2-dev@lists.rocketboards.org>
Message-ID: <20190502190947.YJAe_uLtFgmd8nDrdX70-noFWbueXQb6kQvncetq3tk@z>

Hi Mike,

On Thu, May 02, 2019 at 06:28:35PM +0300, Mike Rapoport wrote:
> MIPS allocates kernel PTE pages with
>=20
> 	__get_free_pages(GFP_KERNEL | __GFP_ZERO, PTE_ORDER)
>=20
> and user PTE pages with
>=20
> 	alloc_pages(GFP_KERNEL | __GFP_ZERO, PTE_ORDER)

That bit isn't quite true - we don't use __GFP_ZERO in pte_alloc_one() &
instead call clear_highpage() on the allocated page. Not that I have a
problem with using __GFP_ZERO - it seems like the more optimal choice.
It just might be worth mentioning the change & expected equivalent
behavior.

Otherwise:

    Acked-by: Paul Burton <paul.burton@mips.com>

Thanks,
    Paul
