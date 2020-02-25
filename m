Return-Path: <SRS0=ZEfg=4N=vger.kernel.org=linux-arch-owner@kernel.org>
Received: from mail-wr1-f66.google.com ([209.85.221.66]:45592 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729994AbgBYLfQ (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 25 Feb 2020 06:35:16 -0500
Received: by mail-wr1-f66.google.com with SMTP id g3so14261919wrs.12
        for <linux-arch@vger.kernel.org>; Tue, 25 Feb 2020 03:35:13 -0800 (PST)
Subject: Re: [PATCH 00/10] Hi,
References: <cover.1581497860.git.michal.simek@xilinx.com>
From: Michal Simek <monstr@monstr.eu>
Message-ID: <bb01ba1d-49a4-6827-b2ef-18475cea18f7@monstr.eu>
Date: Tue, 25 Feb 2020 12:34:54 +0100
MIME-Version: 1.0
In-Reply-To: <cover.1581497860.git.michal.simek@xilinx.com>
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="LZHPN2jpshxJTPpehPN2oomZ5ViUkpu3G"
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Michal Simek <michal.simek@xilinx.com>, linux-kernel@vger.kernel.org, git@xilinx.com, arnd@arndb.de
Cc: Andrew Morton <akpm@linux-foundation.org>, "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>, Arvind Sankar <nivedita@alum.mit.edu>, Borislav Petkov <bp@suse.de>, Cornelia Huck <cohuck@redhat.com>, Geert Uytterhoeven <geert@linux-m68k.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Greg Ungerer <gerg@linux-m68k.org>, Heiko Carstens <heiko.carstens@de.ibm.com>, Kees Cook <keescook@chromium.org>, Masahiro Yamada <yamada.masahiro@socionext.com>, Mike Rapoport <rppt@linux.ibm.com>, Mubin Sayyed <mubinusm@xilinx.com>, Nicholas Piggin <npiggin@gmail.com>, Oleg Nesterov <oleg@redhat.com>, Palmer Dabbelt <palmer@dabbelt.com>, Paolo Bonzini <pbonzini@redhat.com>, Peter Zijlstra <peterz@infradead.org>, Randy Dunlap <rdunlap@infradead.org>, Rob Herring <robh@kernel.org>, Shubhrajyoti Datta <shubhrajyoti.datta@xilinx.com>, Siva Durga Prasad Paladugu <siva.durga.paladugu@xilinx.com>, Stefan Asserhall <stefan.asserhall@xilinx.com>, Vladimir Murzin <vladimir.murzin@arm.com>, Will Deacon <will@kernel.org>, linux-arch@vger.kernel.org, linux-mm@kvack.org
Message-ID: <20200225113454.lexIyzyYhiNZYknMMl7sOKfZmqw1FM14qC3lqCQHbsU@z>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--LZHPN2jpshxJTPpehPN2oomZ5ViUkpu3G
Content-Type: multipart/mixed; boundary="c2rUlmsk1qexDFpBjgpaV7Nn62sVlDOPV";
 protected-headers="v1"
From: Michal Simek <monstr@monstr.eu>
To: Michal Simek <michal.simek@xilinx.com>, linux-kernel@vger.kernel.org,
 git@xilinx.com, arnd@arndb.de
Cc: Andrew Morton <akpm@linux-foundation.org>,
 "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>,
 Arvind Sankar <nivedita@alum.mit.edu>, Borislav Petkov <bp@suse.de>,
 Cornelia Huck <cohuck@redhat.com>, Geert Uytterhoeven
 <geert@linux-m68k.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Greg Ungerer <gerg@linux-m68k.org>,
 Heiko Carstens <heiko.carstens@de.ibm.com>, Kees Cook
 <keescook@chromium.org>, Masahiro Yamada <yamada.masahiro@socionext.com>,
 Mike Rapoport <rppt@linux.ibm.com>, Mubin Sayyed <mubinusm@xilinx.com>,
 Nicholas Piggin <npiggin@gmail.com>, Oleg Nesterov <oleg@redhat.com>,
 Palmer Dabbelt <palmer@dabbelt.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Peter Zijlstra <peterz@infradead.org>, Randy Dunlap <rdunlap@infradead.org>,
 Rob Herring <robh@kernel.org>,
 Shubhrajyoti Datta <shubhrajyoti.datta@xilinx.com>,
 Siva Durga Prasad Paladugu <siva.durga.paladugu@xilinx.com>,
 Stefan Asserhall <stefan.asserhall@xilinx.com>,
 Vladimir Murzin <vladimir.murzin@arm.com>, Will Deacon <will@kernel.org>,
 linux-arch@vger.kernel.org, linux-mm@kvack.org
Message-ID: <bb01ba1d-49a4-6827-b2ef-18475cea18f7@monstr.eu>
Subject: Re: [PATCH 00/10] Hi,
References: <cover.1581497860.git.michal.simek@xilinx.com>
In-Reply-To: <cover.1581497860.git.michal.simek@xilinx.com>

--c2rUlmsk1qexDFpBjgpaV7Nn62sVlDOPV
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 12. 02. 20 9:57, Michal Simek wrote:
>=20
> I am sending this series as before SMP support.
> Most of these patches are clean ups and should be easy to review them. =
I
> expect there will be more discussions about SMP support.
>=20
> There could be some optimization added based on
> https://lkml.org/lkml/2020/2/10/1528
>=20
> Thanks,
> Michal
>=20
>=20
> Michal Simek (6):
>   microblaze: Convert headers to SPDX license
>   microblaze: Remove architecture tlb.h and use generic one
>   microblaze: Remove early printk setup
>   microblaze: Remove empty headers
>   microblaze: Remove unused boot_cpuid variable
>   microblaze: Use asm generic cmpxchg.h for !SMP case
>=20
> Stefan Asserhall (4):
>   microblaze: Define microblaze barrier
>   microblaze: Add sync to tlb operations
>   microblaze: Add missing irqflags.h header
>   microblaze: Define percpu sestion in linker file
>=20
>  arch/microblaze/include/asm/Kbuild            |  4 +-
>  arch/microblaze/include/asm/barrier.h         | 13 ++++++
>  arch/microblaze/include/asm/cache.h           |  5 +--
>  arch/microblaze/include/asm/cacheflush.h      |  6 +--
>  arch/microblaze/include/asm/checksum.h        |  5 +--
>  arch/microblaze/include/asm/cmpxchg.h         | 40 ++-----------------=

>  arch/microblaze/include/asm/cpuinfo.h         |  5 +--
>  arch/microblaze/include/asm/cputable.h        |  1 -
>  arch/microblaze/include/asm/current.h         |  5 +--
>  arch/microblaze/include/asm/delay.h           |  7 +---
>  arch/microblaze/include/asm/dma.h             |  5 +--
>  arch/microblaze/include/asm/elf.h             |  5 +--
>  arch/microblaze/include/asm/entry.h           |  5 +--
>  arch/microblaze/include/asm/exceptions.h      |  5 +--
>  arch/microblaze/include/asm/fixmap.h          |  5 +--
>  arch/microblaze/include/asm/flat.h            |  5 +--
>  arch/microblaze/include/asm/hw_irq.h          |  1 -
>  arch/microblaze/include/asm/io.h              |  5 +--
>  arch/microblaze/include/asm/irq.h             |  5 +--
>  arch/microblaze/include/asm/irqflags.h        |  5 +--
>  arch/microblaze/include/asm/mmu.h             |  5 +--
>  arch/microblaze/include/asm/mmu_context_mm.h  |  5 +--
>  arch/microblaze/include/asm/module.h          |  5 +--
>  arch/microblaze/include/asm/page.h            |  5 +--
>  arch/microblaze/include/asm/pgalloc.h         |  5 +--
>  arch/microblaze/include/asm/pgtable.h         |  5 +--
>  arch/microblaze/include/asm/processor.h       |  5 +--
>  arch/microblaze/include/asm/ptrace.h          |  5 +--
>  arch/microblaze/include/asm/pvr.h             |  5 +--
>  arch/microblaze/include/asm/registers.h       |  5 +--
>  arch/microblaze/include/asm/sections.h        |  5 +--
>  arch/microblaze/include/asm/setup.h           |  7 +---
>  arch/microblaze/include/asm/string.h          |  5 +--
>  arch/microblaze/include/asm/switch_to.h       |  5 +--
>  arch/microblaze/include/asm/thread_info.h     |  5 +--
>  arch/microblaze/include/asm/timex.h           |  5 +--
>  arch/microblaze/include/asm/tlb.h             | 17 --------
>  arch/microblaze/include/asm/tlbflush.h        |  5 +--
>  arch/microblaze/include/asm/uaccess.h         |  5 +--
>  arch/microblaze/include/asm/unaligned.h       |  5 +--
>  arch/microblaze/include/asm/unistd.h          |  5 +--
>  arch/microblaze/include/asm/unwind.h          |  5 +--
>  arch/microblaze/include/asm/user.h            |  1 -
>  arch/microblaze/kernel/cpu/cpuinfo-pvr-full.c |  7 +---
>  arch/microblaze/kernel/cpu/pvr.c              |  1 +
>  arch/microblaze/kernel/misc.S                 |  3 +-
>  arch/microblaze/kernel/setup.c                |  1 -
>  arch/microblaze/kernel/vmlinux.lds.S          |  3 ++
>  48 files changed, 62 insertions(+), 215 deletions(-)
>  create mode 100644 arch/microblaze/include/asm/barrier.h
>  delete mode 100644 arch/microblaze/include/asm/cputable.h
>  delete mode 100644 arch/microblaze/include/asm/hw_irq.h
>  delete mode 100644 arch/microblaze/include/asm/tlb.h
>  delete mode 100644 arch/microblaze/include/asm/user.h
>=20

applied all.
M

--=20
Michal Simek, Ing. (M.Eng), OpenPGP -> KeyID: FE3D1F91
w: www.monstr.eu p: +42-0-721842854
Maintainer of Linux kernel - Xilinx Microblaze
Maintainer of Linux kernel - Xilinx Zynq ARM and ZynqMP ARM64 SoCs
U-Boot custodian - Xilinx Microblaze/Zynq/ZynqMP/Versal SoCs



--c2rUlmsk1qexDFpBjgpaV7Nn62sVlDOPV--

--LZHPN2jpshxJTPpehPN2oomZ5ViUkpu3G
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EARECAB0WIQQbPNTMvXmYlBPRwx7KSWXLKUoMIQUCXlUGXwAKCRDKSWXLKUoM
IWakAKCB1Nf50wQlkY3QmenLnoFwU1bVRQCfXM644R24pTsD+kEK+7AWWzPDUeE=
=6NRI
-----END PGP SIGNATURE-----

--LZHPN2jpshxJTPpehPN2oomZ5ViUkpu3G--
