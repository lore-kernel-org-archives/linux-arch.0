Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail-it1-f195.google.com ([209.85.166.195]:53654 "EHLO
        mail-it1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387593AbeKGAiQ (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 6 Nov 2018 19:38:16 -0500
Received: by mail-it1-f195.google.com with SMTP id r12-v6so15489486ita.3
        for <linux-arch@vger.kernel.org>; Tue, 06 Nov 2018 07:12:35 -0800 (PST)
MIME-Version: 1.0
References: <1541080581-4072-1-git-send-email-firoz.khan@linaro.org>
 <1541080581-4072-5-git-send-email-firoz.khan@linaro.org> <CAMo8BfKaSUTMT0h2jRg2ysRnc2yvVT-3=-gq6pH-XpKm1iydQQ@mail.gmail.com>
 <CAK8P3a07Qtr3h0R83ec_7p6_tDxWtQ6qzUnAM=uR5RkGTkRkGQ@mail.gmail.com>
In-Reply-To: <CAK8P3a07Qtr3h0R83ec_7p6_tDxWtQ6qzUnAM=uR5RkGTkRkGQ@mail.gmail.com>
From: Firoz Khan <firoz.khan@linaro.org>
Date: Tue, 6 Nov 2018 20:42:24 +0530
Message-ID: <CALxhOnhN=erC=KpE55PHPx9u45QiAU+yxhGHZXGJ_7pV0a_=NQ@mail.gmail.com>
Subject: Re: [PATCH v1 4/4] xtensa: generate uapi header and syscall table
 header files
Content-Type: text/plain; charset="UTF-8"
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Arnd Bergmann <arnd@arndb.de>
Cc: Max Filippov <jcmvbkbc@gmail.com>, Chris Zankel <chris@zankel.net>, linux-xtensa@linux-xtensa.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Philippe Ombredanne <pombredanne@nexb.com>, Thomas Gleixner <tglx@linutronix.de>, Kate Stewart <kstewart@linuxfoundation.org>, y2038 Mailman List <y2038@lists.linaro.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Linux-Arch <linux-arch@vger.kernel.org>, Deepa Dinamani <deepa.kernel@gmail.com>, Marcin Juszkiewicz <marcin.juszkiewicz@linaro.org>
Message-ID: <20181106151224.qKRQvLq5YM_SCS0qZvQtqWPtxgU3_7wKl7bXMYuP-ko@z>

Hi Arnd,

On Tue, 6 Nov 2018 at 19:04, Arnd Bergmann <arnd@arndb.de> wrote:
>
> On Mon, Nov 5, 2018 at 10:44 PM Max Filippov <jcmvbkbc@gmail.com> wrote:
> > On Thu, Nov 1, 2018 at 6:57 AM Firoz Khan <firoz.khan@linaro.org> wrote:
> > > index 82c75643..b35d2e6 100644
> > > --- a/arch/xtensa/include/asm/Kbuild
> > > +++ b/arch/xtensa/include/asm/Kbuild
> > > @@ -28,3 +28,4 @@ generic-y += topology.h
> > >  generic-y += trace_clock.h
> > >  generic-y += word-at-a-time.h
> > >  generic-y += xor.h
> > > +generic-y += syscall_table.h
> >
> > This doesn't look right: syscall_table.h is not asm-generic header.
> >
> > > diff --git a/arch/xtensa/include/uapi/asm/Kbuild b/arch/xtensa/include/uapi/asm/Kbuild
> > > index 837d4dd..f826d52 100644
> > > --- a/arch/xtensa/include/uapi/asm/Kbuild
> > > +++ b/arch/xtensa/include/uapi/asm/Kbuild
> > > @@ -11,3 +11,4 @@ generic-y += resource.h
> > >  generic-y += siginfo.h
> > >  generic-y += statfs.h
> > >  generic-y += termios.h
> > > +generic-y += unistd_32.h
> >
> > Ditto: unistd32_.h is not asm-generic header.
>
> I think the correct syntax here would be
>
> generated-y += unistd_32.h
>
> Firoz, if I remember correctly, this came up before, maybe you just did
> not update all architectures together?

My initial patches does have generated-y += unistd_32.h instead of
generic-y += unistd_32.h.
If I remember someone pointed out that this implementation doesn't
look good. So I
replaced to generic-y += unistd_32.h.

Sure, I'll change to generated-y += unistd_32.h instead of generic-y
+= unistd_32.h.

Max, this looks ok. right?

Thanks
Firoz


>
>         Arnd
