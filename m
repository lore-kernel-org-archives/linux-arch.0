Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail-io1-f68.google.com ([209.85.166.68]:37900 "EHLO
        mail-io1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726239AbfADGO0 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 4 Jan 2019 01:14:26 -0500
Received: by mail-io1-f68.google.com with SMTP id l14so28811701ioj.5
        for <linux-arch@vger.kernel.org>; Thu, 03 Jan 2019 22:14:25 -0800 (PST)
MIME-Version: 1.0
References: <1546442912-20818-1-git-send-email-firoz.khan@linaro.org>
 <1546442912-20818-2-git-send-email-firoz.khan@linaro.org> <CAMo8BfJcKGBytDQMFU7XO50uYZcwCftzsLkxLa6aDRPWJ0wW4Q@mail.gmail.com>
 <CALxhOnhy6nh3ycW5kBwqZ4o0EfoFm4MoCJ2453rDCRaX3Z-z7Q@mail.gmail.com> <CAMo8Bf+EJ+AaxfWGUcWMxsE=kpYD=-whAb0CxvdGYg+eK4bWpw@mail.gmail.com>
In-Reply-To: <CAMo8Bf+EJ+AaxfWGUcWMxsE=kpYD=-whAb0CxvdGYg+eK4bWpw@mail.gmail.com>
From: Firoz Khan <firoz.khan@linaro.org>
Date: Fri, 4 Jan 2019 11:44:13 +0530
Message-ID: <CALxhOnhVKRC0faiQTNNeUP3rYtK7aUg1Sr758ScokrBnE55iHQ@mail.gmail.com>
Subject: Re: [PATCH 1/2] xtensa: remove nargs from __SYSCALL
Content-Type: text/plain; charset="UTF-8"
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Max Filippov <jcmvbkbc@gmail.com>
Cc: Chris Zankel <chris@zankel.net>, Dominik Brodowski <linux@dominikbrodowski.net>, linux-xtensa@linux-xtensa.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Philippe Ombredanne <pombredanne@nexb.com>, Thomas Gleixner <tglx@linutronix.de>, Kate Stewart <kstewart@linuxfoundation.org>, y2038 Mailman List <y2038@lists.linaro.org>, LKML <linux-kernel@vger.kernel.org>, Linux-Arch <linux-arch@vger.kernel.org>, Arnd Bergmann <arnd@arndb.de>, Deepa Dinamani <deepa.kernel@gmail.com>, Marcin Juszkiewicz <marcin.juszkiewicz@linaro.org>
Message-ID: <20190104061413.DnJVapmguf9OkbfNhbqYbtDpl2H5FBuSGpQydPgvRkw@z>

Hi Max,

On Fri, 4 Jan 2019 at 11:25, Max Filippov <jcmvbkbc@gmail.com> wrote:
> On Thu, Jan 3, 2019 at 9:17 PM Firoz Khan <firoz.khan@linaro.org> wrote:
> > On Fri, 4 Jan 2019 at 08:28, Max Filippov <jcmvbkbc@gmail.com> wrote:
> > > On Wed, Jan 2, 2019 at 7:29 AM Firoz Khan <firoz.khan@linaro.org> wrote:
> > This was intentional as I was trying compile other one architecture with the
> > previous implementation, it was giving the error. So I modified without space
> > after comma.
>
> I have tested that presence or absence of space does not affect the build
> for xtensa, and normally we put space after a comma, so I've mentioned that.
>
> Since this script is anyway removed in the next patch of the series it doesn't
> really matter whether the spaces are present or not.

Yes, you are right, there is no effect in xtensa but if I'm right
there is a problem
in powerpc architecture (not remembering exactly which arch) with this space
after comma.

BTW, the script from all architecture will be removed and keep it in
scripts directory
is our plan. So to satisfy powerpc (again I'm not sure which arch) I
just did this
change.

Thanks for your feedback.

Firoz
