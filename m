From: "Guan Xuetao" <gxt@mprc.pku.edu.cn>
Subject: RE: Request (2nd) for unicore32 architecture codes to merge into linux-next
Date: Fri, 11 Feb 2011 11:18:40 +0800
Message-ID: <022d01cbc99a$63717e80$2a547b80$@mprc.pku.edu.cn>
References: <01c701cbba0f$08185800$18490800$@mprc.pku.edu.cn> <alpine.LFD.2.00.1102062254560.31804@localhost6.localdomain6>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="US-ASCII"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mprc.pku.edu.cn ([162.105.203.9]:58850 "EHLO mprc.pku.edu.cn"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750910Ab1BKDTg (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Thu, 10 Feb 2011 22:19:36 -0500
In-Reply-To: <alpine.LFD.2.00.1102062254560.31804@localhost6.localdomain6>
Content-Language: zh-cn
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: 'Thomas Gleixner' <tglx@linutronix.de>, 'Guan Xuetao' <guanxuetao@mprc.pku.edu.cn>
Cc: sfr@canb.auug.org.au, 'Arnd Bergmann' <arnd@arndb.de>, gregkh@suse.de, jbarnes@virtuousgeek.org, dmitry.torokhov@gmail.com, dtor@mail.ru, linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org, linux-next@vger.kernel.org



> >  arch/unicore32/kernel/time.c                  |  148 +++++
> 
> static struct clock_event_device ckevt_puv3_osmr0 ...
> #ifdef CONFIG_ARCH_FPGA
>         .shift          = 18, /* correct shift val: 16, but warn_on_slowpath */
> #else
>         .shift          = 30,
> #endif
> 
> ....
>         ckevt_puv3_osmr0.mult =
>                 div_sc(CLOCK_TICK_RATE, NSEC_PER_SEC, ckevt_puv3_osmr0.shift);
> 
> Please use the function which calculates the optimizes mult/shift
> values for you depending on the clock frequency.
> 
> clockevents_calc_mult_shift() is your friend.
> 
> >  arch/unicore32/kernel/irq.c                   |  426 +++++++++++++
> 
> Please convert your irq_chips to the new function pointers:
> 
>        .mask -> .irq_mask
>        ...
> 
> The new functions replace the "unsigned int irq" argument with
> "struct irq_data *d".
> 
> So conversion for your chips is simply
> 
> s/unsigned int irq/struct irq_data *d/
> 
> and
> 
> s/irq/d->irq/ in the implementation.
> 
> Then your arch should select: GENERIC_HARDIRQS_NO_DEPRECATED
> 
> Otherwise I'm happy with your irq and time related patches.
> 
> Thanks,
> 
> 	tglx
Thanks Thomas. I will apply the advice and test it lator.

Guan Xuetao
