From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: [PATCH] scripts: unify system call table generation scripts
Date: Thu, 3 Jan 2019 13:33:36 +0100
Message-ID: <CAMuHMdV=Bv8+_4AOCv5s8b=Azn7eO+g_KBoSWw8DAunZmR_QiQ@mail.gmail.com>
References: <1546439331-18646-1-git-send-email-firoz.khan@linaro.org>
 <CALxhOnjz3Qd-a0OWMDV9ShfPOUB8gNB5Ltp9HGZi01mauaxkuw@mail.gmail.com> <CALxhOni1b0hS1a7EHFBkzcCx9cT-Z+jy4azrLcFveu6KG944jg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CALxhOni1b0hS1a7EHFBkzcCx9cT-Z+jy4azrLcFveu6KG944jg@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Firoz Khan <firoz.khan@linaro.org>
Cc: Paul Burton <paul.burton@mips.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Philippe Ombredanne <pombredanne@nexb.com>, Thomas Gleixner <tglx@linutronix.de>, Kate Stewart <kstewart@linuxfoundation.org>, Tony Luck <tony.luck@intel.com>, Helge Deller <deller@gmx.de>, Satheesh Rajendran <sathnaga@linux.vnet.ibm.com>, Michal Simek <monstr@monstr.eu>, Michael Ellerman <mpe@ellerman.id.au>, Richard Henderson <rth@twiddle.net>, Max Filippov <jcmvbkbc@gmail.com>, "David S . Miller" <davem@davemloft.net>, y2038 Mailman List <y2038@lists.linaro.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Linux-Arch <linux-arch@vger.kernel.org>, Arnd Bergmann <arnd@arndb.de>, Deepa Dinamani <deepa.kernel@gmail.com>, Marcin Juszkiewicz <marcin.juszki>
List-Id: linux-arch.vger.kernel.org

Hi Firoz,

On Thu, Jan 3, 2019 at 12:55 PM Firoz Khan <firoz.khan@linaro.org> wrote:
> On Thu, 3 Jan 2019 at 17:04, Firoz Khan <firoz.khan@linaro.org> wrote:
> > > +fileguard=_UAPI_ASM_`basename "$out" | sed \
> >
> > Currently, all but MIPS have the architecture name included in
> > the file guard.  Shouldn't that be retained?
>
> I was planning to do something similar to this:
> -fileguard=_UAPI_ASM_`basename "$out" | sed \
> +fileguard=_UAPI_ASM_${ARCH}_`basename "$out" | sed \
>
> But later I thought, the generated file will present inside arch
> directory (eg: arch/m68k/include/generated/uapi/asm/unistd.h).
> So Is that required to mention the architecture name in the file
> guard as it is generated inside the respective arch directory?

unistd_32.h is copied to /usr/include/asm/unistd_32.h by
"make headers_install", after which the architecture name is no longer present
in the path.

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
