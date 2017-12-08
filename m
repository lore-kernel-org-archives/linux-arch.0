Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail-ua0-f181.google.com ([209.85.217.181]:35524 "EHLO
        mail-ua0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750934AbdLHF2g (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 8 Dec 2017 00:28:36 -0500
MIME-Version: 1.0
In-Reply-To: <20171207164506.GE21978@ZenIV.linux.org.uk>
References: <cover.1511785528.git.green.hu@gmail.com> <53789f9af98217d24580479c55e550301651d4a8.1511785528.git.green.hu@gmail.com>
 <20171207164506.GE21978@ZenIV.linux.org.uk>
From: Greentime Hu <green.hu@gmail.com>
Date: Fri, 8 Dec 2017 13:27:54 +0800
Message-ID: <CAEbi=3ecAmu2g_UZCYi8i3NYEVbSfL8dJJh53n97kz8zwCiasA@mail.gmail.com>
Subject: Re: [PATCH v2 08/35] nds32: Process management
Content-Type: text/plain; charset="UTF-8"
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Al Viro <viro@zeniv.linux.org.uk>
Cc: Greentime <greentime@andestech.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Arnd Bergmann <arnd@arndb.de>, linux-arch <linux-arch@vger.kernel.org>, Thomas Gleixner <tglx@linutronix.de>, Jason Cooper <jason@lakedaemon.net>, Marc Zyngier <marc.zyngier@arm.com>, Rob Herring <robh+dt@kernel.org>, netdev <netdev@vger.kernel.org>, Vincent Chen <deanbo422@gmail.com>, DTML <devicetree@vger.kernel.org>, David Howells <dhowells@redhat.com>, Will Deacon <will.deacon@arm.com>, Daniel Lezcano <daniel.lezcano@linaro.org>, linux-serial@vger.kernel.org, Vincent Chen <vincentc@andestech.com>
Message-ID: <20171208052754.B4b9Mp4VJ_chFMvhTi-DycU7WkdRG_gX2ehnjV7pgbk@z>

2017-12-08 0:45 GMT+08:00 Al Viro <viro@zeniv.linux.org.uk>:
> On Mon, Nov 27, 2017 at 08:27:55PM +0800, Greentime Hu wrote:
>
>> +#define start_thread(regs,pc,stack)                  \
>> +({                                                   \
>> +     set_fs(USER_DS);                                \
>
> Not the job of start_thread() - its users (->load_binary() methods of
> assorted binfmt) must (and do) call flush_old_exec() first.  And
> that will switch to USER_DS just fine.

Thanks. I will remove this setting in the next version patch.
