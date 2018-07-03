From: Rob Herring <robh@kernel.org>
Subject: Re: [PATCH V2 19/19] irqchip: add C-SKY irqchip drivers
Date: Mon, 2 Jul 2018 21:27:13 -0600
Message-ID: <CABGGiszccmOLMsLq4qRNjtq6hbR6XjP1P8Jj26kxQYhQUm14Eg@mail.gmail.com>
References: <cover.1530465325.git.ren_guo@c-sky.com> <b940404f1994ecb839fe6f09f6b6f3cfe81ee5fe.1530465326.git.ren_guo@c-sky.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <b940404f1994ecb839fe6f09f6b6f3cfe81ee5fe.1530465326.git.ren_guo@c-sky.com>
Sender: linux-kernel-owner@vger.kernel.org
To: ren_guo@c-sky.com
Cc: linux-arch@vger.kernel.org, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Thomas Gleixner <tglx@linutronix.de>, Daniel Lezcano <daniel.lezcano@linaro.org>, Jason Cooper <jason@lakedaemon.net>, Arnd Bergmann <arnd@arndb.de>, c-sky_gcc_upstream@c-sky.com, gnu-csky@mentor.com, thomas.petazzoni@bootlin.com, wbx@uclibc-ng.org, Greentime Hu <green.hu@gmail.com>
List-Id: linux-arch.vger.kernel.org

On Sun, Jul 1, 2018 at 11:35 AM Guo Ren <ren_guo@c-sky.com> wrote:
>
Commit message needed.

> Signed-off-by: Guo Ren <ren_guo@c-sky.com>
> ---
>  drivers/irqchip/Makefile           |   1 +
>  drivers/irqchip/irq-csky-v1.c      | 126 ++++++++++++++++++++++++
>  drivers/irqchip/irq-csky-v2.c      | 191 +++++++++++++++++++++++++++++++++++++
>  drivers/irqchip/irq-nationalchip.c | 131 +++++++++++++++++++++++++
>  4 files changed, 449 insertions(+)
>  create mode 100644 drivers/irqchip/irq-csky-v1.c
>  create mode 100644 drivers/irqchip/irq-csky-v2.c
>  create mode 100644 drivers/irqchip/irq-nationalchip.c
>
> diff --git a/drivers/irqchip/Makefile b/drivers/irqchip/Makefile
> index d27e3e3..51e7316 100644
> --- a/drivers/irqchip/Makefile
> +++ b/drivers/irqchip/Makefile
> @@ -85,3 +85,4 @@ obj-$(CONFIG_IRQ_UNIPHIER_AIDET)      += irq-uniphier-aidet.o
>  obj-$(CONFIG_ARCH_SYNQUACER)           += irq-sni-exiu.o
>  obj-$(CONFIG_MESON_IRQ_GPIO)           += irq-meson-gpio.o
>  obj-$(CONFIG_GOLDFISH_PIC)             += irq-goldfish-pic.o
> +obj-$(CONFIG_CSKY)                     += irq-csky-v1.o irq-csky-v2.o irq-nationalchip.o
> diff --git a/drivers/irqchip/irq-csky-v1.c b/drivers/irqchip/irq-csky-v1.c
> new file mode 100644
> index 0000000..64ea564
> --- /dev/null
> +++ b/drivers/irqchip/irq-csky-v1.c
> @@ -0,0 +1,126 @@
> +// SPDX-License-Identifier: GPL-2.0
> +// Copyright (C) 2018 Hangzhou C-SKY Microsystems co.,ltd.
> +#include <linux/kernel.h>
> +#include <linux/init.h>
> +#include <linux/of.h>
> +#include <linux/of_address.h>
> +#include <linux/module.h>
> +#include <linux/irqdomain.h>
> +#include <linux/irqchip.h>
> +#include <linux/irq.h>
> +#include <linux/interrupt.h>
> +#include <asm/irq.h>
> +#include <asm/io.h>
> +#include <asm/traps.h>
> +
> +#ifdef CONFIG_CSKY_VECIRQ_LEGENCY

Do you mean "legacy"?

It would be better to make this run-time so you can support multiple
platforms in one build. You should be able to determine this from DT.

> +#include <asm/reg_ops.h>
> +#endif

[...]

> +IRQCHIP_DECLARE(csky_intc_v1, "csky,intc-v1", csky_intc_v1_init);

DT bindings must be documented. And the vendor prefix must also be
registered in vendor-prefixes.txt.

[...]

> +IRQCHIP_DECLARE(csky_intc_v2, "csky,intc-v2", csky_intc_v2_init);

And this one. Use of v1, v2, etc. is generally discouraged unless
there is some strict versioning behind it. Most bindings use
implementation specific compatible strings (which typically means the
SoC name/number as part of it).

[...]

> +IRQCHIP_DECLARE(nationalchip_intc_v1_ave, "nationalchip,intc-v1,ave", intc_init);

Here too. And your timers as well.

You'll also need to do cpu bindings as well especially for SMP.

Rob
