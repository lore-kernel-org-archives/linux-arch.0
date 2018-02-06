From: Vincent Chen <deanbo422@gmail.com>
Subject: Re: [PATCH v6 19/36] nds32: VDSO support
Date: Tue, 6 Feb 2018 15:41:16 +0800
Message-ID: <CAJsyPhwHmMrXmN2-NW3ZyvRvTWR0vio_bQO+GDBf30DVp=5LTw@mail.gmail.com>
References: <cover.1515766253.git.green.hu@gmail.com> <4a602db0a58cc858515c3c669d5ac34c567b061c.1515766253.git.green.hu@gmail.com>
 <CAK8P3a0GQDrj+7kc4YB1_ZC1vCWmMtSiYeKsNir_27FvY50Kmg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mail-it0-f68.google.com ([209.85.214.68]:40815 "EHLO
        mail-it0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751835AbeBFHlS (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 6 Feb 2018 02:41:18 -0500
In-Reply-To: <CAK8P3a0GQDrj+7kc4YB1_ZC1vCWmMtSiYeKsNir_27FvY50Kmg@mail.gmail.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Arnd Bergmann <arnd@arndb.de>
Cc: Greentime Hu <green.hu@gmail.com>, Greentime <greentime@andestech.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-arch <linux-arch@vger.kernel.org>, Thomas Gleixner <tglx@linutronix.de>, Jason Cooper <jason@lakedaemon.net>, Marc Zyngier <marc.zyngier@arm.com>, Rob Herring <robh+dt@kernel.org>, Networking <netdev@vger.kernel.org>, DTML <devicetree@vger.kernel.org>, Al Viro <viro@zeniv.linux.org.uk>, David Howells <dhowells@redhat.com>, Will Deacon <will.deacon@arm.com>, Daniel Lezcano <daniel.lezcano@linaro.org>, linux-serial@vger.kernel.org, Geert Uytterhoeven <geert.uytterhoeven@gmail.com>, Linus Walleij <linus.walleij@linaro.org>, Mark Rutland <mark.rutland@arm.com>, Greg KH <greg@kroah.com>, Guo Ren <ren_guo@c-sky.com>

2018-01-18 18:28 GMT+08:00 Arnd Bergmann <arnd@arndb.de>:
> On Mon, Jan 15, 2018 at 6:53 AM, Greentime Hu <green.hu@gmail.com> wrote:
>> From: Greentime Hu <greentime@andestech.com>
>>
>> This patch adds VDSO support. The VDSO code is currently used for
>> sys_rt_sigreturn() and optimised gettimeofday() (using the SoC timer counter).
>>
>> Signed-off-by: Vincent Chen <vincentc@andestech.com>
>> Signed-off-by: Greentime Hu <greentime@andestech.com>
>
> Acked-by: Arnd Bergmann <arnd@arndb.de>

Dear Arnd Bergmann:

We find a small bug here which make LTP 20170929 clock_getres01
fail. The bug is in __vdso_clock_getres() function. When argument res
is NULL, -EFAULT error code is returned now. But, the returned
value is 0 for SyS_clock_getres under the same conditions.
Therefore, testcase thinks it is a bug.

I will modify the code as below and add it in the next version patch
if you think it is OK.

@@ -209,7 +209,7 @@ static notrace int clock_getres_fallback( ...
 {
         if (res == NULL)
-                return -EFAULT;
+                return 0;


Thanks

Vincnet
