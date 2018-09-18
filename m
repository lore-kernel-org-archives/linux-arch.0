Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail-yb1-f195.google.com ([209.85.219.195]:35267 "EHLO
        mail-yb1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726736AbeIRRRO (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 18 Sep 2018 13:17:14 -0400
Received: by mail-yb1-f195.google.com with SMTP id o63-v6so661200yba.2
        for <linux-arch@vger.kernel.org>; Tue, 18 Sep 2018 04:45:01 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <CAK8P3a2qFoCOzM6x-_mv0Um2E-WHDeOU-fuuZ65TtDKKcPxNrQ@mail.gmail.com>
References: <1536036087-15260-1-git-send-email-firoz.khan@linaro.org>
 <1536036087-15260-5-git-send-email-firoz.khan@linaro.org> <CAK8P3a2qFoCOzM6x-_mv0Um2E-WHDeOU-fuuZ65TtDKKcPxNrQ@mail.gmail.com>
From: Firoz Khan <firoz.khan@linaro.org>
Date: Tue, 18 Sep 2018 17:15:00 +0530
Message-ID: <CALxhOngr6KY+CijcMx8f6Kg=SK3wJK_wxV6Z-HPWYpQ6h5iJog@mail.gmail.com>
Subject: Re: [PATCH 4/4] sparc: uapi header and system call table file generation
Content-Type: text/plain; charset="UTF-8"
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Arnd Bergmann <arnd@arndb.de>
Cc: David Miller <davem@davemloft.net>, sparclinux <sparclinux@vger.kernel.org>, gregkh <gregkh@linuxfoundation.org>, Philippe Ombredanne <pombredanne@nexb.com>, Thomas Gleixner <tglx@linutronix.de>, Kate Stewart <kstewart@linuxfoundation.org>, y2038 Mailman List <y2038@lists.linaro.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-arch <linux-arch@vger.kernel.org>, Deepa Dinamani <deepa.kernel@gmail.com>, Marcin Juszkiewicz <marcin.juszkiewicz@linaro.org>
Message-ID: <20180918114500.T1Ltm6VRrSuhEDmNRIQq0tXWCnbd_acnWmhnYyTUgjE@z>

On 6 September 2018 at 21:04, Arnd Bergmann <arnd@arndb.de> wrote:
> On Tue, Sep 4, 2018 at 6:42 AM Firoz Khan <firoz.khan@linaro.org> wrote:
>>
>> System call table generation script must be run to generate
>> unistd_32/64.h and syscall_table_32/64/c32.h files. This patch
>> will have changes which will invokes the script.
>>
>> This patch will generate unistd_32/64.h and syscall_table_
>> 32/64/c32.h files by the syscall table generation script
>> invoked by arch/sparc/Makefile and the generated files against
>> the removed files will be identical.
>>
>> The generated uapi header file will be included in uapi/asm/
>> unistd_32/64.h and generated system call table support file will
>> be included by arch/sparc/kernel/syscall_table_32/64.S file.
>
> These changes all look good to me.
>
>        Arnd

Thanks for your reply!

- Firoz
