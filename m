Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail-it1-f195.google.com ([209.85.166.195]:38966 "EHLO
        mail-it1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727300AbeKPP6w (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 16 Nov 2018 10:58:52 -0500
Received: by mail-it1-f195.google.com with SMTP id m15so32774243itl.4
        for <linux-arch@vger.kernel.org>; Thu, 15 Nov 2018 21:47:56 -0800 (PST)
MIME-Version: 1.0
References: <1542104370-22831-1-git-send-email-firoz.khan@linaro.org>
 <CAMo8BfLt0NuQOTP6MBbRdOpK0_fWwtvfZArwVhwW1SZyzH4mbQ@mail.gmail.com>
 <CALxhOng8jc3WCmw-i5LeghjE5EKuJaXVZGHLN98+552qqgUy=Q@mail.gmail.com> <CAMo8BfLgf7+89X6bGtK9iKz2FkZwCtDT4W=ipc4R0OTgjMGoAQ@mail.gmail.com>
In-Reply-To: <CAMo8BfLgf7+89X6bGtK9iKz2FkZwCtDT4W=ipc4R0OTgjMGoAQ@mail.gmail.com>
From: Firoz Khan <firoz.khan@linaro.org>
Date: Fri, 16 Nov 2018 11:17:44 +0530
Message-ID: <CALxhOnih2fQhxuR9-X-JRmKcZj7XRPX7hg-sKyG0WFr_tgCmEA@mail.gmail.com>
Subject: Re: [PATCH v2 0/3] xtensa: system call table generation support
Content-Type: text/plain; charset="UTF-8"
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Max Filippov <jcmvbkbc@gmail.com>
Cc: Chris Zankel <chris@zankel.net>, linux-xtensa@linux-xtensa.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Philippe Ombredanne <pombredanne@nexb.com>, Thomas Gleixner <tglx@linutronix.de>, Kate Stewart <kstewart@linuxfoundation.org>, y2038 Mailman List <y2038@lists.linaro.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Linux-Arch <linux-arch@vger.kernel.org>, Arnd Bergmann <arnd@arndb.de>, Deepa Dinamani <deepa.kernel@gmail.com>, Marcin Juszkiewicz <marcin.juszkiewicz@linaro.org>
Message-ID: <20181116054744.MPaHx5WIvGkm4mquhGTRlt1PItEJnXR6-tdX5YWXDsw@z>

Hi Max,

On Fri, 16 Nov 2018 at 01:46, Max Filippov <jcmvbkbc@gmail.com> wrote:
>
> On Thu, Nov 15, 2018 at 1:57 AM Firoz Khan <firoz.khan@linaro.org> wrote:
> > On Wed, 14 Nov 2018 at 05:23, Max Filippov <jcmvbkbc@gmail.com> wrote:
> > > On Tue, Nov 13, 2018 at 2:19 AM Firoz Khan <firoz.khan@linaro.org> wrote:
> > > [...]
> > > > Firoz Khan (3):
> > > >   xtensa: add __NR_syscalls along with __NR_syscall_count
> > > >   xtensa: add system call table generation support
> > > >   xtensa: generate uapi header and syscall table header files
> > >
> > > What's your plan for submission of this series? Are you going to
> > > submit it with other similar series in a common tree, or shall I take
> > > it into the xtensa tree?
> >
> > I prefer the second  option.
>
> Ok, I've applied the series to my xtensa tree, it should appear in the next
> linux-next.

Sounds good. Thank you.

Firoz

>
> --
> Thanks.
> -- Max
