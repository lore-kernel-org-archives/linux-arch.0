From: Will Deacon <will.deacon@arm.com>
Subject: Re: question about iotable_init( )  function
Date: Mon, 1 Jul 2013 10:27:24 +0100
Message-ID: <20130701092723.GE14027@mudshark.cambridge.arm.com>
References: <35FD53F367049845BC99AC72306C23D19441BF586F@CNBJMBX05.corpusers.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from cam-admin0.cambridge.arm.com ([217.140.96.50]:37259 "EHLO
	cam-admin0.cambridge.arm.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753384Ab3GAJ2D (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Mon, 1 Jul 2013 05:28:03 -0400
Content-Disposition: inline
In-Reply-To: <35FD53F367049845BC99AC72306C23D19441BF586F@CNBJMBX05.corpusers.net>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: "Wang, Yalin" <Yalin.Wang@sonymobile.com>
Cc: 'Russell King - ARM Linux' <linux@arm.linux.org.uk>, "'linux-arm-kernel@lists.infradead.org'" <linux-arm-kernel@lists.infradead.org>, "'linux-arch@vger.kernel.org'" <linux-arch@vger.kernel.org>

On Mon, Jul 01, 2013 at 08:31:38AM +0100, Wang, Yalin wrote:
> Hi  Will,
>=20
> I have a question about iotable_init()  function (arch/arm/mm/mmu.c)
> I found  in this function it only allocate a vm_struct and insert it =
into vmlist ,
> But it didn=E2=80=99t allocate a vmap_area  to insert it  into vmap_a=
rea_root tree (mm/vmalloc.c).
>=20
> So this means that the virtual address reserverd by iotable_init is n=
ot declared
> In vmap_area_root  ,  this is not safe ,  maybe some driver will use =
this virtual address as vmalloc again,
> I think it =E2=80=98s not safe in this condition ,  should also add a=
 vmap_area   node into vmap_area_root to
> Hold this virtual address not used by others .

The vmap_area structures are allocated and inserted later on by vmalloc=
_init
(iotable init is for static mappings early during boot).

Will
