From: Paul Burton <paul.burton@mips.com>
Subject: Re: [PATCH v4 3/7] mips: rename macros and files from '64' to 'n64'
Date: Thu, 13 Dec 2018 20:15:41 +0000
Message-ID: <20181213201540.ae6pxtm2xmrxnaaa@pburton-laptop>
References: <1544073508-13720-1-git-send-email-firoz.khan@linaro.org>
 <1544073508-13720-4-git-send-email-firoz.khan@linaro.org>
 <20181210195144.dvprpyxyddusyb5c@pburton-laptop>
 <CALxhOng7EzAd2zHKAOj3ipEd6y=DpS2JGo34s4V_cWVgmLjPwg@mail.gmail.com>
 <20181211185947.gnaachztyh3ils7o@pburton-laptop>
 <CALxhOngErLD7+CEhgSPwQUnGg7YEFTcH-v6dhR0j55SvEg1FoA@mail.gmail.com>
 <20181212222834.2zf3rb67fxfcmwuw@pburton-laptop>
 <CALxhOnht8H6r38bwm7xqbHuJs6dvLB03GCKyws2cif1mEE+sKA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CALxhOnht8H6r38bwm7xqbHuJs6dvLB03GCKyws2cif1mEE+sKA@mail.gmail.com>
Content-Language: en-US
Content-ID: <49E9E6D96F297A4DB4F2CB168090837C@namprd22.prod.outlook.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Firoz Khan <firoz.khan@linaro.org>
Cc: "linux-mips@vger.kernel.org" <linux-mips@vger.kernel.org>, Ralf Baechle <ralf@linux-mips.org>, James Hogan <jhogan@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Philippe Ombredanne <pombredanne@nexb.com>, Thomas Gleixner <tglx@linutronix.de>, Kate Stewart <kstewart@linuxfoundation.org>, y2038 Mailman List <y2038@lists.linaro.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Linux-Arch <linux-arch@vger.kernel.org>, Arnd Bergmann <arnd@arndb.de>, Deepa Dinamani <deepa.kernel@gmail.com>, Marcin Juszkiewicz <marcin.juszkiewicz@linaro.org>
List-Id: linux-arch.vger.kernel.org

Hi Firoz,

On Thu, Dec 13, 2018 at 02:23:21PM +0530, Firoz Khan wrote:
> > > So If you confirm I can send v5 without '64' to 'n64' conversion (not=
 just above
> > > one, completely from this patch series). Or uou can take a call just
> > > keep this macro -
> > > _MIPS_SIM_ABI64 as it is and change it rest of the place.
> >
> > Let's just go ahead & leave everything as 64, and I'll do the 64 -> n64
> > rename later. I hoped whilst you were adding n64-specific code this
> > would be an easy change, but at this point let's just prioritize gettin=
g
> > the series applied without the naming change so it can sit in -next for
> > a while before the merge window.
>=20
> I'll keep the macro - _MIPS_SIM_ABI64 same and will not change the rest
> of the patch series. Unfortunately, reverting back to 64 from n64 has lot=
s of
> work.

I've applied v5 but undone the change from __NR_64_* to __NR_N64_*
because it's part of the UAPI & a github code search showed that it's
actually used.

Could you take a look at this branch & check that you're OK with it
before I push it to mips-next?

  git://git.kernel.org/pub/scm/linux/kernel/git/mips/linux.git test-syscall=
s

  https://git.kernel.org/pub/scm/linux/kernel/git/mips/linux.git/log/?h=3Dt=
est-syscalls

Thanks,
    Paul
