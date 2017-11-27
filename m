Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail-ot0-f196.google.com ([74.125.82.196]:35180 "EHLO
        mail-ot0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752231AbdK0OhO (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 27 Nov 2017 09:37:14 -0500
MIME-Version: 1.0
In-Reply-To: <21cfd623872d4377ba5064cb7302bff49ebf917e.1511785528.git.green.hu@gmail.com>
References: <cover.1511785528.git.green.hu@gmail.com> <21cfd623872d4377ba5064cb7302bff49ebf917e.1511785528.git.green.hu@gmail.com>
From: Arnd Bergmann <arnd@arndb.de>
Date: Mon, 27 Nov 2017 15:37:13 +0100
Message-ID: <CAK8P3a1sqhLwz3WqM0Qx4w0SBWqFWMuXVgX4p9StpacfWdSnUA@mail.gmail.com>
Subject: Re: [PATCH v2 16/35] nds32: Signal handling support
Content-Type: text/plain; charset="UTF-8"
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Greentime Hu <green.hu@gmail.com>
Cc: Greentime <greentime@andestech.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-arch <linux-arch@vger.kernel.org>, Thomas Gleixner <tglx@linutronix.de>, Jason Cooper <jason@lakedaemon.net>, Marc Zyngier <marc.zyngier@arm.com>, Rob Herring <robh+dt@kernel.org>, Networking <netdev@vger.kernel.org>, Vincent Chen <deanbo422@gmail.com>, DTML <devicetree@vger.kernel.org>, Al Viro <viro@zeniv.linux.org.uk>, David Howells <dhowells@redhat.com>, Will Deacon <will.deacon@arm.com>, Daniel Lezcano <daniel.lezcano@linaro.org>, linux-serial@vger.kernel.org, Vincent Chen <vincentc@andestech.com>
Message-ID: <20171127143713.l83PxDw6GBbi6N17GzMaqs0yzrqoyzNNrSjRUsQVzB4@z>

On Mon, Nov 27, 2017 at 1:28 PM, Greentime Hu <green.hu@gmail.com> wrote:

> +#ifndef _ASMNDS32_SIGNAL_H
> +#define _ASMNDS32_SIGNAL_H
> +
> +#define SA_RESTORER    0x04000000
> +
> +#include <asm-generic/signal.h>
> +#endif

As documented in asm-generic/signal.h, new architectures should not define
SA_RESTORER.

        Arnd
