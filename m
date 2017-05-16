From: Masahiro Yamada <yamada.masahiro-uWyLwvC0a2jby3iVrkZq2A@public.gmane.org>
Subject: Re: [PATCH 2/5] ARM: dts: use #include "..." to include DT in the
 same directory
Date: Tue, 16 May 2017 20:53:17 +0900
Message-ID: <CAK7LNARJGwPfYcEWb7O0OcazWN2i_PsSJ1+vspPAiTnnwUqjnQ@mail.gmail.com>
References: <1494846888-18966-1-git-send-email-yamada.masahiro@socionext.com>
 <1494846888-18966-3-git-send-email-yamada.masahiro@socionext.com> <20170515131048.GW8471@dragon>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20170515131048.GW8471@dragon>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Shawn Guo <shawnguo-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Cc: devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arch <linux-arch-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, Linux Kernel Mailing List <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Russell King <linux-I+IVW8TIWO2tmTQ+vhA3Yw@public.gmane.org>, Gaurav Minocha <gaurav.minocha.os-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Olof Johansson <olof-nZhT3qVonbNeoWH0uzbU5w@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Sascha Hauer <kernel-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>, Grant Likely <grant.likely-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Omar Sandoval <osandov-nWWhXC5lh1RBDgjK7y7TUQ@public.gmane.org>, Frank Rowand <frowand.list-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Fabio Estevam <fabio.estevam-3arQi8VN3Tc@public.gmane.org>, linux-arm-kernel <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
List-Id: linux-arch.vger.kernel.org

Hi Shawn,

2017-05-15 22:10 GMT+09:00 Shawn Guo <shawnguo-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>:
> Hi Masahiro,
>
> On Mon, May 15, 2017 at 08:14:45PM +0900, Masahiro Yamada wrote:
>> Most of DT files in ARM use #include "..." to make pre-processor
>> include DT in the same directory, but we have 3 exceptional files
>> that use #include <...> for that.
>>
>> They must be fixed to remove -I$(srctree)/arch/$(SRCARCH)/boot/dts
>> path from dtc_cpp_flags.
>>
>> Signed-off-by: Masahiro Yamada <yamada.masahiro-uWyLwvC0a2jby3iVrkZq2A@public.gmane.org>
>> ---
>>
>>  arch/arm/boot/dts/imx6q-zii-rdu2.dts  | 4 ++--
>>  arch/arm/boot/dts/imx6qp-zii-rdu2.dts | 4 ++--
>
> I see this patch depends on nothing and can be applied immediately.  But
> versatile-pb.dts is not really in my charge.  In case you want to get
> this series merged by arm-soc folks, here is my ACK:
>
> Acked-by: Shawn Guo <shawnguo-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
>
> Or you need to split versatile-pb.dts out, and then I can take it.
>
> Shawn


This is needed for 4/5:
https://patchwork.kernel.org/patch/9726697/

Probably, no need to rush for this series.

So, perhaps we can apply DT changes for v4.13 (by splitting per-platform),
then Makefile changes for 4.14.

I will wait for comments for a while (if any).





-- 
Best Regards
Masahiro Yamada
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
