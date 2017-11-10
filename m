From: Greentime Hu <green.hu-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH 30/31] dt-bindings: nds32 CPU Bindings
Date: Fri, 10 Nov 2017 16:43:11 +0800
Message-ID: <CAEbi=3evxbZ-K--fkuZu_ANfiuoChT=AmRUfEyJ0htK3cy9wdQ@mail.gmail.com>
References: <cover.1510118606.git.green.hu@gmail.com> <1a8efba0727437d510d10755f3fcea806833651d.1510118606.git.green.hu@gmail.com>
 <CAL_JsqJAtTSGg=yGvANGdTCWa4tDAicvOvWYr4pK5M1rjPFtfg@mail.gmail.com>
 <CAEbi=3e-hRbej7EZ68-J1YPNfdxu7O_BAZ1rvZvAhhYzAT09-g@mail.gmail.com>
 <CABGGisw5gi92aM0_tZ0htOzwZTFJpcSNZUJth5TzRXPxzssRxA@mail.gmail.com>
 <CAEbi=3eus0ZEyFaNbS_a8bDOfH3aK_FB2ckATm-ELzPZT0MJ_Q@mail.gmail.com> <CAK8P3a1k_zNN6FTRNm5kfun8Nb+3ZLtmCLjHOVZUFB10TqQBFQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <CAK8P3a1k_zNN6FTRNm5kfun8Nb+3ZLtmCLjHOVZUFB10TqQBFQ-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Arnd Bergmann <arnd-r2nGTMty4D4@public.gmane.org>
Cc: Rob Herring <robh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Greentime <greentime-MUIXKm3Oiri1Z/+hSey0Gg@public.gmane.org>, "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-arch-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-arch-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Thomas Gleixner <tglx-hfZtesqFncYOwBW4kG4KsQ@public.gmane.org>, Jason Cooper <jason-NLaQJdtUoK4Be96aLqz0jA@public.gmane.org>, Marc Zyngier <marc.zyngier-5wv7dgnIgG8@public.gmane.org>, netdev <netdev-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Vincent Chen <vincentc-MUIXKm3Oiri1Z/+hSey0Gg@public.gmane.org>, Rick Chen <rick-MUIXKm3Oiri1Z/+hSey0Gg@public.gmane.org>, Zong Li <zong-MUIXKm3Oiri1Z/+hSey0Gg@public.gmane.org>, "devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: linux-arch.vger.kernel.org

>>> Then having both is not valid. The strings should be in order of best
>>> match to worst match where worst match is typically either older
>>> implementations of IP blocks or generic'ish strings such as "ns16550"
>>> for a UART.
>>
>> Thanks.
>> I would like to explain it more clearly.
>> They are independent ones in implementations.
>> They are implemented based on the same nds32 ISA and architecture spec
>> with different configurations
>> like cache size, page size, cache type(VIPT/PIPT), pipeline stages...
>> Most of them are compatible.
>> They use the same toolchain to build vmlinux which can run on
>> different nds32 cores.
>
> Du you have a name for the ISA spec that distinguishes it from other nds32
> versions that are incompatible? If you do, this could be written like
>
> compatible = "andestech,n13", "andestech,nds32v3.0";
>
> to signify that a an 'n13' core implements the 'v3.0' ISA (will it
> whatever you call the ISA in reality).
>

Thanks. I got you.
I will use a proper name(maybe 'nds32v3') of ISA in this compatible
string in the next version patch.
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
