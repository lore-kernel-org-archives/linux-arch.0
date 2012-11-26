From: Stephen Warren <swarren@wwwdotorg.org>
Subject: Re: [PATCH V3 11/11] ARM: delete struct sys_timer
Date: Mon, 26 Nov 2012 12:15:17 -0700
Message-ID: <50B3BFC5.8070404@wwwdotorg.org>
References: <1353349867-28494-1-git-send-email-swarren@wwwdotorg.org> <1353349867-28494-12-git-send-email-swarren@wwwdotorg.org> <CAN1soZxf=i9Z9zOpbE2zUW6q6CY9TfOsUB7bf+-K_oLcmFqeCQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CAN1soZxf=i9Z9zOpbE2zUW6q6CY9TfOsUB7bf+-K_oLcmFqeCQ@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Haojian Zhuang <haojian.zhuang@gmail.com>
Cc: Russell King <linux@arm.linux.org.uk>, Olof Johansson <olof@lixom.net>, Arnd Bergmann <arnd@arndb.de>, John Stultz <johnstul@us.ibm.com>, Thomas Gleixner <tglx@linutronix.de>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, linux-arch@vger.kernel.org, Stephen Warren <swarren@nvidia.com>
List-Id: linux-arch.vger.kernel.org

On 11/20/2012 09:43 PM, Haojian Zhuang wrote:
> On Tue, Nov 20, 2012 at 2:31 AM, Stephen Warren <swarren@wwwdotorg.org> wrote:
>> From: Stephen Warren <swarren@nvidia.com>
>>
>> Now that the only field in struct sys_timer is .init, delete the struct,
>> and replace the machine descriptor .timer field with the initialization
>> function itself.
>>
>> This will enable moving timer drivers into drivers/clocksource without
>> having to place a public prototype of each struct sys_timer object into
>> include/linux; the intent is to create a single of_clocksource_init()
>> function that determines which timer driver to initialize by scanning
>> the device dtree, much like the proposed irqchip_init() at:
>> http://www.spinics.net/lists/arm-kernel/msg203686.html
...
> I checked the patch for mach-mmp.
> 
> @@ -69,7 +65,7 @@ static const char *mmp_dt_board_compat[] __initdata = {
>  DT_MACHINE_START(PXA168_DT, "Marvell PXA168 (Device Tree Support)")
>         .map_io         = mmp_map_io,
>         .init_irq       = mmp_dt_irq_init,
> -       .timer          = &mmp_dt_timer,
> +       .init_time      = mmp_dt_init_timer,
>         .init_machine   = pxa168_dt_init,
>         .dt_compat      = mmp_dt_board_compat,
>  MACHINE_END
> @@ -77,7 +73,7 @@ MACHINE_END
>  DT_MACHINE_START(PXA910_DT, "Marvell PXA910 (Device Tree Support)")
>         .map_io         = mmp_map_io,
>         .init_irq       = mmp_dt_irq_init,
> -       .timer          = &mmp_dt_timer,
> +       .init_time      = mmp_dt_timer_init,
>         .init_machine   = pxa910_dt_init,
>         .dt_compat      = mmp_dt_board_compat,
>  MACHINE_END
> 
> This first init_time is assigned by mmp_dt_init_timer. But the second
> init_time is
> assigned by mmp_dt_timer_init. I think it's a typo error. Could you
> help to fix this?

Thanks, I've fixed that up locally.
