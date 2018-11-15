Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail-io1-f65.google.com ([209.85.166.65]:43978 "EHLO
        mail-io1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728719AbeKOUE4 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 15 Nov 2018 15:04:56 -0500
Received: by mail-io1-f65.google.com with SMTP id t81-v6so13992639iod.10
        for <linux-arch@vger.kernel.org>; Thu, 15 Nov 2018 01:57:48 -0800 (PST)
MIME-Version: 1.0
References: <1542104370-22831-1-git-send-email-firoz.khan@linaro.org> <CAMo8BfLt0NuQOTP6MBbRdOpK0_fWwtvfZArwVhwW1SZyzH4mbQ@mail.gmail.com>
In-Reply-To: <CAMo8BfLt0NuQOTP6MBbRdOpK0_fWwtvfZArwVhwW1SZyzH4mbQ@mail.gmail.com>
From: Firoz Khan <firoz.khan@linaro.org>
Date: Thu, 15 Nov 2018 15:27:36 +0530
Message-ID: <CALxhOng8jc3WCmw-i5LeghjE5EKuJaXVZGHLN98+552qqgUy=Q@mail.gmail.com>
Subject: Re: [PATCH v2 0/3] xtensa: system call table generation support
Content-Type: text/plain; charset="UTF-8"
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Max Filippov <jcmvbkbc@gmail.com>
Cc: Chris Zankel <chris@zankel.net>, linux-xtensa@linux-xtensa.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Philippe Ombredanne <pombredanne@nexb.com>, Thomas Gleixner <tglx@linutronix.de>, Kate Stewart <kstewart@linuxfoundation.org>, y2038 Mailman List <y2038@lists.linaro.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Linux-Arch <linux-arch@vger.kernel.org>, Arnd Bergmann <arnd@arndb.de>, Deepa Dinamani <deepa.kernel@gmail.com>, Marcin Juszkiewicz <marcin.juszkiewicz@linaro.org>
Message-ID: <20181115095736.0_eFCayE1C-fb2ODo7mzqc9UE4jQ0ZHvGLXPLzg18OM@z>

Hi Max,

On Wed, 14 Nov 2018 at 05:23, Max Filippov <jcmvbkbc@gmail.com> wrote:
>
> Hi Firoz,
>
> On Tue, Nov 13, 2018 at 2:19 AM Firoz Khan <firoz.khan@linaro.org> wrote:
> [...]
> > Firoz Khan (3):
> >   xtensa: add __NR_syscalls along with __NR_syscall_count
> >   xtensa: add system call table generation support
> >   xtensa: generate uapi header and syscall table header files
>
> What's your plan for submission of this series? Are you going to
> submit it with other similar series in a common tree, or shall I take
> it into the xtensa tree?

I prefer the second  option.

Thanks
Firoz

>
> --
> Thanks.
> -- Max
