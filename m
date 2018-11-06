Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail-qt1-f196.google.com ([209.85.160.196]:38355 "EHLO
        mail-qt1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388029AbeKFXAD (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 6 Nov 2018 18:00:03 -0500
MIME-Version: 1.0
References: <1541080581-4072-1-git-send-email-firoz.khan@linaro.org>
 <1541080581-4072-5-git-send-email-firoz.khan@linaro.org> <CAMo8BfKaSUTMT0h2jRg2ysRnc2yvVT-3=-gq6pH-XpKm1iydQQ@mail.gmail.com>
In-Reply-To: <CAMo8BfKaSUTMT0h2jRg2ysRnc2yvVT-3=-gq6pH-XpKm1iydQQ@mail.gmail.com>
From: Arnd Bergmann <arnd@arndb.de>
Date: Tue, 6 Nov 2018 14:34:31 +0100
Message-ID: <CAK8P3a07Qtr3h0R83ec_7p6_tDxWtQ6qzUnAM=uR5RkGTkRkGQ@mail.gmail.com>
Subject: Re: [PATCH v1 4/4] xtensa: generate uapi header and syscall table
 header files
Content-Type: text/plain; charset="UTF-8"
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Max Filippov <jcmvbkbc@gmail.com>
Cc: Firoz Khan <firoz.khan@linaro.org>, Chris Zankel <chris@zankel.net>, linux-xtensa@linux-xtensa.org, gregkh <gregkh@linuxfoundation.org>, Philippe Ombredanne <pombredanne@nexb.com>, Thomas Gleixner <tglx@linutronix.de>, Kate Stewart <kstewart@linuxfoundation.org>, y2038 Mailman List <y2038@lists.linaro.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-arch <linux-arch@vger.kernel.org>, Deepa Dinamani <deepa.kernel@gmail.com>, Marcin Juszkiewicz <marcin.juszkiewicz@linaro.org>
Message-ID: <20181106133431.3acBLVTt2GnyMkwqdG-DRDa0WxylexMm2BoYPmKzqmE@z>

On Mon, Nov 5, 2018 at 10:44 PM Max Filippov <jcmvbkbc@gmail.com> wrote:
> On Thu, Nov 1, 2018 at 6:57 AM Firoz Khan <firoz.khan@linaro.org> wrote:
> > index 82c75643..b35d2e6 100644
> > --- a/arch/xtensa/include/asm/Kbuild
> > +++ b/arch/xtensa/include/asm/Kbuild
> > @@ -28,3 +28,4 @@ generic-y += topology.h
> >  generic-y += trace_clock.h
> >  generic-y += word-at-a-time.h
> >  generic-y += xor.h
> > +generic-y += syscall_table.h
>
> This doesn't look right: syscall_table.h is not asm-generic header.
>
> > diff --git a/arch/xtensa/include/uapi/asm/Kbuild b/arch/xtensa/include/uapi/asm/Kbuild
> > index 837d4dd..f826d52 100644
> > --- a/arch/xtensa/include/uapi/asm/Kbuild
> > +++ b/arch/xtensa/include/uapi/asm/Kbuild
> > @@ -11,3 +11,4 @@ generic-y += resource.h
> >  generic-y += siginfo.h
> >  generic-y += statfs.h
> >  generic-y += termios.h
> > +generic-y += unistd_32.h
>
> Ditto: unistd32_.h is not asm-generic header.

I think the correct syntax here would be

generated-y += unistd_32.h

Firoz, if I remember correctly, this came up before, maybe you just did
not update all architectures together?

        Arnd
