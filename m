From: Geert Uytterhoeven <geert-Td1EMuHUCqxL1ZNQvxDV9g@public.gmane.org>
Subject: Re: [PATCH] devicetree: Move include prefixes from arch to separate directory
Date: Wed, 17 May 2017 16:22:28 +0200
Message-ID: <CAMuHMdVQPB57dckRDjjLLocE4=0J4fQZQux9LJoV6xzZW16eKA@mail.gmail.com>
References: <CAL_JsqKLxA8K8378z4nDBkDWnwM_zBbbf9D7EPtwQ1782dydTw@mail.gmail.com>
 <20170515142641.GU22219@n2100.armlinux.org.uk> <CAL_JsqJzoe_xNxMOZ88+k+bZ+bSK6-j30HXk0ZsFxHUqVDzwzw@mail.gmail.com>
 <CAOesGMgYDq5Sdk6OaK-mTyfdNGwcbgOVeKbeMSCOmwqd9k8TGQ@mail.gmail.com>
 <CAL_JsqJCjwvvta0n7dNpyVZkK5hp25fYO78q_pQZzUAPRDq+-w@mail.gmail.com> <CAOesGMh3UxHPYQ7SDG7+NODuT5TnP_i23ru0ZRR-rOYxbOGe_g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <CAOesGMh3UxHPYQ7SDG7+NODuT5TnP_i23ru0ZRR-rOYxbOGe_g-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Olof Johansson <olof-nZhT3qVonbNeoWH0uzbU5w@public.gmane.org>
Cc: Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Russell King - ARM Linux <linux-I+IVW8TIWO2tmTQ+vhA3Yw@public.gmane.org>, "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org" <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>, "devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Heiko Stuebner <heiko-4mtYJXux2i+zQB+pC5nmwQ@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, Catalin Marinas <catalin.marinas-5wv7dgnIgG8@public.gmane.org>, Will Deacon <will.deacon-5wv7dgnIgG8@public.gmane.org>, Mikael Starvik <starvik-VrBV9hrLPhE@public.gmane.org>, Jesper Nilsson <jesper.nilsson-VrBV9hrLPhE@public.gmane.org>, James Hogan <james.hogan-1AXoQHu6uovQT0dZR+AlfA@public.gmane.org>, Ralf Baechle <ralf-6z/3iImG2C8G8FEW9MqTrA@public.gmane.org>, Benjamin Herrenschmidt <benh-XVmvHMARGAS8U2dJNN8I7kB+6BGkLq7r@public.gmane.org>, Paul Mackerras <paulus-eUNUBHrolfbYtjvyW6yDsg@public.gmane.org>, Michael Ellerman <mpe-Gsx/Oe8HsFggBc27wqDAHg@public.gmane.org>, Frank Rowand <frowand.list-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>li
List-Id: linux-arch.vger.kernel.org

Hi Olof,

On Mon, May 15, 2017 at 6:09 PM, Olof Johansson <olof-nZhT3qVonbNeoWH0uzbU5w@public.gmane.org> wrote:
>> The only other comment I would have is at some point, we're going to
>> have overlays that aren't tied to any arch. Where are we going to put
>> those? Maybe they are tied to some vendor which tends to have most
>> stuff in $arch and we just continue this band-aid. Or we define some
>> common location. I bring this up now only because both could use that
>> location.
>
> Those are good questions. What kind of common overlays are you
> anticipating? Things like fragments describing connectors, etc?

I'm mostly using overlays to describe custom test hardware that
is connection to expansion connectors on standard development boards.
These fall into one of two classes:
  1. Overlays enabling an on-SoC device and configuring access to it from
     an expansion connector,
  2. Overlays describing hardware connected to a device from class1.

Class 1 overlays are SoC and board-specific, so they belong in e.g.
arch/arm/boot/dts/.
Class 2 overlays are more universal (depending on what they extend; Pantelis'
connectors work may help here), so they can be shared between architectures.

Other people may have other use cases.

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert-Td1EMuHUCqxL1ZNQvxDV9g@public.gmane.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
