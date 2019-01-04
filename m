Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail-it1-f195.google.com ([209.85.166.195]:56188 "EHLO
        mail-it1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725988AbfADFR6 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 4 Jan 2019 00:17:58 -0500
Received: by mail-it1-f195.google.com with SMTP id m62so268726ith.5
        for <linux-arch@vger.kernel.org>; Thu, 03 Jan 2019 21:17:57 -0800 (PST)
MIME-Version: 1.0
References: <1546442912-20818-1-git-send-email-firoz.khan@linaro.org>
 <1546442912-20818-2-git-send-email-firoz.khan@linaro.org> <CAMo8BfJcKGBytDQMFU7XO50uYZcwCftzsLkxLa6aDRPWJ0wW4Q@mail.gmail.com>
In-Reply-To: <CAMo8BfJcKGBytDQMFU7XO50uYZcwCftzsLkxLa6aDRPWJ0wW4Q@mail.gmail.com>
From: Firoz Khan <firoz.khan@linaro.org>
Date: Fri, 4 Jan 2019 10:47:46 +0530
Message-ID: <CALxhOnhy6nh3ycW5kBwqZ4o0EfoFm4MoCJ2453rDCRaX3Z-z7Q@mail.gmail.com>
Subject: Re: [PATCH 1/2] xtensa: remove nargs from __SYSCALL
Content-Type: text/plain; charset="UTF-8"
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Max Filippov <jcmvbkbc@gmail.com>
Cc: Chris Zankel <chris@zankel.net>, Dominik Brodowski <linux@dominikbrodowski.net>, linux-xtensa@linux-xtensa.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Philippe Ombredanne <pombredanne@nexb.com>, Thomas Gleixner <tglx@linutronix.de>, Kate Stewart <kstewart@linuxfoundation.org>, y2038 Mailman List <y2038@lists.linaro.org>, LKML <linux-kernel@vger.kernel.org>, Linux-Arch <linux-arch@vger.kernel.org>, Arnd Bergmann <arnd@arndb.de>, Deepa Dinamani <deepa.kernel@gmail.com>, Marcin Juszkiewicz <marcin.juszkiewicz@linaro.org>
Message-ID: <20190104051746.nAhNTKVjoHgC8USffqS-W5UBC2dyuhF50j2ubH2qujI@z>

Hi Max,

Thanks for your reply.

On Fri, 4 Jan 2019 at 08:28, Max Filippov <jcmvbkbc@gmail.com> wrote:
> On Wed, Jan 2, 2019 at 7:29 AM Firoz Khan <firoz.khan@linaro.org> wrote:
> >         while [ $t_nxt -lt $t_nr ]; do
> > -               printf "__SYSCALL(%s, sys_ni_syscall, )\n" "${t_nxt}"
> > +               printf "__SYSCALL(%s,sys_ni_syscall)\n" "${t_nxt}"
>
> Please add space after the comma.

This was intentional as I was trying compile other one architecture with the
previous implementation, it was giving the error. So I modified without space
after comma.

Firoz
