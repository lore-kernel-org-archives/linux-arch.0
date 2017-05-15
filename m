From: Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH] devicetree: Move include prefixes from arch to separate directory
Date: Mon, 15 May 2017 09:47:40 -0500
Message-ID: <CAL_JsqJzoe_xNxMOZ88+k+bZ+bSK6-j30HXk0ZsFxHUqVDzwzw@mail.gmail.com>
References: <CAL_JsqKLxA8K8378z4nDBkDWnwM_zBbbf9D7EPtwQ1782dydTw@mail.gmail.com>
 <20170515142641.GU22219@n2100.armlinux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20170515142641.GU22219-l+eeeJia6m9URfEZ8mYm6t73F7V6hmMc@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Russell King - ARM Linux <linux-I+IVW8TIWO2tmTQ+vhA3Yw@public.gmane.org>
Cc: Olof Johansson <olof-nZhT3qVonbNeoWH0uzbU5w@public.gmane.org>, "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org" <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>, "devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Heiko Stuebner <heiko-4mtYJXux2i+zQB+pC5nmwQ@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, Catalin Marinas <catalin.marinas-5wv7dgnIgG8@public.gmane.org>, Will Deacon <will.deacon-5wv7dgnIgG8@public.gmane.org>, Mikael Starvik <starvik-VrBV9hrLPhE@public.gmane.org>, Jesper Nilsson <jesper.nilsson-VrBV9hrLPhE@public.gmane.org>, James Hogan <james.hogan-1AXoQHu6uovQT0dZR+AlfA@public.gmane.org>, Ralf Baechle <ralf-6z/3iImG2C8G8FEW9MqTrA@public.gmane.org>, Benjamin Herrenschmidt <benh-XVmvHMARGAS8U2dJNN8I7kB+6BGkLq7r@public.gmane.org>, Paul Mackerras <paulus-eUNUBHrolfbYtjvyW6yDsg@public.gmane.org>, Michael Ellerman <mpe-Gsx/Oe8HsFggBc27wqDAHg@public.gmane.org>, Frank Rowand <frowand.list-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, linux-arch <linux-arch-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: linux-arch.vger.kernel.org

On Mon, May 15, 2017 at 9:26 AM, Russell King - ARM Linux
<linux-I+IVW8TIWO2tmTQ+vhA3Yw@public.gmane.org> wrote:
> On Mon, May 15, 2017 at 08:01:07AM -0500, Rob Herring wrote:
>> I'd prefer not to mix things in scripts/dtc that aren't the import of
>> dtc (yes, we do have a few other things already, but they are at least
>> scripts). Couldn't this go in include/dt-bindings/ instead?
>
> I don't think that works.
>
> The include path used is "include", which means that we force people
> to use:
>
> #include <dt-bindings/foo.dtsi>

No, I was thinking you'd add include/dt-bindings/include-prefix/ to
the include path instead of scripts/dtc/include-prefix/. The only
downside I can see is people could mistakenly do:

#include <dt-bindings/include-prefix/$arch/foo.dtsi>

>
> in their DT files.  This means that we'd need to populate $topdir/include
> with per-architecture symlinks on top of the 26 or so directories already
> there, so that:
>
> #include <arch/foo.dtsi>
>
> would work.  That's quite horrible, since $topdir/include is the main
> include path for C headers.
>
> I guess we could have symlinks inside include/dt-bindings, but that
> makes the includes:
>
> #include <dt-bindings/arch/foo.dtsi>
>
> but that's rather absurd because these _aren't_ dt-binding definitions.

True, but the same can be said that "scripts/dtc" is not includes nor
kernel build infrastructure.

> Maybe what we should do is:
>
> mkdir include/dt
> git mv include/dt-bindings include/dt
> for arch in arch/*; do
>   dts=$arch/boot/dts
>   if [ -d $dts ]; then
>      a=include/dt/$(basename $arch)
>      ln -s $dts $a
>      git add $a
>   fi
> done
> ... fixup scripts/Makefile.lib ...
> git commit

That would just break every existing include in dts files.

Another idea. Could kbuild create all the symlinks at build time instead?

Rob
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
