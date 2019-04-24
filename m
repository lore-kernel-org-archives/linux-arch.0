Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:53190 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726840AbfDXCIQ (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Tue, 23 Apr 2019 22:08:16 -0400
Date: Wed, 24 Apr 2019 10:08:04 +0800
From: Guo Ren <guoren@kernel.org>
Subject: Re: [PATCH] riscv: Support non-coherency memory model
Message-ID: <20190424020803.GA27332@guoren-Inspiron-7460>
References: <1555947870-23014-1-git-send-email-guoren@kernel.org>
 <20190422161814.GA30694@lst.de>
 <20190423001348.GA31639@guoren-Inspiron-7460>
 <20190423055548.GA12365@lst.de>
 <20190423154642.GA16001@guoren-Inspiron-7460>
 <d1988350-7da9-37bb-3d8b-93bedea0b732@garyguo.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d1988350-7da9-37bb-3d8b-93bedea0b732@garyguo.net>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Gary Guo <gary@garyguo.net>
Cc: Christoph Hellwig <hch@lst.de>, "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>, Palmer Dabbelt <palmer@sifive.com>, Andrew Waterman <andrew@sifive.com>, Arnd Bergmann <arnd@arndb.de>, Anup Patel <anup.patel@wdc.com>, Xiang Xiaoyan <xiaoyan_xiang@c-sky.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Mike Rapoport <rppt@linux.ibm.com>, Vincent Chen <vincentc@andestech.com>, Greentime Hu <green.hu@gmail.com>, "ren_guo@c-sky.com" <ren_guo@c-sky.com>, "linux-riscv@lists.infradead.org" <linux-riscv@lists.infradead.org>, Marek Szyprowski <m.szyprowski@samsung.com>, Robin Murphy <robin.murphy@arm.com>, Scott Wood <swood@redhat.com>, "tech-privileged@lists.riscv.org" <tech-privileged@lists.riscv.org>
Message-ID: <20190424020804.8UXwmEq4WXc0HmBXojpDHa0yjp6d5tCIDqZZmbTyrTY@z>

Hi Gary,

On Tue, Apr 23, 2019 at 03:57:30PM +0000, Gary Guo wrote:
> >>> Another point is we could get more attribute bits by modify the riscv
> >>> spec:
> >>>   - Remove Global bit, I think it's duplicate with the User bit in linux.
> >>
> >> It is in Linux, but it is conceptually very different.
> > Yes, but hardware could ignore one of them and in riscv linux
> > _PAGE_GLOBAL is no use at all, see:
> > grep _PAGE_GLOBAL arch/riscv -r
> > 
> > In fact, the _PAGE_KERNEL for pte doesn't contain _PAGE_GLOBAL and it
> > works on FU540 and qemu. As I've mentioned page attribute bits is very
> > precious, define a useless bit make people confused.
>  >
> 
> The fact that it isn't used yet doesn't imply it is not useful. We don't 
> use ASIDs at the moment, and without using ASIDs the "global" bit is 
> indeed not useful. However with ASIDs the bit will be vital for saving 
> TLB spaces. Without the global bit, the kernel pages become synonyms to 
> themselves (i.e. they have different tags in TLB but refer to the same 
> physical page).
> 
> The global bit also exists in many other ISAs as well. It's definitely 
> not a "useless" bits.
> 
> Moreover, this bit is already implemented in both Rocket and Ariane. It 
> is also in the spec for quite a while. The fact that Linux doesn't use 
> it at the moment is not a reason for removing it.
> 

Look:
linux-next git:(riscv_asid_allocator_v2)$ grep GLOBAL arch/riscv -r
arch/riscv/include/asm/pgtable-bits.h:#define _PAGE_GLOBAL    (1 << 5)    /* Global */
arch/riscv/include/asm/pgtable-bits.h:                                    _PAGE_USER | _PAGE_GLOBAL))

Your patch tell us _PAGE_USER and _PAGE_GLOBAL are duplicate and why we
couldn't make _PAGE_USER implies _PAGE_GLOBAL? Can you give an example
of a real scene in PTE about:
  _PAGE_USER:0 + _PAGE_GLOBAL:1
or
  _PAGE_USER:1 + _PAGE_GLOBAL:0

Of cause I know USER & GLOBAL are conceptually very different, but
there are only 10 attribute-bits for riscv (In fact we've wasted two bits
to support huge RV32-pfn :P). So I think it is time to merge these two bits
before hardware supports GLOBAL. Reserve them for future!

Best Regards
 Guo Ren
