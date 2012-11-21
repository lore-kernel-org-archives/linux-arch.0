From: Linus Walleij <linus.walleij@linaro.org>
Subject: Re: [PATCH V3 10/11] ARM: remove struct sys_timer suspend and resume fields
Date: Wed, 21 Nov 2012 09:28:12 +0100
Message-ID: <CACRpkdb-cmwTH_7EJO02m2+CCZrJ2ycgtGpf8stoiFKSm8jqww@mail.gmail.com>
References: <1353349867-28494-1-git-send-email-swarren@wwwdotorg.org>
	<1353349867-28494-11-git-send-email-swarren@wwwdotorg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mail-vc0-f174.google.com ([209.85.220.174]:42977 "EHLO
	mail-vc0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751876Ab2KUI2N (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Wed, 21 Nov 2012 03:28:13 -0500
Received: by mail-vc0-f174.google.com with SMTP id m18so3314330vcm.19
        for <linux-arch@vger.kernel.org>; Wed, 21 Nov 2012 00:28:12 -0800 (PST)
In-Reply-To: <1353349867-28494-11-git-send-email-swarren@wwwdotorg.org>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Stephen Warren <swarren@wwwdotorg.org>
Cc: Russell King <linux@arm.linux.org.uk>, Olof Johansson <olof@lixom.net>, Arnd Bergmann <arnd@arndb.de>, John Stultz <johnstul@us.ibm.com>, Thomas Gleixner <tglx@linutronix.de>, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, Stephen Warren <swarren@nvidia.com>, Jonas ABERG <jonas.aberg@stericsson.com>

Oh and there was this comment/TODO:

On Mon, Nov 19, 2012 at 7:31 PM, Stephen Warren <swarren@wwwdotorg.org> wrote:

> @@ -17,15 +17,6 @@
>   *   Initialise the kernels jiffy timer source, claim interrupt
>   *   using setup_irq.  This is called early on during initialisation
>   *   while interrupts are still disabled on the local CPU.
> - * - suspend
> - *   Suspend the kernel jiffy timer source, if necessary.  This
> - *   is called with interrupts disabled, after all normal devices
> - *   have been suspended.  If no action is required, set this to
> - *   NULL.
> - * - resume
> - *   Resume the kernel jiffy timer source, if necessary.  This
> - *   is called with interrupts disabled before any normal devices
> - *   are resumed.  If no action is required, set this to NULL.
>   * - offset
>   *   Return the timer offset in microseconds since the last timer
>   *   interrupt.  Note: this must take account of any unprocessed
> @@ -33,8 +24,6 @@
>   */
>  struct sys_timer {
>         void                    (*init)(void);
> -       void                    (*suspend)(void);
> -       void                    (*resume)(void);
>  };

So from the above it is quite clear that the sys_timer is breaking
the suspend_noirq/resume_noirq naming convention from
runtime PM as IRQs are disabled on these paths.

The same goes for struct clock_event_device ...

So while this looks just as bad after as before the patch,
we should take a mental notice to rename the .suspend
and .resume hooks in the clock_event_device to
.suspend_noirq and .resume_noirq at some point.

I was thinking that if your patch set is introducing a
plethora of new users of these hooks we should maybe
stick a patch at the beginning of the series renaming the
hooks to *_noirq, but if it's a major obstacle it can surely wait.

Yours,
Linus Walleij
