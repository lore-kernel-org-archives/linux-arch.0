From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH v2 17/76] ARC: Process-creation/scheduling/idle-loop
Date: Mon, 21 Jan 2013 14:21:23 +0000
Message-ID: <201301211421.23794.arnd@arndb.de>
References: <1358511930-7424-1-git-send-email-vgupta@synopsys.com> <201301181435.15491.arnd@arndb.de> <50FD2432.8010201@synopsys.com>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.17.10]:53624 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755295Ab3AUOVh (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Mon, 21 Jan 2013 09:21:37 -0500
In-Reply-To: <50FD2432.8010201@synopsys.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Vineet Gupta <Vineet.Gupta1@synopsys.com>
Cc: linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org, Al Viro <viro@zeniv.linux.org.uk>, Thomas Gleixner <tglx@linutronix.de>, Frederic Weisbecker <fweisbec@gmail.com>

On Monday 21 January 2013, Vineet Gupta wrote:
> -               while (!need_resched())
> +doze:
> +               local_irq_disable();
> +               if (!need_resched()) {
>                         arch_idle();
> +                       goto doze;
> +               } else {
> +                       local_irq_enable();
> +               }
> 

Ok, that looks like it will work.

	Arnd
