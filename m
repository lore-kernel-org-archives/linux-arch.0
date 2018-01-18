From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH v6 04/36] earlycon: add reg-offset to physical address
 before mapping
Date: Thu, 18 Jan 2018 11:00:51 +0100
Message-ID: <CAK8P3a1Oy5rjDMYpB1KNWEzMLxReNzuE_fKemcrBVFPrjPB4UQ@mail.gmail.com>
References: <cover.1515766253.git.green.hu@gmail.com> <030b9e2ee2d6ee309eebe00feea0e92687304e64.1515766253.git.green.hu@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mail-oi0-f68.google.com ([209.85.218.68]:35093 "EHLO
        mail-oi0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753505AbeARKAw (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 18 Jan 2018 05:00:52 -0500
In-Reply-To: <030b9e2ee2d6ee309eebe00feea0e92687304e64.1515766253.git.green.hu@gmail.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Greentime Hu <green.hu@gmail.com>
Cc: Greentime <greentime@andestech.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-arch <linux-arch@vger.kernel.org>, Thomas Gleixner <tglx@linutronix.de>, Jason Cooper <jason@lakedaemon.net>, Marc Zyngier <marc.zyngier@arm.com>, Rob Herring <robh+dt@kernel.org>, Networking <netdev@vger.kernel.org>, Vincent Chen <deanbo422@gmail.com>, DTML <devicetree@vger.kernel.org>, Al Viro <viro@zeniv.linux.org.uk>, David Howells <dhowells@redhat.com>, Will Deacon <will.deacon@arm.com>, Daniel Lezcano <daniel.lezcano@linaro.org>, linux-serial@vger.kernel.org, Geert Uytterhoeven <geert.uytterhoeven@gmail.com>, Linus Walleij <linus.walleij@linaro.org>, Mark Rutland <mark.rutland@arm.com>, Greg KH <greg@kroah.com>, Guo Ren <ren_guo@c-sky.co>

On Mon, Jan 15, 2018 at 6:53 AM, Greentime Hu <green.hu@gmail.com> wrote:
> From: Greentime Hu <greentime@andestech.com>
>
> It will get the wrong virtual address because port->mapbase is not added
> the correct reg-offset yet. We have to update it before earlycon_map()
> is called
>
> Signed-off-by: Greentime Hu <greentime@andestech.com>

Acked-by: Arnd Bergmann <arnd@arndb.de>
Cc: Peter Hurley <peter@hurleysoftware.com>
Cc: stable@vger.kernel.org
Fixes: 088da2a17619 ("of: earlycon: Initialize port fields from DT properties")

As this is a bugfix for generic code, this might be good to
have Greg pick up directly for his serial drivers tree. An Ack from
Peter Hurley would also help, as he introduced the reg-offset handling
originally.

      Arnd
