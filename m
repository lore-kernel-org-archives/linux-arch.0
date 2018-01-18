From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH v6 06/36] nds32: Kernel booting and initialization
Date: Thu, 18 Jan 2018 11:11:13 +0100
Message-ID: <CAK8P3a143yQ72+QGZSxpiFc7p8Hb7PXuCybJBFoLRSBaZ2uw4g@mail.gmail.com>
References: <cover.1515766253.git.green.hu@gmail.com> <5930d2df872116555cc553284b6c111dce29e298.1515766253.git.green.hu@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <netdev-owner@vger.kernel.org>
In-Reply-To: <5930d2df872116555cc553284b6c111dce29e298.1515766253.git.green.hu@gmail.com>
Sender: netdev-owner@vger.kernel.org
To: Greentime Hu <green.hu@gmail.com>
Cc: Greentime <greentime@andestech.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-arch <linux-arch@vger.kernel.org>, Thomas Gleixner <tglx@linutronix.de>, Jason Cooper <jason@lakedaemon.net>, Marc Zyngier <marc.zyngier@arm.com>, Rob Herring <robh+dt@kernel.org>, Networking <netdev@vger.kernel.org>, Vincent Chen <deanbo422@gmail.com>, DTML <devicetree@vger.kernel.org>, Al Viro <viro@zeniv.linux.org.uk>, David Howells <dhowells@redhat.com>, Will Deacon <will.deacon@arm.com>, Daniel Lezcano <daniel.lezcano@linaro.org>, linux-serial@vger.kernel.org, Geert Uytterhoeven <geert.uytterhoeven@gmail.com>, Linus Walleij <linus.walleij@linaro.org>, Mark Rutland <mark.rutland@arm.com>, Greg KH <greg@kroah.com>, Guo Ren <ren_guo@c-sky.co>
List-Id: linux-arch.vger.kernel.org

On Mon, Jan 15, 2018 at 6:53 AM, Greentime Hu <green.hu@gmail.com> wrote:

I had not looked at this patch in enough detail earlier, sorry about
that. It should be
easy enough to fix though.

> +#ifdef CONFIG_VGA_CONSOLE
> +struct screen_info screen_info;
> +#endif

I would assume that you can't ever have a VGA console. Just drop all
the references
here and instead send a patch to the fbdev maintainer to add the dependency
at CONFIG_VGA_CONSOLE to prevent selecting it with nds32.

> +extern struct mm_struct init_mm;

init_mm is declared in linux/mm_types.h, so you should need another declaration.
In general, you should never put 'extern' declarations in to .c files anyway.

> +
> +extern void __init early_init_devtree(void *params);
> +extern void __init early_trap_init(void);

similarly, these are declared in include/linux/of_fdt.h

> +void __init setup_arch(char **cmdline_p)
> +{
> +       early_init_devtree(__atags_pointer ?
> +                          phys_to_virt(__atags_pointer) : __dtb_start);

The reference to '__atags_pointer' appears to be a leftover from pre-DT
days. Can you just remove that?

> +void calibrate_delay(void)
> +{
> +       const int *val;
> +       struct device_node *cpu = NULL;
> +       cpu = of_find_compatible_node(NULL, NULL, "andestech,nds32v3");
> +       val = of_get_property(cpu, "clock-frequency", NULL);
> +       if (!val || !*val)
> +               panic("no cpu 'clock-frequency' parameter in device tree");
> +       loops_per_jiffy = be32_to_cpup(val) / HZ;
> +       pr_cont("%lu.%02lu BogoMIPS (lpj=%lu)\n",
> +               loops_per_jiffy / (500000 / HZ),
> +               (loops_per_jiffy / (5000 / HZ)) % 100, loops_per_jiffy);
> +}

This seems very odd to me: The 'clock-frequency' property in the
cpu node should refer to the actual frequency it is running at, but that
tends to be different from the bogomips as needed by the ndelay()
function. Can you explain what is going on here?

       Arnd
