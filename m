From: Olof Johansson <olof-nZhT3qVonbNeoWH0uzbU5w@public.gmane.org>
Subject: Re: [PATCH] devicetree: Move include prefixes from arch to separate directory
Date: Mon, 15 May 2017 10:04:08 -0700
Message-ID: <CAOesGMjrjRTBTxN8_DGp6WUJk8hy5WnzCcxi+fUz446_Uk5JwQ@mail.gmail.com>
References: <CAL_JsqKLxA8K8378z4nDBkDWnwM_zBbbf9D7EPtwQ1782dydTw@mail.gmail.com>
 <20170515142641.GU22219@n2100.armlinux.org.uk> <CAL_JsqJzoe_xNxMOZ88+k+bZ+bSK6-j30HXk0ZsFxHUqVDzwzw@mail.gmail.com>
 <CAOesGMgYDq5Sdk6OaK-mTyfdNGwcbgOVeKbeMSCOmwqd9k8TGQ@mail.gmail.com> <20170515154845.GW22219@n2100.armlinux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20170515154845.GW22219-l+eeeJia6m9URfEZ8mYm6t73F7V6hmMc@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Russell King - ARM Linux <linux-I+IVW8TIWO2tmTQ+vhA3Yw@public.gmane.org>
Cc: Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org" <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>, "devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Heiko Stuebner <heiko-4mtYJXux2i+zQB+pC5nmwQ@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, Catalin Marinas <catalin.marinas-5wv7dgnIgG8@public.gmane.org>, Will Deacon <will.deacon-5wv7dgnIgG8@public.gmane.org>, Mikael Starvik <starvik-VrBV9hrLPhE@public.gmane.org>, Jesper Nilsson <jesper.nilsson-VrBV9hrLPhE@public.gmane.org>, James Hogan <james.hogan-1AXoQHu6uovQT0dZR+AlfA@public.gmane.org>, Ralf Baechle <ralf-6z/3iImG2C8G8FEW9MqTrA@public.gmane.org>, Benjamin Herrenschmidt <benh-XVmvHMARGAS8U2dJNN8I7kB+6BGkLq7r@public.gmane.org>, Paul Mackerras <paulus-eUNUBHrolfbYtjvyW6yDsg@public.gmane.org>, Michael Ellerman <mpe-Gsx/Oe8HsFggBc27wqDAHg@public.gmane.org>, Frank Rowand <frowand.list-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, linux-arch <linux-arch-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: linux-arch.vger.kernel.org

On Mon, May 15, 2017 at 8:48 AM, Russell King - ARM Linux
<linux-I+IVW8TIWO2tmTQ+vhA3Yw@public.gmane.org> wrote:
> On Mon, May 15, 2017 at 08:27:54AM -0700, Olof Johansson wrote:
>> On Mon, May 15, 2017 at 7:47 AM, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org> wrote:
>> > On Mon, May 15, 2017 at 9:26 AM, Russell King - ARM Linux
>> > <linux-I+IVW8TIWO2tmTQ+vhA3Yw@public.gmane.org> wrote:
>> >> Maybe what we should do is:
>> >>
>> >> mkdir include/dt
>> >> git mv include/dt-bindings include/dt
>> >> for arch in arch/*; do
>> >>   dts=$arch/boot/dts
>> >>   if [ -d $dts ]; then
>> >>      a=include/dt/$(basename $arch)
>> >>      ln -s $dts $a
>> >>      git add $a
>> >>   fi
>> >> done
>> >> ... fixup scripts/Makefile.lib ...
>> >> git commit
>> >
>> > That would just break every existing include in dts files.
>>
>> It doesn't break dts includes if done together with a change in -I,
>> but it might break includes from the driver side (or needs another -I
>> there).
>
> Good point.
>
> We could leave include/dt-bindings where it is, and just do the rest of
> it for the cross-arch includes.  Slightly less tidy but should have a
> lower impact.

I think you're proposing this?
include/dt-bindings
include/dt/$arch -> ../../arch/$arch/boot/dts/

And then having -I$(srctree)include/dt as argument to dtc?

That'd work but have the same drawback as I mentioned to Rob about
having several -I statements at different levels of the include
hierarchy, the same file could be reached through <dt/$arch/> and
<$arch/>. Not a showstopper but since Rob seems to be OK with the link
hierarchy living under scripts/dtc, I'd prefer to just stick to that.

This is all pretty isolated, and if we want to move it somewhere else
later for some reason, we should be able to do so without impacting
DTS and drivers.


-Olof
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
