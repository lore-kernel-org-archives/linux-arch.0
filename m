From: Nicholas Piggin <npiggin@gmail.com>
Subject: Re: [PATCH 3/3] mm: optimise pte dirty/accessed bit setting by
 demand based pte insertion
Date: Thu, 6 Sep 2018 08:18:02 +1000
Message-ID: <20180906081802.210984d7@roar.ozlabs.ibm.com>
References: <20180828112034.30875-1-npiggin@gmail.com>
        <20180828112034.30875-4-npiggin@gmail.com>
        <20180905142951.GA15680@roeck-us.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180905142951.GA15680@roeck-us.net>
Sender: linux-kernel-owner@vger.kernel.org
To: Guenter Roeck <linux@roeck-us.net>
Cc: linux-mm@kvack.org, linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, Andrew Morton <akpm@linux-foundation.org>, Linus Torvalds <torvalds@linux-foundation.org>, Ley Foon Tan <lftan@altera.com>, nios2-dev@lists.rocketboards.org
List-Id: linux-arch.vger.kernel.org

On Wed, 5 Sep 2018 07:29:51 -0700
Guenter Roeck <linux@roeck-us.net> wrote:

> Hi,
>=20
> On Tue, Aug 28, 2018 at 09:20:34PM +1000, Nicholas Piggin wrote:
> > Similarly to the previous patch, this tries to optimise dirty/accessed
> > bits in ptes to avoid access costs of hardware setting them.
> >  =20
>=20
> This patch results in silent nios2 boot failures, silent meaning that
> the boot stalls.
>=20
> ...
> Unpacking initramfs...
> Freeing initrd memory: 2168K
> workingset: timestamp_bits=3D30 max_order=3D15 bucket_order=3D0
> jffs2: version 2.2. (NAND) =C2=A9 2001-2006 Red Hat, Inc.
> random: fast init done
> random: crng init done
>=20
> [no further activity until the qemu session is aborted]
>=20
> Reverting the patch fixes the problem. Bisect log is attached.

Thanks for bisecting it, I'll try to reproduce. Just qemu with no
obscure options? Interesting that it's hit nios2 but apparently not
other archs (yet).

Thanks,
Nick
