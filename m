From: Will Deacon <will.deacon@arm.com>
Subject: Re: [PATCH v2] arch: arm64: kernel: add '#ifdef CONFIG_COMPAT' for
 aarch32_break_handler()
Date: Mon, 24 Jun 2013 11:14:29 +0100
Message-ID: <20130624101429.GF23779@mudshark.cambridge.arm.com>
References: <51C53C06.7050205@asianux.com>
 <51C81115.4070803@asianux.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from cam-admin0.cambridge.arm.com ([217.140.96.50]:33749 "EHLO
	cam-admin0.cambridge.arm.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751592Ab3FXKPE (ORCPT
	<rfc822;linux-arch@vger.kernel.org>);
	Mon, 24 Jun 2013 06:15:04 -0400
Content-Disposition: inline
In-Reply-To: <51C81115.4070803@asianux.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Chen Gang <gang.chen@asianux.com>
Cc: Catalin Marinas <Catalin.Marinas@arm.com>, Tony Lindgren <tony@atomide.com>, "olof@lixom.net" <olof@lixom.net>, Santosh Shilimkar <santosh.shilimkar@ti.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Linux-Arch <linux-arch@vger.kernel.org>

On Mon, Jun 24, 2013 at 10:27:49AM +0100, Chen Gang wrote:
>=20
> If 'COMPAT' not defined, aarch32_break_handler() cannot pass compilin=
g,
> and it can work independent with 'COMPAT', so remove dummy definition=
=2E
>=20
> The related make:
>=20
>   make ARCH=3Darm64 randconfig
>   make ARCH=3Darm64 menuconfig
>   make ARCH=3Darm64 V=3D1 EXTRA_CFLAGS=3D-W

This sequence isn't really very useful, so I wouldn't bother including =
it in
the commit message. You can trigger this issue just by disabling
CONFIG_COMPAT.

> The related error:
>=20
>   arch/arm64/kernel/debug-monitors.c:249:5: error: redefinition of =E2=
=80=98aarch32_break_handler=E2=80=99
>   In file included from arch/arm64/kernel/debug-monitors.c:29:0:
>   /root/linux-next/arch/arm64/include/asm/debug-monitors.h:89:12: not=
e: previous definition of =E2=80=98aarch32_break_handler=E2=80=99 was h=
ere
>=20
>=20
>=20
> Signed-off-by: Chen Gang <gang.chen@asianux.com>
> ---
>  arch/arm64/include/asm/debug-monitors.h |    7 -------
>  1 files changed, 0 insertions(+), 7 deletions(-)
>=20
> diff --git a/arch/arm64/include/asm/debug-monitors.h b/arch/arm64/inc=
lude/asm/debug-monitors.h
> index ef8235c..a2232d0 100644
> --- a/arch/arm64/include/asm/debug-monitors.h
> +++ b/arch/arm64/include/asm/debug-monitors.h
> @@ -83,14 +83,7 @@ static inline int reinstall_suspended_bps(struct p=
t_regs *regs)
>  }
>  #endif
> =20
> -#ifdef CONFIG_COMPAT
>  int aarch32_break_handler(struct pt_regs *regs);
> -#else
> -static int aarch32_break_handler(struct pt_regs *regs)
> -{
> -	return -EFAULT;
> -}
> -#endif

Code looks fine to me:

  Acked-by: Will Deacon <will.deacon@arm.com>

Will
