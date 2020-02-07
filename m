From: Leonardo Bras <leonardo@linux.ibm.com>
Subject: Re: [PATCH v6 04/11] powerpc/mce_power: Use functions to track
 lockless pgtbl walks
Date: Fri, 07 Feb 2020 01:00:53 -0300
Message-ID: <77e224d460d004fd918aae1b4e9237cd3a935f78.camel@linux.ibm.com>
References: <20200206030900.147032-1-leonardo@linux.ibm.com>
         <20200206030900.147032-5-leonardo@linux.ibm.com>
         <e8a5db5a-d1a5-ef25-af46-c44949750e8a@c-s.fr>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg="pgp-sha256";
        protocol="application/pgp-signature"; boundary="=-JGXt/RswUQhQyg+jmosY"
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:50112 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726674AbgBGEB6 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 6 Feb 2020 23:01:58 -0500
In-Reply-To: <e8a5db5a-d1a5-ef25-af46-c44949750e8a@c-s.fr>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Christophe Leroy <christophe.leroy@c-s.fr>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>, Arnd Bergmann <arnd@arndb.de>, Andrew Morton <akpm@linux-foundation.org>, "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>, Nicholas Piggin <npiggin@gmail.com>, Steven Price <steven.price@arm.com>, Robin Murphy <robin.murphy@arm.com>, Mahesh Salgaonkar <mahesh@linux.vnet.ibm.com>, Balbir Singh <bsingharora@gmail.com>, Reza Arbab <arbab@linux.ibm.com>, Thomas Gleixner <tglx@linutronix.de>, Allison Randal <allison@lohutok.net>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Mike Rapoport <rppt@linux.ibm.com>, Michal Suchanek <msuchanek@suse.de>
Cc: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org, kvm-ppc@vger.kernel.org, linux-arch@vger.kernel.org, linux-mm@kvack.org


--=-JGXt/RswUQhQyg+jmosY
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, 2020-02-06 at 06:48 +0100, Christophe Leroy wrote:
> > --- a/arch/powerpc/kernel/mce_power.c
> > +++ b/arch/powerpc/kernel/mce_power.c
> > @@ -29,7 +29,7 @@ unsigned long addr_to_pfn(struct pt_regs *regs, unsig=
ned long addr)
> >   {
> >   	pte_t *ptep;
> >   	unsigned int shift;
> > -	unsigned long pfn, flags;
> > +	unsigned long pfn, irq_mask;
>=20
> Why change the name ? flags is a well known historical name.

Oh, this commit missed the reasoning for flags name change.

For local_irq_{save,restore} a parameter named flags makes sense, for
the reader, as it could only be flags regarding irq.

I thougt passing flags to {begin,end}_lockless_pgtbl_walk would lose
it's meaning, given that it would only mean "flags for these functions"

So, changing it to irq_mask would make the reader more aware of what it
does mean.

For other commits, I added:

"Variable that saves the irq mask was renamed from flags to irq_mask so
it doesn't lose meaning now it's not directly passed to local_irq_*
functions."=20

I can add it to this commit message.

Thanks for the feedback,

Leonardo Bras




--=-JGXt/RswUQhQyg+jmosY
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEMdeUgIzgjf6YmUyOlQYWtz9SttQFAl484PUACgkQlQYWtz9S
ttQxfg//QLE5uOYft+0dYS7Fn7jA1rJi9M6IT4QpqXdPYxPpiXrXtosRdobLCfEd
FORoKWLRYuBXPWSR2Z7ZQsXUaJVLRF7bt04gatvV94xYzVE+1AKagv3PuKJoCL52
Utx9nThSXjTUkU3zj+7txmBpwRRpzbbG/phpT2mpOLk1f9gkKfK2XCXxY+aOFOqd
n/o6eU48rxmmnVKbri+LmKIPMt+XE32bwj/NnTBcODqdFX3g4c5NQycirWwq3NSj
DPiskun8O4jfT3K/QPDTS8TJnmumOPMNt30gk7bV5D4MR8oYkm67UHFwEEyGnSHS
Ch3ohT7PVg7FFaqXhqM6C+xVLQM425qXRB+0nKZBBRTf7EoADfSssc4yspcY7v37
Byyj0SYqT3Qp9JIv3pgEi60uwTqdWFqhMxaWxZodnpBhW2OwQp9WWYGzOJekTkR8
iY2StuZT2ytFfp+qWTstllNylY98iw33uYayicx1xgJ2Ni3ktGF7a72acOFfW93B
HiDGeEMgATvKGaDorxC3o8UpPIChZp946Y9RwZzqJAjLkEzeEd5yygYeStAny8UV
Z0bNwY4EuCdAiy07hPEhdpEdBPJzGrknLCGsejNBjNvWpOmDXi1RvX8kDRglW8Vo
fOMw6BbIDXPAxWgy1VxXkFJtJXRwaXsUbAlPmFRbd6QI3nLpcF0=
=db7A
-----END PGP SIGNATURE-----

--=-JGXt/RswUQhQyg+jmosY--
