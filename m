Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail-qk0-f195.google.com ([209.85.220.195]:40409 "EHLO
        mail-qk0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1030381AbeBNOc5 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 14 Feb 2018 09:32:57 -0500
MIME-Version: 1.0
In-Reply-To: <7f9139c13f0f84091245b8f5c70ba5d4308e8b36.1518505384.git.greentime@andestech.com>
References: <cover.1518505384.git.greentime@andestech.com> <7f9139c13f0f84091245b8f5c70ba5d4308e8b36.1518505384.git.greentime@andestech.com>
From: Arnd Bergmann <arnd@arndb.de>
Date: Wed, 14 Feb 2018 15:32:54 +0100
Message-ID: <CAK8P3a3S=q6cHsj4ge8jjm0Pbu6dgKhMfy1Gqk=pWoudKHaZVA@mail.gmail.com>
Subject: Re: [PATCH v7 23/37] nds32: Debugging support
Content-Type: text/plain; charset="UTF-8"
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Greentime Hu <green.hu@gmail.com>
Cc: Greentime <greentime@andestech.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-arch <linux-arch@vger.kernel.org>, Thomas Gleixner <tglx@linutronix.de>, Jason Cooper <jason@lakedaemon.net>, Marc Zyngier <marc.zyngier@arm.com>, Rob Herring <robh+dt@kernel.org>, Networking <netdev@vger.kernel.org>, Vincent Chen <deanbo422@gmail.com>, DTML <devicetree@vger.kernel.org>, Al Viro <viro@zeniv.linux.org.uk>, David Howells <dhowells@redhat.com>, Will Deacon <will.deacon@arm.com>, Daniel Lezcano <daniel.lezcano@linaro.org>, linux-serial@vger.kernel.org, Geert Uytterhoeven <geert.uytterhoeven@gmail.com>, Linus Walleij <linus.walleij@linaro.org>, Mark Rutland <mark.rutland@arm.com>, Greg KH <greg@kroah.com>, Guo Ren <ren_guo@c-sky.com>, Randy Dunlap <rdunlap@infradead.org>, David Miller <davem@davemloft.net>, Jonas Bonn <jonas@southpole.se>, Stefan Kristiansson <stefan.kristiansson@saunalahti.fi>, Stafford Horne <shorne@gmail.com>, Vincent Chen <vincentc@andestech.com>
Message-ID: <20180214143254.p4zkVL0LclseFl9Ig8pxTLe_ZZC1MXK0lONdYPeeoXw@z>

On Tue, Feb 13, 2018 at 10:09 AM, Greentime Hu <green.hu@gmail.com> wrote:
> This patch adds ptrace support.
>
> Signed-off-by: Vincent Chen <vincentc@andestech.com>
> Signed-off-by: Greentime Hu <greentime@andestech.com>

This new version looks good to me,

Acked-by: Arnd Bergmann <arnd@arndb.de>
