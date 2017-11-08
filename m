From: Rob Herring <robh+dt@kernel.org>
Subject: Re: [PATCH 29/31] MAINTAINERS: Add nds32
Date: Wed, 8 Nov 2017 07:31:36 -0600
Message-ID: <CAL_JsqLe847Dhta2vkbaUqRdfaQnsPCncR2bZZNP-_kzvm25wg@mail.gmail.com>
References: <cover.1510118606.git.green.hu@gmail.com> <16035efb78f70411998755693339471032743377.1510118606.git.green.hu@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:41616 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751955AbdKHNb6 (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Wed, 8 Nov 2017 08:31:58 -0500
In-Reply-To: <16035efb78f70411998755693339471032743377.1510118606.git.green.hu@gmail.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Greentime Hu <green.hu@gmail.com>
Cc: greentime@andestech.com, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Arnd Bergmann <arnd@arndb.de>, "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>, Thomas Gleixner <tglx@linutronix.de>, Jason Cooper <jason@lakedaemon.net>, Marc Zyngier <marc.zyngier@arm.com>, netdev <netdev@vger.kernel.org>

On Tue, Nov 7, 2017 at 11:55 PM, Greentime Hu <green.hu@gmail.com> wrote:
> From: Greentime Hu <greentime@andestech.com>
>
> Signed-off-by: Greentime Hu <greentime@andestech.com>
> ---
>  MAINTAINERS |    9 +++++++++
>  1 file changed, 9 insertions(+)
>
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 2f4e462..bce1181 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -857,6 +857,15 @@ X: drivers/iio/*/adjd*
>  F:     drivers/staging/iio/*/ad*
>  F:     drivers/staging/iio/trigger/iio-trig-bfin-timer.c
>
> +ANDES ARCHITECTURE
> +M:     Greentime Hu <green.hu@gmail.com>
> +M:     Vincent Chen <deanbo422@gmail.com>
> +T:     git https://github.com/andestech/linux.git
> +S:     Supported
> +F:     arch/nds32

DT binding files?

> +K:     nds32
> +N:     nds32
> +
>  ANDROID CONFIG FRAGMENTS
>  M:     Rob Herring <robh@kernel.org>
>  S:     Supported
> --
> 1.7.9.5
>
