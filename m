From: Nadav Amit <nadav.amit@gmail.com>
Subject: Re: [PATCHv2 1/3] x86/mm: Provide pmdp_establish() helper
Date: Mon, 19 Jun 2017 10:11:35 -0700
Message-ID: <D16802A9-161A-4074-A2C6-DCEA73E2E608@gmail.com>
References: <20170615145224.66200-1-kirill.shutemov@linux.intel.com>
 <20170615145224.66200-2-kirill.shutemov@linux.intel.com>
Mime-Version: 1.0 (Mac OS X Mail 10.3 \(3273\))
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mail-pg0-f66.google.com ([74.125.83.66]:36379 "EHLO
        mail-pg0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750844AbdFSRLj (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 19 Jun 2017 13:11:39 -0400
In-Reply-To: <20170615145224.66200-2-kirill.shutemov@linux.intel.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, Vlastimil Babka <vbabka@suse.cz>, Vineet Gupta <vgupta@synopsys.com>, Russell King <linux@armlinux.org.uk>, Will Deacon <will.deacon@arm.com>, Catalin Marinas <catalin.marinas@arm.com>, Ralf Baechle <ralf@linux-mips.org>, "David S. Miller" <davem@davemloft.net>, "Aneesh Kumar K . V" <aneesh.kumar@linux.vnet.ibm.com>, Martin Schwidefsky <schwidefsky@de.ibm.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, Andrea Arcangeli <aarcange@redhat.com>, linux-arch@vger.kernel.org, linux-mm@kvack.org, linux-kernel@vger.kernel.org, Ingo Molnar <mingo@kernel.org>, "H . Peter Anvin" <hpa@zytor.com>, Thomas Gleixner <tglx@linutronix.de>

Kirill A. Shutemov <kirill.shutemov@linux.intel.com> wrote:

> We need an atomic way to setup pmd page table entry, avoiding races =
with
> CPU setting dirty/accessed bits. This is required to implement
> pmdp_invalidate() that doesn't loose these bits.
>=20
> On PAE we have to use cmpxchg8b as we cannot assume what is value of =
new pmd and
> setting it up half-by-half can expose broken corrupted entry to CPU.

...

>=20
> +#ifndef pmdp_establish
> +#define pmdp_establish pmdp_establish
> +static inline pmd_t pmdp_establish(pmd_t *pmdp, pmd_t pmd)
> +{
> +	if (IS_ENABLED(CONFIG_SMP)) {
> +		return xchg(pmdp, pmd);
> +	} else {
> +		pmd_t old =3D *pmdp;
> +		*pmdp =3D pmd;

I think you may want to use WRITE_ONCE() here - otherwise nobody =
guarantees
that the compiler will not split writes to *pmdp. Although the kernel =
uses
similar code to setting PTEs and PMDs, I think that it is best to start
fixing it. Obviously, you might need a different code path for 32-bit
kernels.

Regards,
Nadav=
