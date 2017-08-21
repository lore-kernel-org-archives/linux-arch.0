From: Rob Herring <robh@kernel.org>
Subject: Re: [PATCH 0/3] devicetree: cleanup and improve DT cross-arch reference
Date: Mon, 21 Aug 2017 12:23:45 -0500
Message-ID: <CAL_JsqL-2RX=BjJNekHa1+88y+D1NPevu6jNSEgmYBY1XfTy5Q@mail.gmail.com>
References: <1500949416-24105-1-git-send-email-yamada.masahiro@socionext.com> <CAK7LNASfxqG7tFRi=RVdshVaNUFcJBHZ-O=DXUm1pMfDXXgcpA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:40264 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753904AbdHURYG (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Mon, 21 Aug 2017 13:24:06 -0400
In-Reply-To: <CAK7LNASfxqG7tFRi=RVdshVaNUFcJBHZ-O=DXUm1pMfDXXgcpA@mail.gmail.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Masahiro Yamada <yamada.masahiro@socionext.com>
Cc: "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, linux-arch <linux-arch@vger.kernel.org>, Omar Sandoval <osandov@osandov.com>, Gaurav Minocha <gaurav.minocha.os@gmail.com>, Grant Likely <grant.likely@linaro.org>, Frank Rowand <frowand.list@gmail.com>, Mark Rutland <mark.rutland@arm.com>, Olof Johansson <olof@lixom.net>, Russell King <linux@armlinux.org.uk>, Michal Marek <mmarek@suse.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>

On Sun, Aug 20, 2017 at 11:06 AM, Masahiro Yamada
<yamada.masahiro@socionext.com> wrote:
> Hi Rob, DT developers,
>
> Any comments for this series?

I've applied the series now.

Rob

>
> Thanks.
>
>
> 2017-07-25 11:23 GMT+09:00 Masahiro Yamada <yamada.masahiro@socionext.com>:
>>
>> Masahiro Yamada (3):
>>   of: remove drivers/of/testcase-data from include search path for CPP
>>   of: remove arch/$(SRCARCH)/boot/dts from include search path for CPP
>>   of: search scripts/dtc/include-prefixes path for both CPP and DTC
>>
>>  scripts/Makefile.lib | 8 ++++----
>>  1 file changed, 4 insertions(+), 4 deletions(-)
>>
>> --
>> 2.7.4
>>
>> --
>> To unsubscribe from this list: send the line "unsubscribe devicetree" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>
>
>
> --
> Best Regards
> Masahiro Yamada
