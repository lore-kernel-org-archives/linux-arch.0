From: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=
	<u.kleine-koenig@pengutronix.de>
Subject: Re: [PATCH] ARM: avoid ARCH_MMAP_RND_BITS for NOMMU
Date: Mon, 7 Dec 2015 08:21:00 +0100
Message-ID: <20151207072100.GQ5072@pengutronix.de>
References: <2874133.c4GDUf0t6t@wuerfel>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <2874133.c4GDUf0t6t@wuerfel>
Sender: linux-kernel-owner@vger.kernel.org
To: Arnd Bergmann <arnd@arndb.de>
Cc: Andrew Morton <akpm@linux-foundation.org>, linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Daniel Cashman <dcashman@google.com>
List-Id: linux-arch.vger.kernel.org

On Fri, Nov 27, 2015 at 03:04:03PM +0100, Arnd Bergmann wrote:
> ARM kernels with MMU disabled fail to build because of CONFIG_ARCH_MM=
AP_RND_BITS:
>=20
> kernel/built-in.o:(.data+0x754): undefined reference to `mmap_rnd_bit=
s'
> kernel/built-in.o:(.data+0x76c): undefined reference to `mmap_rnd_bit=
s_min'
> kernel/built-in.o:(.data+0x770): undefined reference to `mmap_rnd_bit=
s_max'
>=20
> This changes the newly added line to only select this allow for
> MMU-enabled kernels.
>=20
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> Fixes: 14570b3fd31a ("arm: mm: support ARCH_MMAP_RND_BITS")
> ---
> Found on yesterday's linux-next with ARM randconfig. The commit that
> introduced this is currently in Andrew's tree.
>=20
> If you don't already have a fix, please either apply this patch on to=
p,
> or fold it into the original patch.
hmm, our autobuilder still fails on this one because there has been no
next release since some time. I hope the best for tomorrow's build :-)

Anyhow, it fixes the build for efm32_defconfig, so

Acked-by: Uwe Kleine-K=F6nig <u.kleine-koenig@pengutronix.de>

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig        =
    |
Industrial Linux Solutions                 | http://www.pengutronix.de/=
  |
