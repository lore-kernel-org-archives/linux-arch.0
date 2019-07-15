Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from Galois.linutronix.de ([193.142.43.55]:47673 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730012AbfGONPN (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 15 Jul 2019 09:15:13 -0400
Date: Mon, 15 Jul 2019 15:15:10 +0200 (CEST)
From: Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH] generic arch_futex_atomic_op_inuser() cleanup
In-Reply-To: <CAK8P3a1sT6y+oWKm4ou1=Y+1n5=1_S6UhJN9kkZ6iMxw18O5yw@mail.gmail.com>
Message-ID: <alpine.DEB.2.21.1907151513450.1722@nanos.tec.linutronix.de>
References: <7b963f9a-21b1-4c6d-3ece-556d018508b4@virtuozzo.com> <3d9eef14-4059-0f8a-e76f-a8a09d730913@virtuozzo.com> <CAK8P3a1sT6y+oWKm4ou1=Y+1n5=1_S6UhJN9kkZ6iMxw18O5yw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Arnd Bergmann <arnd@arndb.de>
Cc: Vasily Averin <vvs@virtuozzo.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-arch <linux-arch@vger.kernel.org>, Ingo Molnar <mingo@redhat.com>
Message-ID: <20190715131510.0vlMNpO_wPfKYrC7oxZnL-CRMDrDJx26dmSyerKelM0@z>

On Mon, 15 Jul 2019, Arnd Bergmann wrote:

> On Mon, Jul 15, 2019 at 12:29 PM Vasily Averin <vvs@virtuozzo.com> wrote:
> >
> > Looks like this code is dead and therefore looks strange.
> > I've found it during manual code review and decided to send patch
> > to pay your attention to this problem.
> > Probably it's better to remove this code at all?
> >
> > On 7/15/19 1:27 PM, Vasily Averin wrote:
> > > Access to 'op' variable does not require pagefault_disable(),
> > > 'ret' variable should be initialized before using,
> > > 'oldval' variable can be replaced by constant.
> > >
> > > Signed-off-by: Vasily Averin <vvs@virtuozzo.com>
> 
> I'm not following the reasoning for any of the changes here. Why do you
> think we don't need the pagefault_disable() around get_user()/put_user(),
> and which part of the funtion is dead code?

All of it. If you change the function to

{
	return -ENOSYS;
}

then it is equivalent (except for the pointless pagefault_disable/enable()
pair which protects absolutely nothing).

Thanks,

	tglx
