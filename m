Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail-wm1-f67.google.com ([209.85.128.67]:55891 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726026AbeKBUYb (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 2 Nov 2018 16:24:31 -0400
Received: by mail-wm1-f67.google.com with SMTP id s10-v6so1639877wmc.5
        for <linux-arch@vger.kernel.org>; Fri, 02 Nov 2018 04:17:41 -0700 (PDT)
Subject: Re: [PATCH V13 0/2] C-SKY(csky) Timer Driver
References: <cover.1540947083.git.ren_guo@c-sky.com>
From: Daniel Lezcano <daniel.lezcano@linaro.org>
Message-ID: <c84a6479-d418-7cd8-ec65-c6ad374ec3f3@linaro.org>
Date: Fri, 2 Nov 2018 12:17:38 +0100
MIME-Version: 1.0
In-Reply-To: <cover.1540947083.git.ren_guo@c-sky.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Guo Ren <ren_guo@c-sky.com>, tglx@linutronix.de
Cc: arnd@arndb.de, linux-arch@vger.kernel.org, devicetree@vger.kernel.org

On 31/10/2018 03:06, Guo Ren wrote:
> Hi Daniel & Thomas,
> 
> I sent you "PATCH V13" a few days ago, but no-reply:
> https://lkml.org/lkml/2018/10/29/608
> Now I send again.
> 
> Although csky subsystem has been merged into linux-4.20, but there is no
> timer drivers for csky. A lot of boards need these timer drivers.
> 
> Please help merge them into linux-4.20, wait for you reply.

Thomas,

is it fine if I sent you a late PR based in tip/timers/urgent ?

These are new drivers.



> Changelog:
>  - Move changelog to end of patch.
>  - Remove the set_irq_createmapping call back in csky-mp-intc.c.
>  - Convert the cpumask to an interrupt-controller specific representation
>    in driver's code, and not the SMP code's, and also modify the related
>    codes in csky kernel patchset.
>  - Add COMPILE_TEST for csky_mp_timer.
>  - Fixup smp boot error, cpuhp_setup_state must after timer_of_init()
>    for csky_mp_timer.
> 
> Guo Ren (2):
>   clocksource: add C-SKY SMP timer
>   clocksource: add gx6605s SOC system timer
> 
>  drivers/clocksource/Kconfig         |  18 ++++
>  drivers/clocksource/Makefile        |   2 +
>  drivers/clocksource/timer-gx6605s.c | 154 ++++++++++++++++++++++++++++++++
>  drivers/clocksource/timer-mp-csky.c | 173 ++++++++++++++++++++++++++++++++++++
>  include/linux/cpuhotplug.h          |   1 +
>  5 files changed, 348 insertions(+)
>  create mode 100644 drivers/clocksource/timer-gx6605s.c
>  create mode 100644 drivers/clocksource/timer-mp-csky.c
> 


-- 
 <http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
