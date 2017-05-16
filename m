Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from conssluserg-03.nifty.com ([210.131.2.82]:44841 "EHLO
        conssluserg-03.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751156AbdEPLx3 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 16 May 2017 07:53:29 -0400
MIME-Version: 1.0
In-Reply-To: <20170515131048.GW8471@dragon>
References: <1494846888-18966-1-git-send-email-yamada.masahiro@socionext.com>
 <1494846888-18966-3-git-send-email-yamada.masahiro@socionext.com> <20170515131048.GW8471@dragon>
From: Masahiro Yamada <yamada.masahiro@socionext.com>
Date: Tue, 16 May 2017 20:53:17 +0900
Message-ID: <CAK7LNARJGwPfYcEWb7O0OcazWN2i_PsSJ1+vspPAiTnnwUqjnQ@mail.gmail.com>
Subject: Re: [PATCH 2/5] ARM: dts: use #include "..." to include DT in the
 same directory
Content-Type: text/plain; charset="UTF-8"
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Shawn Guo <shawnguo@kernel.org>
Cc: devicetree@vger.kernel.org, linux-arch <linux-arch@vger.kernel.org>, Mark Rutland <mark.rutland@arm.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Russell King <linux@armlinux.org.uk>, Gaurav Minocha <gaurav.minocha.os@gmail.com>, Olof Johansson <olof@lixom.net>, Rob Herring <robh+dt@kernel.org>, Sascha Hauer <kernel@pengutronix.de>, Grant Likely <grant.likely@linaro.org>, Omar Sandoval <osandov@osandov.com>, Frank Rowand <frowand.list@gmail.com>, Fabio Estevam <fabio.estevam@nxp.com>, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>
Message-ID: <20170516115317.nDqbtu_5Ab5-M8bAI_QHfkq5gAulJiTyDQQNQRhbLtc@z>

Hi Shawn,

2017-05-15 22:10 GMT+09:00 Shawn Guo <shawnguo@kernel.org>:
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
>> Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
>> ---
>>
>>  arch/arm/boot/dts/imx6q-zii-rdu2.dts  | 4 ++--
>>  arch/arm/boot/dts/imx6qp-zii-rdu2.dts | 4 ++--
>
> I see this patch depends on nothing and can be applied immediately.  But
> versatile-pb.dts is not really in my charge.  In case you want to get
> this series merged by arm-soc folks, here is my ACK:
>
> Acked-by: Shawn Guo <shawnguo@kernel.org>
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
