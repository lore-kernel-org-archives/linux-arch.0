From: Ley Foon Tan <lftan@altera.com>
Subject: Re: [PATCH] nios2: Use preempt_schedule_irq
Date: Wed, 31 Dec 2014 10:54:21 +0800
Message-ID: <CAFiDJ580-jZXUUM9j9vQ3wLvQ4tsHAvC+c3Swq+Aam6FHZry2Q@mail.gmail.com>
References: <1419948147-19123-1-git-send-email-tklauser@distanz.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mail-la0-f42.google.com ([209.85.215.42]:37600 "EHLO
	mail-la0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751374AbaLaCyX (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Tue, 30 Dec 2014 21:54:23 -0500
In-Reply-To: <1419948147-19123-1-git-send-email-tklauser@distanz.ch>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Tobias Klauser <tklauser@distanz.ch>
Cc: "nios2-dev@lists.rocketboards.org" <nios2-dev@lists.rocketboards.org>, Linux-Arch <linux-arch@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Thomas Gleixner <tglx@linutronix.de>

On Tue, Dec 30, 2014 at 10:02 PM, Tobias Klauser <tklauser@distanz.ch> wrote:
> Follow aa0d53260596 ("ia64: Use preempt_schedule_irq") and use
> preempt_schedule_irq instead of enabling/disabling interrupts and messing around
> with PREEMPT_ACTIVE in the nios2 low-level preemption code ourselves. Also get
> rid of the now needless re-check for TIF_NEED_RESCHED, preempt_schedule_irq
> will already take care of rescheduling.
>
> This also fixes the following build error when building with CONFIG_PREEMPT:
>
> arch/nios2/kernel/built-in.o: In function `need_resched':
> arch/nios2/kernel/entry.S:374: undefined reference to `PREEMPT_ACTIVE'
>
> Cc: Thomas Gleixner <tglx@linutronix.de>
> Signed-off-by: Tobias Klauser <tklauser@distanz.ch>
> ---
Acked-by: Ley Foon Tan <lftan@altera.com>
