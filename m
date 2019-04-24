Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from verein.lst.de ([213.95.11.211]:54144 "EHLO newverein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725921AbfDXOXY (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Wed, 24 Apr 2019 10:23:24 -0400
Date: Wed, 24 Apr 2019 16:23:06 +0200
From: Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH] riscv: Support non-coherency memory model
Message-ID: <20190424142306.GB20974@lst.de>
References: <1555947870-23014-1-git-send-email-guoren@kernel.org> <20190422161814.GA30694@lst.de> <20190423001348.GA31639@guoren-Inspiron-7460> <20190423055548.GA12365@lst.de> <20190423154642.GA16001@guoren-Inspiron-7460> <d1988350-7da9-37bb-3d8b-93bedea0b732@garyguo.net> <20190424020803.GA27332@guoren-Inspiron-7460> <LO2P265MB0847C9F08481E25DABC77335D63C0@LO2P265MB0847.GBRP265.PROD.OUTLOOK.COM> <20190424055703.GA3417@guoren-Inspiron-7460> <4e6b0816-3fe9-8c0b-a749-f7f6ef7e5742@garyguo.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4e6b0816-3fe9-8c0b-a749-f7f6ef7e5742@garyguo.net>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Gary Guo <gary@garyguo.net>
Cc: Guo Ren <guoren@kernel.org>, Christoph Hellwig <hch@lst.de>, "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>, Palmer Dabbelt <palmer@sifive.com>, Andrew Waterman <andrew@sifive.com>, Arnd Bergmann <arnd@arndb.de>, Anup Patel <anup.patel@wdc.com>, Xiang Xiaoyan <xiaoyan_xiang@c-sky.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Mike Rapoport <rppt@linux.ibm.com>, Vincent Chen <vincentc@andestech.com>, Greentime Hu <green.hu@gmail.com>, "ren_guo@c-sky.com" <ren_guo@c-sky.com>, "linux-riscv@lists.infradead.org" <linux-riscv@lists.infradead.org>, Marek Szyprowski <m.szyprowski@samsung.com>, Robin Murphy <robin.murphy@arm.com>, Scott Wood <swood@redhat.com>, "tech-privileged@lists.riscv.org" <tech-privileged@lists.riscv.org>
Message-ID: <20190424142306.KnhJ2grbWPnRYvCMi8Vx-BAbb9hCHeowvobuhcYqWoE@z>

On Wed, Apr 24, 2019 at 12:45:56PM +0000, Gary Guo wrote:
> The RISC-V privileged spec is explicitly designed to allow the 
> techniques described above (this is the sole purpose of MSTATUS.TVM). It 
> might be as high performance as a hardware with H-extension, but is 
> definitely a legit use case. In fact, it is vital for use cases like 
> recursive virtualization.
> 
> Also, I believe the PTE format of RISC-V is already frozen -- therefore 
> it is impossible now to merge GLOBAL and USER bit, nor to replace RSW 
> bit with another bit.

Yes, I do not think we can just repurpose a bit.  Even using a currently
unused one would require some gymnastics.

That being said IFF we want to support non-coherent DMA (and I think we
do as people glue together their SOCs using shoestring and paper clips,
as already demonstrated by Andes and C-SKY in RISC-V space, and most
arm, mips and ppc SOCs) we need something like this flag.  The current
RISC-V method that only allows M-mode to set up such attributes on
a small number or PMP regions just doesn't work well with the way how
Linux and most non-trivial OSes implement DMA memory allocations.

Note that I said well - in theory we can have a firmware provided
uncached pool - that is what Linux does on most nommu (that is without
pagetables) ports, but the fixed sized pool really does suck and will
make users very unhappy.
