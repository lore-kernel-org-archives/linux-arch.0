From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH v6 12/36] nds32: Process management
Date: Thu, 18 Jan 2018 11:22:13 +0100
Message-ID: <CAK8P3a2X75r6wrmwwnyOuZLDwkRh+QQJcxb9c+aG2DC9BozeNg@mail.gmail.com>
References: <cover.1515766253.git.green.hu@gmail.com> <10820926f3c1a4757acc8f58b8e07dd0191ffd30.1515766253.git.green.hu@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <10820926f3c1a4757acc8f58b8e07dd0191ffd30.1515766253.git.green.hu@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Greentime Hu <green.hu@gmail.com>
Cc: Greentime <greentime@andestech.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-arch <linux-arch@vger.kernel.org>, Thomas Gleixner <tglx@linutronix.de>, Jason Cooper <jason@lakedaemon.net>, Marc Zyngier <marc.zyngier@arm.com>, Rob Herring <robh+dt@kernel.org>, Networking <netdev@vger.kernel.org>, Vincent Chen <deanbo422@gmail.com>, DTML <devicetree@vger.kernel.org>, Al Viro <viro@zeniv.linux.org.uk>, David Howells <dhowells@redhat.com>, Will Deacon <will.deacon@arm.com>, Daniel Lezcano <daniel.lezcano@linaro.org>, linux-serial@vger.kernel.org, Geert Uytterhoeven <geert.uytterhoeven@gmail.com>, Linus Walleij <linus.walleij@linaro.org>, Mark Rutland <mark.rutland@arm.com>, Greg KH <greg@kroah.com>, Guo Ren <ren_guo@c-sky.co>
List-Id: linux-arch.vger.kernel.org

On Mon, Jan 15, 2018 at 6:53 AM, Greentime Hu <green.hu@gmail.com> wrote:

> +void machine_restart(char *__unused)
> +{
> +       /*
> +        * Clean and disable cache, and turn off interrupts
> +        */
> +       cpu_proc_fin();
> +
> +       /*
> +        * Tell the mm system that we are going to reboot -
> +        * we may need it to insert some 1:1 mappings so that
> +        * soft boot works.
> +        */
> +       setup_mm_for_reboot(reboot_mode);
> +
> +       /*
> +        * Now call the architecture specific reboot code.
> +        */
> +       arch_reset(reboot_mode);
> +
> +       /*
> +        * Whoops - the architecture was unable to reboot.
> +        * Tell the user!
> +        */
> +       mdelay(1000);
> +       pr_info("Reboot failed -- System halted\n");
> +       while (1) ;
> +}

You should insert a call to do_kernel_restart() in this function to allow e.g. a
watchdog driver to provide a machine-specific reboot method. Otherwise
the patch looks good to me,

Acked-by: Arnd Bergmann <arnd@arndb.de>
