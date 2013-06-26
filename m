From: Will Deacon <will.deacon@arm.com>
Subject: Re: ARM pagetable setting in Linux
Date: Wed, 26 Jun 2013 18:16:49 +0100
Message-ID: <20130626171649.GG10333@mudshark.cambridge.arm.com>
References: <35FD53F367049845BC99AC72306C23D19441BF5863@CNBJMBX05.corpusers.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from cam-admin0.cambridge.arm.com ([217.140.96.50]:60625 "EHLO
	cam-admin0.cambridge.arm.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751893Ab3FZRRR (ORCPT
	<rfc822;linux-arch@vger.kernel.org>);
	Wed, 26 Jun 2013 13:17:17 -0400
Content-Disposition: inline
In-Reply-To: <35FD53F367049845BC99AC72306C23D19441BF5863@CNBJMBX05.corpusers.net>
Content-Language: en-US
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: "Wang, Yalin" <Yalin.Wang@sonymobile.com>
Cc: "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>, "'linux-arch@vger.kernel.org'" <linux-arch@vger.kernel.org>, linux-arm-kernel@lists.infradead.org

[adding the ARM list -- please try and remember to do that in future]

On Wed, Jun 26, 2013 at 03:41:40AM +0100, Wang, Yalin wrote:
> Hi  Will,

Hello,

> I have a question about  arm pagetable setting in Linux .
>=20
> From armV6,  there is TTBR0 and TTBR1  translation base address regis=
ters  in mmu .
> But I  found linux only use TTBR0 for translation base address ,
> Could we use TTBR0 and TTBR1 to split user task and kernel pagetables=
 (swapper_pg_dir)=EF=BC=9F=20
>=20
> But I found this need set TTBCR.N   ,
> If PAGE_OFFSET=3D=3D0xc0000000  ,   set TTBCR.N=3D0x2 ,
> Will not work , because   only ensure 0--0x00FFFFFF  MVA use TTBCR0=20
> And other  MVA=E3=80=80will use TTBCR1 ,
> But if we set PAGE_OFFSET=3D=3D0x80000000  (2GB split )  ,
> And set  TTBCR.N=3D0x1 ,
> This will make sure user task MVA use TTBCR0 and kernel  MVA=20
> Use TTBCR1 , this  will make some improvement for the system .
>=20
> 1. Because we don=E2=80=99t need copy kernel first =E2=80=93level pag=
etables into every=20
> User task=E2=80=99s pagetables and flush tlb (for example fork() a ne=
w process).

Well, you still need the TLB maintenance for setting up CoW, so this wi=
n is
probably not very big.

> 2. And don=E2=80=99t need handle kernel page fault because that user =
task=E2=80=99s kernel=20
> Pagetable when it is not set up , need copy again( for example vmallo=
c()  ioremap()  kmap()  will change=20
> Kernel pagetables and need update to every task pagetables ) .

Is that really a fastpath?

> 3. We  even can only allocate 8KB first level pagetables for user tas=
k to save=20
> Memorys .

That would be a nice gain, but there are a number of factors here:

	1. Pre-ARMv6 only have one ttbr, so you'd end up needing to support
	   both configurations in the same kernel source.

	2. The module area lives below PAGE_OFFSET, so you still have to
	   deal with that correctly (mitigating some of your earlier points)

	3. PAGE_OFFSET is not fixed at 2GB, so you constrain your use-case
	   even further.

	4. We do actually use TTBR1 to hold an identity mapping at the
	   moment. This could probably be fixed, but would require some
	   thought.

There's undoubtedly other problems that haven't immediately come to me =
but,
all in all, I don't think this is a significant enough win to justify t=
he
effort and maintenance headache.

Cheers,

Will
