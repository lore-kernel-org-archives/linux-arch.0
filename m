From: Chen Gang <gang.chen@asianux.com>
Subject: Re: [PATCH v2] arch: arm64: kernel: add '#ifdef CONFIG_COMPAT' for
 aarch32_break_handler()
Date: Mon, 24 Jun 2013 18:16:08 +0800
Message-ID: <51C81C68.5080101@asianux.com>
References: <51C53C06.7050205@asianux.com> <51C81115.4070803@asianux.com> <20130624101429.GF23779@mudshark.cambridge.arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from intranet.asianux.com ([58.214.24.6]:43150 "EHLO
	intranet.asianux.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752023Ab3FXKRA (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Mon, 24 Jun 2013 06:17:00 -0400
In-Reply-To: <20130624101429.GF23779@mudshark.cambridge.arm.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Will Deacon <will.deacon@arm.com>
Cc: Catalin Marinas <Catalin.Marinas@arm.com>, Tony Lindgren <tony@atomide.com>, "olof@lixom.net" <olof@lixom.net>, Santosh Shilimkar <santosh.shilimkar@ti.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Linux-Arch <linux-arch@vger.kernel.org>

On 06/24/2013 06:14 PM, Will Deacon wrote:
> On Mon, Jun 24, 2013 at 10:27:49AM +0100, Chen Gang wrote:
>> >=20
>> > If 'COMPAT' not defined, aarch32_break_handler() cannot pass compi=
ling,
>> > and it can work independent with 'COMPAT', so remove dummy definit=
ion.
>> >=20
>> > The related make:
>> >=20
>> >   make ARCH=3Darm64 randconfig
>> >   make ARCH=3Darm64 menuconfig
>> >   make ARCH=3Darm64 V=3D1 EXTRA_CFLAGS=3D-W
> This sequence isn't really very useful, so I wouldn't bother includin=
g it in
> the commit message. You can trigger this issue just by disabling
> CONFIG_COMPAT.
>=20

OK, thanks. Next time, I need notice about it.

>> > The related error:
>> >=20
>> >   arch/arm64/kernel/debug-monitors.c:249:5: error: redefinition of=
 =E2=80=98aarch32_break_handler=E2=80=99
>> >   In file included from arch/arm64/kernel/debug-monitors.c:29:0:
>> >   /root/linux-next/arch/arm64/include/asm/debug-monitors.h:89:12: =
note: previous definition of =E2=80=98aarch32_break_handler=E2=80=99 wa=
s here
>> >=20
>> >=20
>> >=20
>> > Signed-off-by: Chen Gang <gang.chen@asianux.com>
>> > ---
>> >  arch/arm64/include/asm/debug-monitors.h |    7 -------
>> >  1 files changed, 0 insertions(+), 7 deletions(-)
>> >=20
>> > diff --git a/arch/arm64/include/asm/debug-monitors.h b/arch/arm64/=
include/asm/debug-monitors.h
>> > index ef8235c..a2232d0 100644
>> > --- a/arch/arm64/include/asm/debug-monitors.h
>> > +++ b/arch/arm64/include/asm/debug-monitors.h
>> > @@ -83,14 +83,7 @@ static inline int reinstall_suspended_bps(struc=
t pt_regs *regs)
>> >  }
>> >  #endif
>> > =20
>> > -#ifdef CONFIG_COMPAT
>> >  int aarch32_break_handler(struct pt_regs *regs);
>> > -#else
>> > -static int aarch32_break_handler(struct pt_regs *regs)
>> > -{
>> > -	return -EFAULT;
>> > -}
>> > -#endif
> Code looks fine to me:
>=20
>   Acked-by: Will Deacon <will.deacon@arm.com>

Thanks.

--=20
Chen Gang

Asianux Corporation
