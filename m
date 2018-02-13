From: Joe Perches <joe@perches.com>
Subject: Re: [PATCH v7 31/37] MAINTAINERS: Add nds32
Date: Tue, 13 Feb 2018 08:02:48 -0800
Message-ID: <1518537768.22190.42.camel@perches.com>
References: <cover.1518505384.git.greentime@andestech.com>
         <f7758221d49fd24fdff7c900aa5951a6c1c6a3cd.1518505384.git.greentime@andestech.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <f7758221d49fd24fdff7c900aa5951a6c1c6a3cd.1518505384.git.greentime@andestech.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Greentime Hu <green.hu@gmail.com>, greentime@andestech.com, linux-kernel@vger.kernel.org, arnd@arndb.de, linux-arch@vger.kernel.org, tglx@linutronix.de, jason@lakedaemon.net, marc.zyngier@arm.com, robh+dt@kernel.org, netdev@vger.kernel.org, deanbo422@gmail.com, devicetree@vger.kernel.org, viro@zeniv.linux.org.uk, dhowells@redhat.com, will.deacon@arm.com, daniel.lezcano@linaro.org, linux-serial@vger.kernel.org, geert.uytterhoeven@gmail.com, linus.walleij@linaro.org, mark.rutland@arm.com, greg@kroah.com, ren_guo@c-sky.com, rdunlap@infradead.org, davem@davemloft.net, jonas@southpole.se, stefan.kristiansson@saunalahti.fi, shorne@gmail.com
List-Id: linux-arch.vger.kernel.org

On Tue, 2018-02-13 at 17:09 +0800, Greentime Hu wrote:
> Add a maintainer information for the nds32(Andes) architecture.
[]
> diff --git a/MAINTAINERS b/MAINTAINERS
[]
> @@ -868,6 +868,17 @@ X:	drivers/iio/*/adjd*
>  F:	drivers/staging/iio/*/ad*
>  F:	drivers/staging/iio/trigger/iio-trig-bfin-timer.c
>  
> +ANDES ARCHITECTURE
> +M:	Greentime Hu <green.hu@gmail.com>
> +M:	Vincent Chen <deanbo422@gmail.com>
> +T:	git https://github.com/andestech/linux.git
> +S:	Supported
> +F:	arch/nds32

This should have a trailing /

F:	arch/nds32/

> +F:	Documentation/devicetree/bindings/interrupt-controller/andestech,ativic32.txt
> +F:	Documentation/devicetree/bindings/nds32
> +K:	nds32

Perhaps this should be

K:	\bnds32

as there are some existing uses of nds32 in the current tree.

or maybe case insensitive like

K:	(?i:\bnds32)
or
K:	(?:\bnds32|\bNDS32)

> +N:	nds32
> +
>  ANDROID CONFIG FRAGMENTS
>  M:	Rob Herring <robh@kernel.org>
>  S:	Supported
