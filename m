From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH v6 07/36] nds32: Exception handling
Date: Thu, 18 Jan 2018 11:14:17 +0100
Message-ID: <CAK8P3a1ZZsB7MVZ8sEPzkVcNUJh3-MB_ApmPi+DUF1rc9h8pXg@mail.gmail.com>
References: <cover.1515766253.git.green.hu@gmail.com> <28c2c9da4da4c8b07473e97cd4a6cb953f4b507c.1515766253.git.green.hu@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mail-oi0-f67.google.com ([209.85.218.67]:37542 "EHLO
        mail-oi0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755376AbeARKOT (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 18 Jan 2018 05:14:19 -0500
In-Reply-To: <28c2c9da4da4c8b07473e97cd4a6cb953f4b507c.1515766253.git.green.hu@gmail.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Greentime Hu <green.hu@gmail.com>
Cc: Greentime <greentime@andestech.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-arch <linux-arch@vger.kernel.org>, Thomas Gleixner <tglx@linutronix.de>, Jason Cooper <jason@lakedaemon.net>, Marc Zyngier <marc.zyngier@arm.com>, Rob Herring <robh+dt@kernel.org>, Networking <netdev@vger.kernel.org>, Vincent Chen <deanbo422@gmail.com>, DTML <devicetree@vger.kernel.org>, Al Viro <viro@zeniv.linux.org.uk>, David Howells <dhowells@redhat.com>, Will Deacon <will.deacon@arm.com>, Daniel Lezcano <daniel.lezcano@linaro.org>, linux-serial@vger.kernel.org, Geert Uytterhoeven <geert.uytterhoeven@gmail.com>, Linus Walleij <linus.walleij@linaro.org>, Mark Rutland <mark.rutland@arm.com>, Greg KH <greg@kroah.com>, Guo Ren <ren_guo@c-sky.co>

On Mon, Jan 15, 2018 at 6:53 AM, Greentime Hu <green.hu@gmail.com> wrote:
> From: Greentime Hu <greentime@andestech.com>
>
> This patch includes the exception/interrupt entries, pt_reg structure and
> related accessors.
>
> Signed-off-by: Vincent Chen <vincentc@andestech.com>
> Signed-off-by: Greentime Hu <greentime@andestech.com>

Here it would be good to have a more detailed explanation about the alignment
trap handling. I remember discussing it with you before, but don't remember
the exact outcome. In particular you should explain here why you need to
handle alignment traps in the first place, and what the expected defaults
are (e.g. always disabled unless a user requests it, or always enabled) and
what kind of code runs into the traps (e.g. buggy kernel code, correct
kernel code, buggy user space code etc).

       Arnd
