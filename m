From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH v2 17/76] ARC: Process-creation/scheduling/idle-loop
Date: Fri, 18 Jan 2013 14:35:15 +0000
Message-ID: <201301181435.15491.arnd@arndb.de>
References: <1358511930-7424-1-git-send-email-vgupta@synopsys.com> <1358511930-7424-18-git-send-email-vgupta@synopsys.com>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.126.187]:59095 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753657Ab3AROf0 (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Fri, 18 Jan 2013 09:35:26 -0500
In-Reply-To: <1358511930-7424-18-git-send-email-vgupta@synopsys.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Vineet Gupta <Vineet.Gupta1@synopsys.com>
Cc: linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org, Al Viro <viro@zeniv.linux.org.uk>, Thomas Gleixner <tglx@linutronix.de>, Frederic Weisbecker <fweisbec@gmail.com>

On Friday 18 January 2013, Vineet Gupta wrote:
> +void cpu_idle(void)
> +{
> +       /* Since we SLEEP in idle loop, TIF_POLLING_NRFLAG can't be set */
> +
> +       /* endless idle loop with no priority at all */
> +       while (1) {
> +               tick_nohz_idle_enter();
> +               rcu_idle_enter();
> +
> +               while (!need_resched())
> +                       arch_idle();
> +
> +               rcu_idle_exit();
> +               tick_nohz_idle_exit();
> +
> +               schedule_preempt_disabled();
> +       }
> +}

Unless I'm mistaken, you have introduced the classic sleep race
here, where an interrupt can happen between the check for
need_resched() and the sleep instruction in arch_idle().

To avoid that, you need to disable interrupts around
the inner loop. The sleep instruction should return with
interrupts implicitly enabled if ARC behaves like most
other architectures doing this.

	Arnd
