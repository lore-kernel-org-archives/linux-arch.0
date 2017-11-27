Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail-ot0-f194.google.com ([74.125.82.194]:44234 "EHLO
        mail-ot0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751555AbdK0OPX (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 27 Nov 2017 09:15:23 -0500
MIME-Version: 1.0
In-Reply-To: <1aa759dbbb1032dd20e5fadbb0ce5aa4b8b22690.1511785528.git.green.hu@gmail.com>
References: <cover.1511785528.git.green.hu@gmail.com> <1aa759dbbb1032dd20e5fadbb0ce5aa4b8b22690.1511785528.git.green.hu@gmail.com>
From: Arnd Bergmann <arnd@arndb.de>
Date: Mon, 27 Nov 2017 15:15:22 +0100
Message-ID: <CAK8P3a2GJERt78uWgdDy+Azr-ZMcOcB+D6Akq99tSfwKmt2LiA@mail.gmail.com>
Subject: Re: [PATCH v2 30/35] net: faraday add nds32 support.
Content-Type: text/plain; charset="UTF-8"
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Greentime Hu <green.hu@gmail.com>
Cc: Greentime <greentime@andestech.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-arch <linux-arch@vger.kernel.org>, Thomas Gleixner <tglx@linutronix.de>, Jason Cooper <jason@lakedaemon.net>, Marc Zyngier <marc.zyngier@arm.com>, Rob Herring <robh+dt@kernel.org>, Networking <netdev@vger.kernel.org>, Vincent Chen <deanbo422@gmail.com>, DTML <devicetree@vger.kernel.org>, Al Viro <viro@zeniv.linux.org.uk>, David Howells <dhowells@redhat.com>, Will Deacon <will.deacon@arm.com>, Daniel Lezcano <daniel.lezcano@linaro.org>, linux-serial@vger.kernel.org
Message-ID: <20171127141522.fuVIm_PpQHCXI8NmActBLMBI0sg3-otxGtSb2CiqwZY@z>

On Mon, Nov 27, 2017 at 1:28 PM, Greentime Hu <green.hu@gmail.com> wrote:
> From: Greentime Hu <greentime@andestech.com>
>
> Signed-off-by: Greentime Hu <greentime@andestech.com>

This is missing a patch description.

> diff --git a/drivers/net/ethernet/faraday/Kconfig b/drivers/net/ethernet/faraday/Kconfig
> index 040c7f1..0ae6e9a 100644
> --- a/drivers/net/ethernet/faraday/Kconfig
> +++ b/drivers/net/ethernet/faraday/Kconfig
> @@ -5,7 +5,7 @@
>  config NET_VENDOR_FARADAY
>         bool "Faraday devices"
>         default y
> -       depends on ARM
> +       depends on ARM || NDS32
>         ---help---
>           If you have a network (Ethernet) card belonging to this class, say Y.
>

We probably want to make all three here

depends on ARM || NDS32 || COMPILE_TEST

     Arnd
