Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail-eopbgr100104.outbound.protection.outlook.com ([40.107.10.104]:55136
        "EHLO GBR01-LO2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726422AbfDXDVS (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Tue, 23 Apr 2019 23:21:18 -0400
From: Gary Guo <gary@garyguo.net>
Subject: RE: [PATCH] riscv: Support non-coherency memory model
Date: Wed, 24 Apr 2019 03:21:14 +0000
Message-ID: <LO2P265MB0847C9F08481E25DABC77335D63C0@LO2P265MB0847.GBRP265.PROD.OUTLOOK.COM>
References: <1555947870-23014-1-git-send-email-guoren@kernel.org>
 <20190422161814.GA30694@lst.de> <20190423001348.GA31639@guoren-Inspiron-7460>
 <20190423055548.GA12365@lst.de> <20190423154642.GA16001@guoren-Inspiron-7460>
 <d1988350-7da9-37bb-3d8b-93bedea0b732@garyguo.net>
 <20190424020803.GA27332@guoren-Inspiron-7460>
In-Reply-To: <20190424020803.GA27332@guoren-Inspiron-7460>
Content-Language: en-US
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Guo Ren <guoren@kernel.org>
Cc: Christoph Hellwig <hch@lst.de>, "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>, Palmer Dabbelt <palmer@sifive.com>, Andrew Waterman <andrew@sifive.com>, Arnd Bergmann <arnd@arndb.de>, Anup Patel <anup.patel@wdc.com>, Xiang Xiaoyan <xiaoyan_xiang@c-sky.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Mike Rapoport <rppt@linux.ibm.com>, Vincent Chen <vincentc@andestech.com>, Greentime Hu <green.hu@gmail.com>, "ren_guo@c-sky.com" <ren_guo@c-sky.com>, "linux-riscv@lists.infradead.org" <linux-riscv@lists.infradead.org>, Marek Szyprowski <m.szyprowski@samsung.com>, Robin Murphy <robin.murphy@arm.com>, Scott Wood <swood@redhat.com>, "tech-privileged@lists.riscv.org" <tech-privileged@lists.riscv.org>
Message-ID: <20190424032114.VaUCPqGPPiBFMU5Iv78ldOrIkoeEMpB5cnGlW6ubI74@z>



> -----Original Message-----
> From: Guo Ren <guoren@kernel.org>
> Sent: Wednesday, April 24, 2019 03:08
> To: Gary Guo <gary@garyguo.net>
> Cc: Christoph Hellwig <hch@lst.de>; linux-arch@vger.kernel.org; Palmer
> Dabbelt <palmer@sifive.com>; Andrew Waterman <andrew@sifive.com>; Arnd
> Bergmann <arnd@arndb.de>; Anup Patel <anup.patel@wdc.com>; Xiang
> Xiaoyan <xiaoyan_xiang@c-sky.com>; linux-kernel@vger.kernel.org; Mike
> Rapoport <rppt@linux.ibm.com>; Vincent Chen <vincentc@andestech.com>;
> Greentime Hu <green.hu@gmail.com>; ren_guo@c-sky.com; linux-
> riscv@lists.infradead.org; Marek Szyprowski <m.szyprowski@samsung.com>;
> Robin Murphy <robin.murphy@arm.com>; Scott Wood <swood@redhat.com>;
> tech-privileged@lists.riscv.org
> Subject: Re: [PATCH] riscv: Support non-coherency memory model
>=20
> Hi Gary,
>=20
> On Tue, Apr 23, 2019 at 03:57:30PM +0000, Gary Guo wrote:
> > >>> Another point is we could get more attribute bits by modify the ris=
cv
> > >>> spec:
> > >>>   - Remove Global bit, I think it's duplicate with the User bit in =
linux.
> > >>
> > >> It is in Linux, but it is conceptually very different.
> > > Yes, but hardware could ignore one of them and in riscv linux
> > > _PAGE_GLOBAL is no use at all, see:
> > > grep _PAGE_GLOBAL arch/riscv -r
> > >
> > > In fact, the _PAGE_KERNEL for pte doesn't contain _PAGE_GLOBAL and it
> > > works on FU540 and qemu. As I've mentioned page attribute bits is ver=
y
> > > precious, define a useless bit make people confused.
> >  >
> >
> > The fact that it isn't used yet doesn't imply it is not useful. We don'=
t
> > use ASIDs at the moment, and without using ASIDs the "global" bit is
> > indeed not useful. However with ASIDs the bit will be vital for saving
> > TLB spaces. Without the global bit, the kernel pages become synonyms to
> > themselves (i.e. they have different tags in TLB but refer to the same
> > physical page).
> >
> > The global bit also exists in many other ISAs as well. It's definitely
> > not a "useless" bits.
> >
> > Moreover, this bit is already implemented in both Rocket and Ariane. It
> > is also in the spec for quite a while. The fact that Linux doesn't use
> > it at the moment is not a reason for removing it.
> >
>=20
> Look:
> linux-next git:(riscv_asid_allocator_v2)$ grep GLOBAL arch/riscv -r
> arch/riscv/include/asm/pgtable-bits.h:#define _PAGE_GLOBAL    (1 << 5)   =
 /*
> Global */
> arch/riscv/include/asm/pgtable-bits.h:                                   =
 _PAGE_USER |
> _PAGE_GLOBAL))
>=20
> Your patch tell us _PAGE_USER and _PAGE_GLOBAL are duplicate and why we
> couldn't make _PAGE_USER implies _PAGE_GLOBAL? Can you give an example
> of a real scene in PTE about:
>   _PAGE_USER:0 + _PAGE_GLOBAL:1
> or
>   _PAGE_USER:1 + _PAGE_GLOBAL:0
>=20
> Of cause I know USER & GLOBAL are conceptually very different, but
> there are only 10 attribute-bits for riscv (In fact we've wasted two bits
> to support huge RV32-pfn :P). So I think it is time to merge these two bi=
ts
> before hardware supports GLOBAL. Reserve them for future!

Two cases I can think of:
* vdso like things. They're user pages that can really be shared across add=
ress spaces (i.e. global). Kernels like L4 implement most systems calls sim=
ilar to VDSO, so USER + GLOBAL is useful.
* hypervisor without H-extension: This requires shadow page tables. Supervi=
sor pages are mapped to supervisor shadow pages. However these shadow pages=
 cannot be GLOBAL because they can't be shared between VMs. So  !USER + !GL=
OBAL is useful.

Remember Linux isn't the only supervisor software that RISC-V cares!=20

>=20
> Best Regards
>  Guo Ren
