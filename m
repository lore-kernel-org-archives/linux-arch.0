From: Haojian Zhuang <haojian.zhuang@gmail.com>
Subject: Re: [PATCH V3 11/11] ARM: delete struct sys_timer
Date: Wed, 21 Nov 2012 12:43:02 +0800
Message-ID: <CAN1soZxf=i9Z9zOpbE2zUW6q6CY9TfOsUB7bf+-K_oLcmFqeCQ@mail.gmail.com>
References: <1353349867-28494-1-git-send-email-swarren@wwwdotorg.org>
	<1353349867-28494-12-git-send-email-swarren@wwwdotorg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1353349867-28494-12-git-send-email-swarren@wwwdotorg.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Stephen Warren <swarren@wwwdotorg.org>
Cc: Russell King <linux@arm.linux.org.uk>, Olof Johansson <olof@lixom.net>, Arnd Bergmann <arnd@arndb.de>, John Stultz <johnstul@us.ibm.com>, Thomas Gleixner <tglx@linutronix.de>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, linux-arch@vger.kernel.org, Stephen Warren <swarren@nvidia.com>
List-Id: linux-arch.vger.kernel.org

On Tue, Nov 20, 2012 at 2:31 AM, Stephen Warren <swarren@wwwdotorg.org> wrote:
> From: Stephen Warren <swarren@nvidia.com>
>
> Now that the only field in struct sys_timer is .init, delete the struct,
> and replace the machine descriptor .timer field with the initialization
> function itself.
>
> This will enable moving timer drivers into drivers/clocksource without
> having to place a public prototype of each struct sys_timer object into
> include/linux; the intent is to create a single of_clocksource_init()
> function that determines which timer driver to initialize by scanning
> the device dtree, much like the proposed irqchip_init() at:
> http://www.spinics.net/lists/arm-kernel/msg203686.html
>
> Signed-off-by: Stephen Warren <swarren@nvidia.com>
> Tested-by: Robert Jarzmik <robert.jarzmik@free.fr>
> ---
> v3: Minor merge conflicts due to rebasing onto next-20121115.
> v2: Converted all platforms, not just Tegra.
>
> The patch is very large, so I've trimmed it for the mailing list, leaving
> only the core ARM changes, changes outside arch/arm, and a single machine
> example. The full series can be found at:
>
> git://nv-tegra.nvidia.com/user/swarren/linux-2.6 arm_timer_rework
> ---
>  492 files changed, 622 insertions(+), 1199 deletions(-)

I checked the patch for mach-mmp.

@@ -69,7 +65,7 @@ static const char *mmp_dt_board_compat[] __initdata = {
 DT_MACHINE_START(PXA168_DT, "Marvell PXA168 (Device Tree Support)")
        .map_io         = mmp_map_io,
        .init_irq       = mmp_dt_irq_init,
-       .timer          = &mmp_dt_timer,
+       .init_time      = mmp_dt_init_timer,
        .init_machine   = pxa168_dt_init,
        .dt_compat      = mmp_dt_board_compat,
 MACHINE_END
@@ -77,7 +73,7 @@ MACHINE_END
 DT_MACHINE_START(PXA910_DT, "Marvell PXA910 (Device Tree Support)")
        .map_io         = mmp_map_io,
        .init_irq       = mmp_dt_irq_init,
-       .timer          = &mmp_dt_timer,
+       .init_time      = mmp_dt_timer_init,
        .init_machine   = pxa910_dt_init,
        .dt_compat      = mmp_dt_board_compat,
 MACHINE_END

This first init_time is assigned by mmp_dt_init_timer. But the second
init_time is
assigned by mmp_dt_timer_init. I think it's a typo error. Could you
help to fix this?

Regards
Haojian
