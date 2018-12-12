From: Firoz Khan <firoz.khan@linaro.org>
Subject: Re: [PATCH v4 3/7] mips: rename macros and files from '64' to 'n64'
Date: Wed, 12 Dec 2018 10:04:47 +0530
Message-ID: <CALxhOngErLD7+CEhgSPwQUnGg7YEFTcH-v6dhR0j55SvEg1FoA@mail.gmail.com>
References: <1544073508-13720-1-git-send-email-firoz.khan@linaro.org>
 <1544073508-13720-4-git-send-email-firoz.khan@linaro.org> <20181210195144.dvprpyxyddusyb5c@pburton-laptop>
 <CALxhOng7EzAd2zHKAOj3ipEd6y=DpS2JGo34s4V_cWVgmLjPwg@mail.gmail.com> <20181211185947.gnaachztyh3ils7o@pburton-laptop>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20181211185947.gnaachztyh3ils7o@pburton-laptop>
Sender: linux-kernel-owner@vger.kernel.org
To: Paul Burton <paul.burton@mips.com>
Cc: linux-mips@vger.kernel.org, Ralf Baechle <ralf@linux-mips.org>, James Hogan <jhogan@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Philippe Ombredanne <pombredanne@nexb.com>, Thomas Gleixner <tglx@linutronix.de>, Kate Stewart <kstewart@linuxfoundation.org>, y2038 Mailman List <y2038@lists.linaro.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Linux-Arch <linux-arch@vger.kernel.org>, Arnd Bergmann <arnd@arndb.de>, Deepa Dinamani <deepa.kernel@gmail.com>, Marcin Juszkiewicz <marcin.juszkiewicz@linaro.org>
List-Id: linux-arch.vger.kernel.org

Hi Paul,

On Wed, 12 Dec 2018 at 00:29, Paul Burton <paul.burton@mips.com> wrote:
> > Will this below change will help?
> >
> >  #define _MIPS_SIM_ABI32              1
> >  #define _MIPS_SIM_NABI32            2
> >  #define _MIPS_SIM_ABI64              3
> > +#define _MIPS_SIM_ABIN64           _MIPS_SIM_ABI64
>
> Hmm, I think I'd prefer that we just keep using _MIPS_SIM_ABI64.

Sure, I think '64' to 'n64' conversion must be remove it from this patch
series.I can send v5 without '64' to 'n64' conversion.

If we rename '64' to 'n64' in half of the place and this _MIPS_SIM_ABI64
if we half to keep it in same looks not good (according to me).

(FYI, This macro name - _MIPS_SIM_ABIN64 must be _MIPS_SIM_NABI64
and defintion will be:
+#define _MIPS_SIM_NABI64           _MIPS_SIM_ABI64)

So If you confirm I can send v5 without '64' to 'n64' conversion (not just above
one, completely from this patch series). Or uou can take a call just
keep this macro -
_MIPS_SIM_ABI64 as it is and change it rest of the place.

Thanks
Firoz
