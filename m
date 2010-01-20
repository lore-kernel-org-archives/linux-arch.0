From: Russell King <rmk+lkml@arm.linux.org.uk>
Subject: Re: [CFT] MM: Pass a PTE pointer to update_mmu_cache() rather than
	the PTE itself
Date: Wed, 20 Jan 2010 16:54:44 +0000
Message-ID: <20100120165443.GB3284@flint.arm.linux.org.uk>
References: <20100120135202.GA20937@flint.arm.linux.org.uk> <10f740e81001200845o7a31bcb6yea475f3aabcb5476@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from caramon.arm.linux.org.uk ([78.32.30.218]:47637 "EHLO
	caramon.arm.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753110Ab0ATQy7 (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Wed, 20 Jan 2010 11:54:59 -0500
Content-Disposition: inline
In-Reply-To: <10f740e81001200845o7a31bcb6yea475f3aabcb5476@mail.gmail.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org

On Wed, Jan 20, 2010 at 05:45:34PM +0100, Geert Uytterhoeven wrote:
> > diff --git a/Documentation/cachetlb.txt b/Documentation/cachetlb.tx=
t
> > index da42ab4..74a8b6f 100644
> > --- a/Documentation/cachetlb.txt
> > +++ b/Documentation/cachetlb.txt
> > @@ -88,12 +88,12 @@ changes occur:
> > =A0 =A0 =A0 =A0This is used primarily during fault processing.
> >
> > =A05) void update_mmu_cache(struct vm_area_struct *vma,
> > - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0unsigned long addr=
ess, pte_t pte)
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0unsigned long addr=
ess, pte_t *ptep)
> >
> > =A0 =A0 =A0 =A0At the end of every page fault, this routine is invo=
ked to
> > =A0 =A0 =A0 =A0tell the architecture specific code that a translati=
on
> > - =A0 =A0 =A0 described by "pte" now exists at virtual address "add=
ress"
> > - =A0 =A0 =A0 for address space "vma->vm_mm", in the software page =
tables.
> > + =A0 =A0 =A0 now exists at virtual address "address" for address s=
pace
> > + =A0 =A0 =A0 "vma->vm_mm", in the software page tables.
> >
> > =A0 =A0 =A0 =A0A port may use this information in any way it so cho=
oses.
> > =A0 =A0 =A0 =A0For example, it could use this event to pre-load TLB
>=20
> Now the documentation no longer mentions what the 3rd parameter is us=
ed for?

I'm open to suggestions for a suitable description for it.

--=20
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:
