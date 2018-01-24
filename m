Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail-it0-f67.google.com ([209.85.214.67]:36165 "EHLO
        mail-it0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752725AbeAXA4J (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 23 Jan 2018 19:56:09 -0500
MIME-Version: 1.0
In-Reply-To: <CAK8P3a2HR6be9Fm+o1Oq-V5p51xEiuhbyqkgVWprD5BxuU29xQ@mail.gmail.com>
References: <cover.1515766253.git.green.hu@gmail.com> <e145c39b3c50b3aee05bc60ad0117f1ec7cc5153.1515766253.git.green.hu@gmail.com>
 <CAK8P3a2HR6be9Fm+o1Oq-V5p51xEiuhbyqkgVWprD5BxuU29xQ@mail.gmail.com>
From: Vincent Chen <deanbo422@gmail.com>
Date: Wed, 24 Jan 2018 08:56:08 +0800
Message-ID: <CAJsyPhyGpJVQegd7ns9oZOjM=XsGVixCQaH9nT_jOQsSpyRs+g@mail.gmail.com>
Subject: Re: [PATCH v6 20/36] nds32: Signal handling support
Content-Type: text/plain; charset="UTF-8"
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Arnd Bergmann <arnd@arndb.de>
Cc: Greentime Hu <green.hu@gmail.com>, Greentime <greentime@andestech.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-arch <linux-arch@vger.kernel.org>, Thomas Gleixner <tglx@linutronix.de>, Jason Cooper <jason@lakedaemon.net>, Marc Zyngier <marc.zyngier@arm.com>, Rob Herring <robh+dt@kernel.org>, Networking <netdev@vger.kernel.org>, DTML <devicetree@vger.kernel.org>, Al Viro <viro@zeniv.linux.org.uk>, David Howells <dhowells@redhat.com>, Will Deacon <will.deacon@arm.com>, Daniel Lezcano <daniel.lezcano@linaro.org>, linux-serial@vger.kernel.org, Geert Uytterhoeven <geert.uytterhoeven@gmail.com>, Linus Walleij <linus.walleij@linaro.org>, Mark Rutland <mark.rutland@arm.com>, Greg KH <greg@kroah.com>, Guo Ren <ren_guo@c-sky.com>, Randy Dunlap <rdunlap@infradead.org>, David Miller <davem@davemloft.net>, Jonas Bonn <jonas@southpole.se>, Stefan Kristiansson <stefan.kristiansson@saunalahti.fi>, Stafford Horne <shorne@gmail.com>, Vincent Chen <vincentc@andestech.com>
Message-ID: <20180124005608.rhxFBNy_Ixm7BTpIhmXIdIYZF0wTgS1408hzISIhzvE@z>

2018-01-18 18:30 GMT+08:00 Arnd Bergmann <arnd@arndb.de>:
> On Mon, Jan 15, 2018 at 6:53 AM, Greentime Hu <green.hu@gmail.com> wrote:
>> From: Greentime Hu <greentime@andestech.com>
>>
>> This patch adds support for signal handling.
>>
>> Signed-off-by: Vincent Chen <vincentc@andestech.com>
>> Signed-off-by: Greentime Hu <greentime@andestech.com>
>
> I never feel qualified enough to properly review signal handling code, so
> no Ack from me for this code even though I don't see anything wrong with it.
> Hopefully someone else can give an Ack after looking more closely.
>
>        Arnd

Dear Arnd:

We'd be glad to improve signal handling code to meet your requirement.
Could you
tell us which part we need to refine or which implementation is good
for us to refer?

Thanks.

Vincent
