From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [x86] BUG()/BUG_ON() macros cannot be disabled
Date: Tue, 25 Sep 2018 14:20:49 +0200
Message-ID: <CAK8P3a2to1LbSNizeSHE3vHaCtp5PSrVFAzy5X2mE49x3tPbxg@mail.gmail.com>
References: <9516e4b3-f9f2-b150-f019-8b1ef465efb3@tu-dortmund.de>
 <CAK8P3a1sO9HtJPo0S=s3MFK4TN0s_raNTWRTYCYBTGiyHuXg_A@mail.gmail.com> <649d3c5c-3d96-0ed3-cd4d-57641f0ee614@tu-dortmund.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <649d3c5c-3d96-0ed3-cd4d-57641f0ee614@tu-dortmund.de>
Sender: linux-kernel-owner@vger.kernel.org
To: alexander.lochmann@tu-dortmund.de
Cc: linux-arch <linux-arch@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
List-Id: linux-arch.vger.kernel.org

On Tue, Sep 25, 2018 at 2:13 PM Alexander Lochmann
<alexander.lochmann@tu-dortmund.de> wrote:
>
>
>
> Am 25.09.2018 um 14:06 schrieb Arnd Bergmann:
> > On Tue, Sep 25, 2018 at 1:35 PM Alexander Lochmann
> > <alexander.lochmann@tu-dortmund.de> wrote:
> >>
> >> Hi Arnd,
> >>
> >> I recently tried to disable the BUG macros on x86-32. I disabled the
> >> config item in 'General Setup -> Configure standard kernel features
> >> (expert users) -> BUG() support'.
> >> However, BUG/BUG_ON is still defined. In the !CONFIG_BUG branch in
> >> include/asm-generic/bug.h (line 181) the code checks for the existence
> >> of architecture-specific variants of those macros.
> >> Since x86 defines its own version of BUG(), line 182 is *not* used.
> >> In the following, the x86 variant of BUG() is then used to define the
> >> BUG_ON() macro.
> >>
> >> I propose a patch that really disables both macros if the developer
> >> wants it.
> >> It undefines the respective x86 variants, and defines both macros as
> >> 'empty' macros.
> >
> > Maybe we should update the documentation instead. Note that the
> > generic version is using 'while (1)' rather than 'while (0)', so this is
> > not an empty macro but rather one that does more than the
> > arch-specific one-instruction version does.
> >
> > We don't really want an empty macro any more, this was used in
> > the past, but causes compile-time warnings and undefined behavior
> > for no good reason
> I see. So the documentation of the CONFIG_BUG option is wrong?
> It currently states that 'Disabling this option eliminates support for
> BUG and WARN'.
> Is the current implemention (an endless loop) desired behavior?

I think it's the most reasonable implementation, otherwise a
function like

int something(void)
{
      if (x)
         return 0;
     else
          BUG();
}

will return an uninitialized value.

The arch specific implementations usually just contain a trapping
instruction. With CONFIG_BUG() you get a nice console output
that indicates where this happened, but without CONFIG_BUG(),
this is just reported as an invalid instruction (if CONFIG_PRINTK
is still enabled), killing the current process.

       Arnd
