From: Arnd Bergmann <arnd-r2nGTMty4D4@public.gmane.org>
Subject: Re: [PATCH v2 16/35] nds32: Signal handling support
Date: Mon, 27 Nov 2017 15:37:13 +0100
Message-ID: <CAK8P3a1sqhLwz3WqM0Qx4w0SBWqFWMuXVgX4p9StpacfWdSnUA@mail.gmail.com>
References: <cover.1511785528.git.green.hu@gmail.com> <21cfd623872d4377ba5064cb7302bff49ebf917e.1511785528.git.green.hu@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <21cfd623872d4377ba5064cb7302bff49ebf917e.1511785528.git.green.hu-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Greentime Hu <green.hu-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: Greentime <greentime-MUIXKm3Oiri1Z/+hSey0Gg@public.gmane.org>, Linux Kernel Mailing List <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, linux-arch <linux-arch-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Thomas Gleixner <tglx-hfZtesqFncYOwBW4kG4KsQ@public.gmane.org>, Jason Cooper <jason-NLaQJdtUoK4Be96aLqz0jA@public.gmane.org>, Marc Zyngier <marc.zyngier-5wv7dgnIgG8@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Networking <netdev-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Vincent Chen <deanbo422-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, DTML <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Al Viro <viro-RmSDqhL/yNMiFSDQTTA3OLVCufUGDwFn@public.gmane.org>, David Howells <dhowells-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, Will Deacon <will.deacon-5wv7dgnIgG8@public.gmane.org>, Daniel Lezcano <daniel.lezcano-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, linux-serial-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Vincent Chen <vincentc-MUIXKm3Oiri1Z/+hSey0Gg@public.gmane.org>
List-Id: linux-arch.vger.kernel.org

On Mon, Nov 27, 2017 at 1:28 PM, Greentime Hu <green.hu-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org> wrote:

> +#ifndef _ASMNDS32_SIGNAL_H
> +#define _ASMNDS32_SIGNAL_H
> +
> +#define SA_RESTORER    0x04000000
> +
> +#include <asm-generic/signal.h>
> +#endif

As documented in asm-generic/signal.h, new architectures should not define
SA_RESTORER.

        Arnd
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
