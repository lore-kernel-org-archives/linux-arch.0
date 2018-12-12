From: Paul Burton <paul.burton@mips.com>
Subject: Re: [PATCH v4 3/7] mips: rename macros and files from '64' to 'n64'
Date: Wed, 12 Dec 2018 22:28:35 +0000
Message-ID: <20181212222834.2zf3rb67fxfcmwuw@pburton-laptop>
References: <1544073508-13720-1-git-send-email-firoz.khan@linaro.org>
 <1544073508-13720-4-git-send-email-firoz.khan@linaro.org>
 <20181210195144.dvprpyxyddusyb5c@pburton-laptop>
 <CALxhOng7EzAd2zHKAOj3ipEd6y=DpS2JGo34s4V_cWVgmLjPwg@mail.gmail.com>
 <20181211185947.gnaachztyh3ils7o@pburton-laptop>
 <CALxhOngErLD7+CEhgSPwQUnGg7YEFTcH-v6dhR0j55SvEg1FoA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CALxhOngErLD7+CEhgSPwQUnGg7YEFTcH-v6dhR0j55SvEg1FoA@mail.gmail.com>
Content-Language: en-US
Content-ID: <0EE10DEB37FD5141B5FE9B65B9446384@namprd22.prod.outlook.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Firoz Khan <firoz.khan@linaro.org>
Cc: "linux-mips@vger.kernel.org" <linux-mips@vger.kernel.org>, Ralf Baechle <ralf@linux-mips.org>, James Hogan <jhogan@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Philippe Ombredanne <pombredanne@nexb.com>, Thomas Gleixner <tglx@linutronix.de>, Kate Stewart <kstewart@linuxfoundation.org>, y2038 Mailman List <y2038@lists.linaro.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Linux-Arch <linux-arch@vger.kernel.org>, Arnd Bergmann <arnd@arndb.de>, Deepa Dinamani <deepa.kernel@gmail.com>, Marcin Juszkiewicz <marcin.juszkiewicz@linaro.org>
List-Id: linux-arch.vger.kernel.org

Hi Firoz,

On Wed, Dec 12, 2018 at 10:04:47AM +0530, Firoz Khan wrote:
> > > Will this below change will help?
> > >
> > >  #define _MIPS_SIM_ABI32              1
> > >  #define _MIPS_SIM_NABI32            2
> > >  #define _MIPS_SIM_ABI64              3
> > > +#define _MIPS_SIM_ABIN64           _MIPS_SIM_ABI64
> >
> > Hmm, I think I'd prefer that we just keep using _MIPS_SIM_ABI64.
>=20
> Sure, I think '64' to 'n64' conversion must be remove it from this patch
> series.I can send v5 without '64' to 'n64' conversion.
>=20
> If we rename '64' to 'n64' in half of the place and this _MIPS_SIM_ABI64
> if we half to keep it in same looks not good (according to me).
>=20
> (FYI, This macro name - _MIPS_SIM_ABIN64 must be _MIPS_SIM_NABI64
> and defintion will be:
> +#define _MIPS_SIM_NABI64           _MIPS_SIM_ABI64)
>=20
> So If you confirm I can send v5 without '64' to 'n64' conversion (not jus=
t above
> one, completely from this patch series). Or uou can take a call just
> keep this macro -
> _MIPS_SIM_ABI64 as it is and change it rest of the place.

Let's just go ahead & leave everything as 64, and I'll do the 64 -> n64
rename later. I hoped whilst you were adding n64-specific code this
would be an easy change, but at this point let's just prioritize getting
the series applied without the naming change so it can sit in -next for
a while before the merge window.

Thanks,
    Paul
