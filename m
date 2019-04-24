Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:36068 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729244AbfDXF5P (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Wed, 24 Apr 2019 01:57:15 -0400
Date: Wed, 24 Apr 2019 13:57:03 +0800
From: Guo Ren <guoren@kernel.org>
Subject: Re: [PATCH] riscv: Support non-coherency memory model
Message-ID: <20190424055703.GA3417@guoren-Inspiron-7460>
References: <1555947870-23014-1-git-send-email-guoren@kernel.org>
 <20190422161814.GA30694@lst.de>
 <20190423001348.GA31639@guoren-Inspiron-7460>
 <20190423055548.GA12365@lst.de>
 <20190423154642.GA16001@guoren-Inspiron-7460>
 <d1988350-7da9-37bb-3d8b-93bedea0b732@garyguo.net>
 <20190424020803.GA27332@guoren-Inspiron-7460>
 <LO2P265MB0847C9F08481E25DABC77335D63C0@LO2P265MB0847.GBRP265.PROD.OUTLOOK.COM>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <LO2P265MB0847C9F08481E25DABC77335D63C0@LO2P265MB0847.GBRP265.PROD.OUTLOOK.COM>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Gary Guo <gary@garyguo.net>
Cc: Christoph Hellwig <hch@lst.de>, "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>, Palmer Dabbelt <palmer@sifive.com>, Andrew Waterman <andrew@sifive.com>, Arnd Bergmann <arnd@arndb.de>, Anup Patel <anup.patel@wdc.com>, Xiang Xiaoyan <xiaoyan_xiang@c-sky.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Mike Rapoport <rppt@linux.ibm.com>, Vincent Chen <vincentc@andestech.com>, Greentime Hu <green.hu@gmail.com>, "ren_guo@c-sky.com" <ren_guo@c-sky.com>, "linux-riscv@lists.infradead.org" <linux-riscv@lists.infradead.org>, Marek Szyprowski <m.szyprowski@samsung.com>, Robin Murphy <robin.murphy@arm.com>, Scott Wood <swood@redhat.com>, "tech-privileged@lists.riscv.org" <tech-privileged@lists.riscv.org>
Message-ID: <20190424055703.lYHFnl9qXXf43u1QiXdc4TYDQWa5UAmHZVBdbW6l4gw@z>

Hi Gary,

On Wed, Apr 24, 2019 at 03:21:14AM +0000, Gary Guo wrote:
> > Look:
> > linux-next git:(riscv_asid_allocator_v2)$ grep GLOBAL arch/riscv -r
> > arch/riscv/include/asm/pgtable-bits.h:#define _PAGE_GLOBAL    (1 << 5)    /*
> > Global */
> > arch/riscv/include/asm/pgtable-bits.h:                                    _PAGE_USER |
> > _PAGE_GLOBAL))
> > 
> > Your patch tell us _PAGE_USER and _PAGE_GLOBAL are duplicate and why we
> > couldn't make _PAGE_USER implies _PAGE_GLOBAL? Can you give an example
> > of a real scene in PTE about:
> >   _PAGE_USER:0 + _PAGE_GLOBAL:1
> > or
> >   _PAGE_USER:1 + _PAGE_GLOBAL:0
> > 
> > Of cause I know USER & GLOBAL are conceptually very different, but
> > there are only 10 attribute-bits for riscv (In fact we've wasted two bits
> > to support huge RV32-pfn :P). So I think it is time to merge these two bits
> > before hardware supports GLOBAL. Reserve them for future!
> 
> Two cases I can think of:
> * vdso like things. They're user pages that can really be shared across address spaces (i.e. global). Kernels like L4 implement most systems calls similar to VDSO, so USER + GLOBAL is useful.
Vdso is a user space mapping in linux, See: fs/binfmt_elf.c

static int load_elf_binary(struct linux_binprm *bprm) {
...
#ifdef ARCH_HAS_SETUP_ADDITIONAL_PAGES
	retval = arch_setup_additional_pages(bprm, !!elf_interpreter);
	if (retval < 0)
		goto out;
#endif /* ARCH_HAS_SETUP_ADDITIONAL_PAGES */

All linux archs use arch_setup_additional_pages for vdso mapping and
every process has its own vdso mapping to the same pages.

I don't think vdso is a real scene for GLOBAL in PTE.

> * hypervisor without H-extension: This requires shadow page tables. Supervisor
> pages are mapped to supervisor shadow pages. However these shadow pages cannot
> be GLOBAL because they can't be shared between VMs. So  !USER + !GLOBAL is useful.
Hypervisor use 2-stages TLB translation in hardware and shadow page
tables is for stage 2 translation. Shadow page tables care vmid not
asid.
If hardware don't support H-extension (MMU 2-stages translation), it's
hard to accept for virtualization performance.

I don't think hypervisor is a real scene for GLOBAL in PTE.

Are there other scene for GLOBAL in PTE?

Best Regards
 Guo Ren
