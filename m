Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail-ua0-f196.google.com ([209.85.217.196]:39256 "EHLO
        mail-ua0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753285AbdK1C4E (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 27 Nov 2017 21:56:04 -0500
MIME-Version: 1.0
In-Reply-To: <CAK8P3a2GJERt78uWgdDy+Azr-ZMcOcB+D6Akq99tSfwKmt2LiA@mail.gmail.com>
References: <cover.1511785528.git.green.hu@gmail.com> <1aa759dbbb1032dd20e5fadbb0ce5aa4b8b22690.1511785528.git.green.hu@gmail.com>
 <CAK8P3a2GJERt78uWgdDy+Azr-ZMcOcB+D6Akq99tSfwKmt2LiA@mail.gmail.com>
From: Greentime Hu <green.hu@gmail.com>
Date: Tue, 28 Nov 2017 10:55:23 +0800
Message-ID: <CAEbi=3ccsD9KAE8hUgJYATA0Dbg3P7xgR-wXy_bHw-3TeE-k=Q@mail.gmail.com>
Subject: Re: [PATCH v2 30/35] net: faraday add nds32 support.
Content-Type: text/plain; charset="UTF-8"
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Arnd Bergmann <arnd@arndb.de>
Cc: Greentime <greentime@andestech.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-arch <linux-arch@vger.kernel.org>, Thomas Gleixner <tglx@linutronix.de>, Jason Cooper <jason@lakedaemon.net>, Marc Zyngier <marc.zyngier@arm.com>, Rob Herring <robh+dt@kernel.org>, Networking <netdev@vger.kernel.org>, Vincent Chen <deanbo422@gmail.com>, DTML <devicetree@vger.kernel.org>, Al Viro <viro@zeniv.linux.org.uk>, David Howells <dhowells@redhat.com>, Will Deacon <will.deacon@arm.com>, Daniel Lezcano <daniel.lezcano@linaro.org>, linux-serial@vger.kernel.org
Message-ID: <20171128025523.ErmqtELnlZx3-yYU9MpN3E6jSDOjG4fUlE9-YnpjYzM@z>

2017-11-27 22:15 GMT+08:00 Arnd Bergmann <arnd@arndb.de>:
> On Mon, Nov 27, 2017 at 1:28 PM, Greentime Hu <green.hu@gmail.com> wrote:
>> From: Greentime Hu <greentime@andestech.com>
>>
>> Signed-off-by: Greentime Hu <greentime@andestech.com>
>
> This is missing a patch description.
>

Thanks.
Sorry. I miss it. I will add the commit messages in the next version patch.

>> diff --git a/drivers/net/ethernet/faraday/Kconfig b/drivers/net/ethernet/faraday/Kconfig
>> index 040c7f1..0ae6e9a 100644
>> --- a/drivers/net/ethernet/faraday/Kconfig
>> +++ b/drivers/net/ethernet/faraday/Kconfig
>> @@ -5,7 +5,7 @@
>>  config NET_VENDOR_FARADAY
>>         bool "Faraday devices"
>>         default y
>> -       depends on ARM
>> +       depends on ARM || NDS32
>>         ---help---
>>           If you have a network (Ethernet) card belonging to this class, say Y.
>>
>
> We probably want to make all three here
>
> depends on ARM || NDS32 || COMPILE_TEST
>

Thanks.
I will modify it in the next version patch.
