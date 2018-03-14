Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail-io0-f195.google.com ([209.85.223.195]:36141 "EHLO
        mail-io0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751754AbeCNUka (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 14 Mar 2018 16:40:30 -0400
MIME-Version: 1.0
In-Reply-To: <20180314203108.GA18775@isilmar-4.linta.de>
References: <20180314143529.1456168-1-arnd@arndb.de> <20180314144614.1632190-1-arnd@arndb.de>
 <20180314144614.1632190-2-arnd@arndb.de> <20180314203108.GA18775@isilmar-4.linta.de>
From: Arnd Bergmann <arnd@arndb.de>
Date: Wed, 14 Mar 2018 21:40:28 +0100
Message-ID: <CAK8P3a0cwSJCE3oqT5h1xc46mTsH6a6OHB1i5u8m1eshAfOnqQ@mail.gmail.com>
Subject: Re: [PATCH 12/16] asm-generic: siginfo: remove obsolete #ifdefs
Content-Type: text/plain; charset="UTF-8"
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Dominik Brodowski <linux@dominikbrodowski.net>
Cc: linux-arch <linux-arch@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, "Eric W. Biederman" <ebiederm@xmission.com>, Al Viro <viro@zeniv.linux.org.uk>, Thomas Gleixner <tglx@linutronix.de>
Message-ID: <20180314204028.D0r_Cn1E6V0vZzNvQMfljR_1NpCWKv3p-1z2s0oWlc8@z>

On Wed, Mar 14, 2018 at 9:31 PM, Dominik Brodowski
<linux@dominikbrodowski.net> wrote:
> On Wed, Mar 14, 2018 at 03:43:47PM +0100, Arnd Bergmann wrote:
>> The frv, tile and blackfin architectures are being removed, so
>> we can clean up this header by removing all the special cases
>> except those for ia64.
>>
>> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
>
> AFAICS, score is the only architecture which still defines
>
>         __ARCH_WANT_SYSCALL_NO_FLAGS
>         __ARCH_WANT_SYSCALL_OFF_T
>         __ARCH_WANT_SYSCALL_DEPRECATED .
>
> So maybe you want to clean up include/uapi/asm-generic/unistd.h as well?

Definitely. In fact, this was patch 14/16, but for some reason the mail never
made it out. I tried again and it should be there now.

        Arnd
