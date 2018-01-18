From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH v6 24/36] nds32: Loadable modules
Date: Thu, 18 Jan 2018 11:41:25 +0100
Message-ID: <CAK8P3a3pQSxM+gJ+dJsyeo5YnuOOyFYVoJdCVmnoHR0Numya5g@mail.gmail.com>
References: <cover.1515766253.git.green.hu@gmail.com> <0a0789a3f776a5248ebc01706d502a3a9823cfac.1515766253.git.green.hu@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <netdev-owner@vger.kernel.org>
In-Reply-To: <0a0789a3f776a5248ebc01706d502a3a9823cfac.1515766253.git.green.hu@gmail.com>
Sender: netdev-owner@vger.kernel.org
To: Greentime Hu <green.hu@gmail.com>
Cc: Greentime <greentime@andestech.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-arch <linux-arch@vger.kernel.org>, Thomas Gleixner <tglx@linutronix.de>, Jason Cooper <jason@lakedaemon.net>, Marc Zyngier <marc.zyngier@arm.com>, Rob Herring <robh+dt@kernel.org>, Networking <netdev@vger.kernel.org>, Vincent Chen <deanbo422@gmail.com>, DTML <devicetree@vger.kernel.org>, Al Viro <viro@zeniv.linux.org.uk>, David Howells <dhowells@redhat.com>, Will Deacon <will.deacon@arm.com>, Daniel Lezcano <daniel.lezcano@linaro.org>, linux-serial@vger.kernel.org, Geert Uytterhoeven <geert.uytterhoeven@gmail.com>, Linus Walleij <linus.walleij@linaro.org>, Mark Rutland <mark.rutland@arm.com>, Greg KH <greg@kroah.com>, Guo Ren <ren_guo@c-sky.co>
List-Id: linux-arch.vger.kernel.org

On Mon, Jan 15, 2018 at 6:53 AM, Greentime Hu <green.hu@gmail.com> wrote:
> From: Greentime Hu <greentime@andestech.com>
>
> This patch adds support for loadable modules.

One detail:

You still seem to have both the ELF_REL and ELF_RELA based functions
implemented here, you should drop the unused ELF_REL version:

> diff --git a/arch/nds32/kernel/module.c b/arch/nds32/kernel/module.c
> new file mode 100644
> index 0000000..714a6d6
> --- /dev/null
> +++ b/arch/nds32/kernel/module.c
> @@ -0,0 +1,286 @@
> +// SPDX-License-Identifier: GPL-2.0
> +// Copyright (C) 2005-2017 Andes Technology Corporation
> +
> +#include <linux/module.h>
> +#include <linux/elf.h>
> +#include <linux/vmalloc.h>
> +
> +#include <asm/pgtable.h>

include <linux/moduleloader.h> to catch this.

> +int
> +apply_relocate(Elf32_Shdr * sechdrs, const char *strtab,
> +              unsigned int symindex, unsigned int relsec,
> +              struct module *module)
> +{
> +       return 0;
> +}

and drop this.

With that change,

Acked-by:  Arnd Bergmann <arnd@arndb.de>
