Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail-qk1-f195.google.com ([209.85.222.195]:41690 "EHLO
        mail-qk1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729827AbfGOMG3 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 15 Jul 2019 08:06:29 -0400
MIME-Version: 1.0
References: <7b963f9a-21b1-4c6d-3ece-556d018508b4@virtuozzo.com> <3d9eef14-4059-0f8a-e76f-a8a09d730913@virtuozzo.com>
In-Reply-To: <3d9eef14-4059-0f8a-e76f-a8a09d730913@virtuozzo.com>
From: Arnd Bergmann <arnd@arndb.de>
Date: Mon, 15 Jul 2019 14:06:10 +0200
Message-ID: <CAK8P3a1sT6y+oWKm4ou1=Y+1n5=1_S6UhJN9kkZ6iMxw18O5yw@mail.gmail.com>
Subject: Re: [PATCH] generic arch_futex_atomic_op_inuser() cleanup
Content-Type: text/plain; charset="UTF-8"
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Vasily Averin <vvs@virtuozzo.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-arch <linux-arch@vger.kernel.org>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>
Message-ID: <20190715120610.V_r8imxiV2mMmwDrvhbAoXInawJ6khxoJuZjkd6_AJ4@z>

On Mon, Jul 15, 2019 at 12:29 PM Vasily Averin <vvs@virtuozzo.com> wrote:
>
> Looks like this code is dead and therefore looks strange.
> I've found it during manual code review and decided to send patch
> to pay your attention to this problem.
> Probably it's better to remove this code at all?
>
> On 7/15/19 1:27 PM, Vasily Averin wrote:
> > Access to 'op' variable does not require pagefault_disable(),
> > 'ret' variable should be initialized before using,
> > 'oldval' variable can be replaced by constant.
> >
> > Signed-off-by: Vasily Averin <vvs@virtuozzo.com>

I'm not following the reasoning for any of the changes here. Why do you
think we don't need the pagefault_disable() around get_user()/put_user(),
and which part of the funtion is dead code?

       Arnd
