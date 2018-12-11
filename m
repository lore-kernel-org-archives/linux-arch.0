From: Paul Burton <paul.burton@mips.com>
Subject: Re: [PATCH v4 3/7] mips: rename macros and files from '64' to 'n64'
Date: Tue, 11 Dec 2018 18:59:49 +0000
Message-ID: <20181211185947.gnaachztyh3ils7o@pburton-laptop>
References: <1544073508-13720-1-git-send-email-firoz.khan@linaro.org>
 <1544073508-13720-4-git-send-email-firoz.khan@linaro.org>
 <20181210195144.dvprpyxyddusyb5c@pburton-laptop>
 <CALxhOng7EzAd2zHKAOj3ipEd6y=DpS2JGo34s4V_cWVgmLjPwg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CALxhOng7EzAd2zHKAOj3ipEd6y=DpS2JGo34s4V_cWVgmLjPwg@mail.gmail.com>
Content-Language: en-US
Content-ID: <B559AA0ECC8F3A43A0A5597C9EC3422C@namprd22.prod.outlook.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Firoz Khan <firoz.khan@linaro.org>
Cc: "linux-mips@vger.kernel.org" <linux-mips@vger.kernel.org>, Ralf Baechle <ralf@linux-mips.org>, James Hogan <jhogan@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Philippe Ombredanne <pombredanne@nexb.com>, Thomas Gleixner <tglx@linutronix.de>, Kate Stewart <kstewart@linuxfoundation.org>, y2038 Mailman List <y2038@lists.linaro.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Linux-Arch <linux-arch@vger.kernel.org>, Arnd Bergmann <arnd@arndb.de>, Deepa Dinamani <deepa.kernel@gmail.com>, Marcin Juszkiewicz <marcin.juszkiewicz@linaro.org>
List-Id: linux-arch.vger.kernel.org

Hi Firoz,

On Tue, Dec 11, 2018 at 02:15:19PM +0530, Firoz Khan wrote:
> > > diff --git a/arch/mips/include/uapi/asm/sgidefs.h b/arch/mips/include=
/uapi/asm/sgidefs.h
> > > index 26143e3..0364eec 100644
> > > --- a/arch/mips/include/uapi/asm/sgidefs.h
> > > +++ b/arch/mips/include/uapi/asm/sgidefs.h
> > > @@ -40,6 +40,6 @@
> > >   */
> > >  #define _MIPS_SIM_ABI32              1
> > >  #define _MIPS_SIM_NABI32     2
> > > -#define _MIPS_SIM_ABI64              3
> > > +#define _MIPS_SIM_ABIN64     3
> >
> > Whilst I agree with changing our own definitions & filenames to use n64=
,
> > this macro actually reflects naming used by the toolchain. ie:
> >
> >     $ mips-linux-gcc -mips64 -mabi=3D64 -dM -E - </dev/null | grep ABI6=
4
> >     #define _ABI64 3
> >     #define _MIPS_SIM _ABI64
> >
> > Our macro here is used to compare against _MIPS_SIM provided by the
> > toolchain, so for consistency I think we should keep the same name for
> > the macro that the toolchain uses.
>=20
> Will this below change will help?
>=20
>  #define _MIPS_SIM_ABI32              1
>  #define _MIPS_SIM_NABI32            2
>  #define _MIPS_SIM_ABI64              3
> +#define _MIPS_SIM_ABIN64           _MIPS_SIM_ABI64

Hmm, I think I'd prefer that we just keep using _MIPS_SIM_ABI64.

Side note - this snippet of code shows another inconsistency... we have
_MIPS_SIM_NABI32 whilst the toolchain uses _ABIN32... No need to worry
about that here though. In short let's leave _MIPS_SIM_* alone in this
series.

Thanks,
    Paul
