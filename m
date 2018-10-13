From: Firoz Khan <firoz.khan@linaro.org>
Subject: Re: [PATCH v4 5/6] parisc: wire up rseq system call
Date: Sat, 13 Oct 2018 11:12:12 +0530
Message-ID: <CALxhOniSbukoQYFzeLmWyD9tYE7Bgye6iq1O+fovvi1_G+56-Q@mail.gmail.com>
References: <1539337442-3676-1-git-send-email-firoz.khan@linaro.org>
 <1539337442-3676-6-git-send-email-firoz.khan@linaro.org> <CAK8P3a1gsuM7mBGm9hx-BTs=HAG3cSjB6M7N-kpMmPy3kixeCQ@mail.gmail.com>
 <CALxhOnhj7qUj57tLX12KmbcE5G-zDK2Qf2fTUbQ=jpmiUcr52w@mail.gmail.com>
 <CAK8P3a3BjuLQh0hTPFTDTkipXXQ+j8ADqbWmNpimkMDzoORkRA@mail.gmail.com> <71ea9dc5-7502-40af-2022-b2196dd2d690@gmx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <71ea9dc5-7502-40af-2022-b2196dd2d690@gmx.de>
Sender: linux-kernel-owner@vger.kernel.org
To: Helge Deller <deller@gmx.de>
Cc: Arnd Bergmann <arnd@arndb.de>, linux-parisc@vger.kernel.org, "James E . J . Bottomley" <jejb@parisc-linux.org>, Thomas Gleixner <tglx@linutronix.de>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Philippe Ombredanne <pombredanne@nexb.com>, Kate Stewart <kstewart@linuxfoundation.org>, y2038 Mailman List <y2038@lists.linaro.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Linux-Arch <linux-arch@vger.kernel.org>, Deepa Dinamani <deepa.kernel@gmail.com>, Marcin Juszkiewicz <marcin.juszkiewicz@linaro.org>
List-Id: linux-arch.vger.kernel.org

Hi Arnd, Helge,

On Sat, 13 Oct 2018 at 01:53, Helge Deller <deller@gmx.de> wrote:
>
> On 12.10.2018 13:52, Arnd Bergmann wrote:
> > On Fri, Oct 12, 2018 at 12:16 PM Firoz Khan <firoz.khan@linaro.org> wrote:
> >>
> >> Hi Arnd,
> >>
> >> On Fri, 12 Oct 2018 at 15:26, Arnd Bergmann <arnd@arndb.de> wrote:
> >>>
> >>> On Fri, Oct 12, 2018 at 11:45 AM Firoz Khan <firoz.khan@linaro.org> wrote:
> >>>>
> >>>> Wire up rseq system call requires an architecture specific
> >>>> implementation as it not present now.
> >>>>
> >>>> Signed-off-by: Firoz Khan <firoz.khan@linaro.org>
> >>>
> >>> Didn't we conclude that this should be skipped?
> >>
> >> Helge told "I prefer to keep the warning for rseq for now.
> >> It reminds me that we still may want the rseq syscall.
> >> If the warning is a problem, you may simply add the __IGNORE_rseq define."
> >>
> >> I chose this option; I feel it looks clean
> >> "# rseq requires an architecture specific implementation" in syscall.tbl
> >> hopefully remind him to add rseq syscall implementation in this architecture.
> >
> > But he said he wants the warning instead.
>
> Correct.
> Firoz, please simply drop this patch completely.
> That way one will see generated warnings about the missing rseq (which is what
> we want).

Sure. will do!

Firoz

>
> Thanks,
> Helge
