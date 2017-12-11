From: Marc Zyngier <marc.zyngier-5wv7dgnIgG8@public.gmane.org>
Subject: Re: [PATCH v3 32/33] irqchip: Andestech Internal Vector Interrupt
 Controller driver
Date: Mon, 11 Dec 2017 09:16:11 +0000
Message-ID: <fed9bc8a-4a07-59ca-1e8b-9007d5ce3acd@arm.com>
References: <cover.1512723245.git.green.hu@gmail.com>
 <4fb7bd1cd2619287061fd68a38a774c8aef7dbe9.1512723245.git.green.hu@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <4fb7bd1cd2619287061fd68a38a774c8aef7dbe9.1512723245.git.green.hu-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Content-Language: en-GB
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Greentime Hu <green.hu-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, greentime-MUIXKm3Oiri1Z/+hSey0Gg@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, arnd-r2nGTMty4D4@public.gmane.org, linux-arch-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, tglx-hfZtesqFncYOwBW4kG4KsQ@public.gmane.org, jason-NLaQJdtUoK4Be96aLqz0jA@public.gmane.org, robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, netdev-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, deanbo422-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, viro-RmSDqhL/yNMiFSDQTTA3OLVCufUGDwFn@public.gmane.org, dhowells-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org, will.deacon-5wv7dgnIgG8@public.gmane.org, daniel.lezcano-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, linux-serial-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, geert.uytterhoeven-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, linus.walleij-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, mark.rutland-5wv7dgnIgG8@public.gmane.org, greg-U8xfFu+wG4EAvxtiuMwx3w@public.gmane.org
Cc: Rick Chen <rick-MUIXKm3Oiri1Z/+hSey0Gg@public.gmane.org>
List-Id: linux-arch.vger.kernel.org

On 08/12/17 09:12, Greentime Hu wrote:
> From: Greentime Hu <greentime-MUIXKm3Oiri1Z/+hSey0Gg@public.gmane.org>
> 
> This patch adds the Andestech Internal Vector Interrupt Controller
> driver. You can find the spec here. Ch4.9 of AndeStar SPA V3 Manual.
> http://www.andestech.com/product.php?cls=9
> 
> Signed-off-by: Rick Chen <rick-MUIXKm3Oiri1Z/+hSey0Gg@public.gmane.org>
> Signed-off-by: Greentime Hu <greentime-MUIXKm3Oiri1Z/+hSey0Gg@public.gmane.org>

Reviewed-by: Marc Zyngier <marc.zyngier-5wv7dgnIgG8@public.gmane.org>

Once there is an agreement on this series being fit for mainline, let me
know how you want to get this merged (either as a whole series, or with
this driver going through the irq tree).

Thanks,

	M.
-- 
Jazz is not dead. It just smells funny...
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
