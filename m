Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail-yb1-f195.google.com ([209.85.219.195]:46942 "EHLO
        mail-yb1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726093AbfADFzN (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 4 Jan 2019 00:55:13 -0500
MIME-Version: 1.0
References: <1546442912-20818-1-git-send-email-firoz.khan@linaro.org>
 <1546442912-20818-2-git-send-email-firoz.khan@linaro.org> <CAMo8BfJcKGBytDQMFU7XO50uYZcwCftzsLkxLa6aDRPWJ0wW4Q@mail.gmail.com>
 <CALxhOnhy6nh3ycW5kBwqZ4o0EfoFm4MoCJ2453rDCRaX3Z-z7Q@mail.gmail.com>
In-Reply-To: <CALxhOnhy6nh3ycW5kBwqZ4o0EfoFm4MoCJ2453rDCRaX3Z-z7Q@mail.gmail.com>
From: Max Filippov <jcmvbkbc@gmail.com>
Date: Thu, 3 Jan 2019 21:55:00 -0800
Message-ID: <CAMo8Bf+EJ+AaxfWGUcWMxsE=kpYD=-whAb0CxvdGYg+eK4bWpw@mail.gmail.com>
Subject: Re: [PATCH 1/2] xtensa: remove nargs from __SYSCALL
Content-Type: text/plain; charset="UTF-8"
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Firoz Khan <firoz.khan@linaro.org>
Cc: Chris Zankel <chris@zankel.net>, Dominik Brodowski <linux@dominikbrodowski.net>, linux-xtensa@linux-xtensa.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Philippe Ombredanne <pombredanne@nexb.com>, Thomas Gleixner <tglx@linutronix.de>, Kate Stewart <kstewart@linuxfoundation.org>, y2038 Mailman List <y2038@lists.linaro.org>, LKML <linux-kernel@vger.kernel.org>, Linux-Arch <linux-arch@vger.kernel.org>, Arnd Bergmann <arnd@arndb.de>, Deepa Dinamani <deepa.kernel@gmail.com>, Marcin Juszkiewicz <marcin.juszkiewicz@linaro.org>
Message-ID: <20190104055500._96oJ5k7nUVINaZ1ijB76nnrsOlqTOTfYfherHK_dDE@z>

On Thu, Jan 3, 2019 at 9:17 PM Firoz Khan <firoz.khan@linaro.org> wrote:
> On Fri, 4 Jan 2019 at 08:28, Max Filippov <jcmvbkbc@gmail.com> wrote:
> > On Wed, Jan 2, 2019 at 7:29 AM Firoz Khan <firoz.khan@linaro.org> wrote:
> > >         while [ $t_nxt -lt $t_nr ]; do
> > > -               printf "__SYSCALL(%s, sys_ni_syscall, )\n" "${t_nxt}"
> > > +               printf "__SYSCALL(%s,sys_ni_syscall)\n" "${t_nxt}"
> >
> > Please add space after the comma.
>
> This was intentional as I was trying compile other one architecture with the
> previous implementation, it was giving the error. So I modified without space
> after comma.

I have tested that presence or absence of space does not affect the build
for xtensa, and normally we put space after a comma, so I've mentioned that.

Since this script is anyway removed in the next patch of the series it doesn't
really matter whether the spaces are present or not.

So, with or without this change:
Acked-by: Max Filippov <jcmvbkbc@gmail.com>

-- 
Thanks.
-- Max
