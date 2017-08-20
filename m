From: Masahiro Yamada <yamada.masahiro@socionext.com>
Subject: Re: [PATCH 0/3] devicetree: cleanup and improve DT cross-arch reference
Date: Mon, 21 Aug 2017 01:06:48 +0900
Message-ID: <CAK7LNASfxqG7tFRi=RVdshVaNUFcJBHZ-O=DXUm1pMfDXXgcpA@mail.gmail.com>
References: <1500949416-24105-1-git-send-email-yamada.masahiro@socionext.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from conssluserg-03.nifty.com ([210.131.2.82]:51085 "EHLO
        conssluserg-03.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753095AbdHTQHf (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Sun, 20 Aug 2017 12:07:35 -0400
In-Reply-To: <1500949416-24105-1-git-send-email-yamada.masahiro@socionext.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: devicetree@vger.kernel.org, Rob Herring <robh@kernel.org>
Cc: linux-arch <linux-arch@vger.kernel.org>, Omar Sandoval <osandov@osandov.com>, Gaurav Minocha <gaurav.minocha.os@gmail.com>, Grant Likely <grant.likely@linaro.org>, Frank Rowand <frowand.list@gmail.com>, Mark Rutland <mark.rutland@arm.com>, Olof Johansson <olof@lixom.net>, Russell King <linux@armlinux.org.uk>, Masahiro Yamada <yamada.masahiro@socionext.com>, Michal Marek <mmarek@suse.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>

Hi Rob, DT developers,

Any comments for this series?

Thanks.


2017-07-25 11:23 GMT+09:00 Masahiro Yamada <yamada.masahiro@socionext.com>:
>
> Masahiro Yamada (3):
>   of: remove drivers/of/testcase-data from include search path for CPP
>   of: remove arch/$(SRCARCH)/boot/dts from include search path for CPP
>   of: search scripts/dtc/include-prefixes path for both CPP and DTC
>
>  scripts/Makefile.lib | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
>
> --
> 2.7.4
>
> --
> To unsubscribe from this list: send the line "unsubscribe devicetree" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html



-- 
Best Regards
Masahiro Yamada
