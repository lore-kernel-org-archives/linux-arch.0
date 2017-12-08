From: Mark Rutland <mark.rutland@arm.com>
Subject: Re: [PATCH v3 17/33] nds32: VDSO support
Date: Fri, 8 Dec 2017 12:14:06 +0000
Message-ID: <20171208121405.dy6raczdlbxtbnfo@lakrids.cambridge.arm.com>
References: <cover.1512723245.git.green.hu@gmail.com>
 <921ccfa97c4c13f12c7b22b9554f52dcce51f87e.1512723245.git.green.hu@gmail.com>
 <20171208102149.iqiieszktwzorkuw@lakrids.cambridge.arm.com>
 <CAEbi=3e9Ep4_DL4SSwp15as1t7ALvw-s2gqv+NsuRZiebNGFAQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <CAEbi=3e9Ep4_DL4SSwp15as1t7ALvw-s2gqv+NsuRZiebNGFAQ@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Greentime Hu <green.hu@gmail.com>
Cc: Greentime <greentime@andestech.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Arnd Bergmann <arnd@arndb.de>, linux-arch <linux-arch@vger.kernel.org>, Thomas Gleixner <tglx@linutronix.de>, Jason Cooper <jason@lakedaemon.net>, Marc Zyngier <marc.zyngier@arm.com>, Rob Herring <robh+dt@kernel.org>, netdev <netdev@vger.kernel.org>, Vincent Chen <deanbo422@gmail.com>, DTML <devicetree@vger.kernel.org>, Al Viro <viro@zeniv.linux.org.uk>, David Howells <dhowells@redhat.com>, Will Deacon <will.deacon@arm.com>, Daniel Lezcano <daniel.lezcano@linaro.org>, linux-serial@vger.kernel.org, Geert Uytterhoeven <geert.uytterhoeven@gmail.com>, Linus Walleij <linus.walleij@linaro.org>, Greg KH <greg@kroah.com>, Vincent Chen <vincentc@andestech.co>
List-Id: linux-arch.vger.kernel.org

On Fri, Dec 08, 2017 at 07:54:42PM +0800, Greentime Hu wrote:
> 2017-12-08 18:21 GMT+08:00 Mark Rutland <mark.rutland@arm.com>:
> > On Fri, Dec 08, 2017 at 05:12:00PM +0800, Greentime Hu wrote:
> >> +static int grab_timer_node_info(void)
> >> +{
> >> +     struct device_node *timer_node;
> >> +
> >> +     timer_node = of_find_node_by_name(NULL, "timer");
> >
> > Please use a compatible string, rather than matching the timer by name.
> >
> > It's plausible that you have multiple nodes called "timer" in the DT,
> > under different parent nodes, and this might not be the device you
> > think it is. I see your dt in patch 24 has two timer nodes.
> >
> > It would be best if your clocksource driver exposed some stuct that you
> > looked at here, so that you're guaranteed to user the same device.
> 
> We'd like to use "timer" here because there are 2 different timer IPs
> and we are sure that they won't be in the same SoC.
> We think this implementation in VDSO should be platform independent to
> get cycle-count register.
> Our customer or other SoC provider who can use "timer" and define
> cycle-count-offset or cycle-count-down then we can get the correct
> cycle-count.

This is not the right way to do things.

So from a DT perspective, NAK. 

You should not add properties to arbitrary DT bindings to handle a Linux
implementation detail.

Please remove this DT code, and have the drivers for those timer blocks
export this information to your vdso code somehow.

> We sent atcpit100 patch last time along with our arch, however we'd
> like to send it to its sub system this time and my colleague is still
> working on it.
> He may send the timer patch next week.

I think that it would make sense for that patch to be part of the arch
port, especially given that (AFAICT) there is no dirver for the other
timer IP that you mention.

[...]

> >> +int arch_setup_additional_pages(struct linux_binprm *bprm, int uses_interp)
> >> +{
> >
> >> +     /*Map timer to user space */
> >> +     vdso_base += PAGE_SIZE;
> >> +     prot = __pgprot(_PAGE_V | _PAGE_M_UR_KR | _PAGE_D |
> >> +                     _PAGE_G | _PAGE_C_DEV);
> >> +     ret = io_remap_pfn_range(vma, vdso_base, timer_res.start >> PAGE_SHIFT,
> >> +                              PAGE_SIZE, prot);
> >> +     if (ret)
> >> +             goto up_fail;
> >
> > Maybe this is fine, but it looks a bit suspicious.
> >
> > Is it safe to map IO memory to a userspace process like this?
> >
> > In general that isn't safe, since userspace could access other registers
> > (if those exist), perform accesses that change the state of hardware, or
> > make unsupported access types (e.g. unaligned, atomic) that result in
> > errors the kernel can't handle.
> >
> > Does none of that apply here?
> 
> We only provide read permission to this page so hareware state won't
> be chagned. It will trigger exception if we try to write.
> We will check about the alignment/atomic issue of this region.

Ok, thanks.

This is another reason to only do this for devices/drivers that we have
drivers for, since we can't know that this is safe in general.

Thanks,
Mark.
