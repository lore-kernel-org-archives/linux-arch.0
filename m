Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail-yb1-f194.google.com ([209.85.219.194]:43188 "EHLO
        mail-yb1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726512AbeJON3t (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 15 Oct 2018 09:29:49 -0400
Received: by mail-yb1-f194.google.com with SMTP id w80-v6so7041354ybe.10
        for <linux-arch@vger.kernel.org>; Sun, 14 Oct 2018 22:46:07 -0700 (PDT)
MIME-Version: 1.0
References: <1539337442-3676-1-git-send-email-firoz.khan@linaro.org>
 <c6280818c999449646ec216984f2df9e@sf-tec.de> <CALxhOngwHfFzCGXknF4_CHjD=4LeM8BnrZ+s-p6ZRcJ3G8i_RA@mail.gmail.com>
 <4517632.a0TFakfgol@daneel.sf-tec.de>
In-Reply-To: <4517632.a0TFakfgol@daneel.sf-tec.de>
From: Firoz Khan <firoz.khan@linaro.org>
Date: Mon, 15 Oct 2018 11:15:55 +0530
Message-ID: <CALxhOngEBVk771h5X5yV6ye23sPCyhxb=U36oJ6RrSDMB3vbyw@mail.gmail.com>
Subject: Re: [PATCH v4 3/6] parisc: add system call table generation support
Content-Type: text/plain; charset="UTF-8"
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Rolf Eike Beer <eike-kernel@sf-tec.de>
Cc: linux-parisc@vger.kernel.org, "James E . J . Bottomley" <jejb@parisc-linux.org>, Helge Deller <deller@gmx.de>, Thomas Gleixner <tglx@linutronix.de>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Philippe Ombredanne <pombredanne@nexb.com>, Kate Stewart <kstewart@linuxfoundation.org>, y2038 Mailman List <y2038@lists.linaro.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Linux-Arch <linux-arch@vger.kernel.org>, Arnd Bergmann <arnd@arndb.de>, Deepa Dinamani <deepa.kernel@gmail.com>, Marcin Juszkiewicz <marcin.juszkiewicz@linaro.org>, linux-parisc-owner@vger.kernel.org
Message-ID: <20181015054555.FbojqCpVl1PCVYppbYHyGi1oglaqFPPljaE44BI1UsI@z>

Hi Eike,

On Mon, 15 Oct 2018 at 10:47, Rolf Eike Beer <eike-kernel@sf-tec.de> wrote:
>
> Firoz Khan wrote:
> > Hi Rolf,
> >
> > On Fri, 12 Oct 2018 at 17:37, Rolf Eike Beer <eike-kernel@sf-tec.de> wrote:
> > > Firoz Khan wrote:
>
> > > > +prefix="$4"
> > > > +offset="$5"
> > > > +
> > > > +fileguard=_UAPI_ASM_PARISC_`basename "$out" | sed \
> > > > +    -e 'y/abcdefghijklmnopqrstuvwxyz/ABCDEFGHIJKLMNOPQRSTUVWXYZ/' \
> > > > +    -e 's/[^A-Z0-9_]/_/g' -e 's/__/_/g'`
> > > > +grep -E "^[0-9A-Fa-fXx]+[[:space:]]+${my_abis}" "$in" | sort -n | (
> > > > +    echo "#ifndef ${fileguard}"
> > > > +    echo "#define ${fileguard}"
> > > > +    echo ""
> > > > +
> > > > +    nxt=0
> > > > +    while read nr abi name entry compat ; do
> > > > +     if [ -z "$offset" ]; then
> > > > +         echo -e "#define __NR_${prefix}${name}\t$nr"
> > >
> > > This mixed indentation with both tabs and spaces is a bit messy.
> >
> > Is this what you suggested?
> > -           echo -e "#define __NR_${prefix}${name}\t$nr"
> > +           echo "#define __NR_${prefix}${name} $nr"
>
> No, this was actually only about the script itself. Looks like your editor has
> tab-width 8 and indentation 4 or so.

Ok. Something is going bad while creating the patch series. That's why this
mixed indentation with both tabs and spaces.Will fix now.

It will be ok to have indentation of 4 character?
https://github.com/torvalds/linux/blob/master/arch/x86/entry/syscalls/syscalltbl.sh
https://github.com/torvalds/linux/blob/master/arch/arm/tools/syscalltbl.sh

Thanks
Firoz
>
> Eike
