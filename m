Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail-ot0-f193.google.com ([74.125.82.193]:34358 "EHLO
        mail-ot0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751467AbdK0OVU (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 27 Nov 2017 09:21:20 -0500
MIME-Version: 1.0
In-Reply-To: <5e1be9ebc591c6de79b75f726a5a38b2564eaa92.1511785528.git.green.hu@gmail.com>
References: <cover.1511785528.git.green.hu@gmail.com> <5e1be9ebc591c6de79b75f726a5a38b2564eaa92.1511785528.git.green.hu@gmail.com>
From: Arnd Bergmann <arnd@arndb.de>
Date: Mon, 27 Nov 2017 15:21:19 +0100
Message-ID: <CAK8P3a1GuH2tgtC5t834-PNeUVYQxreD7seZH8sjraZFtRUWKw@mail.gmail.com>
Subject: Re: [PATCH v2 25/35] nds32: Build infrastructure
Content-Type: text/plain; charset="UTF-8"
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Greentime Hu <green.hu@gmail.com>
Cc: Greentime <greentime@andestech.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-arch <linux-arch@vger.kernel.org>, Thomas Gleixner <tglx@linutronix.de>, Jason Cooper <jason@lakedaemon.net>, Marc Zyngier <marc.zyngier@arm.com>, Rob Herring <robh+dt@kernel.org>, Networking <netdev@vger.kernel.org>, Vincent Chen <deanbo422@gmail.com>, DTML <devicetree@vger.kernel.org>, Al Viro <viro@zeniv.linux.org.uk>, David Howells <dhowells@redhat.com>, Will Deacon <will.deacon@arm.com>, Daniel Lezcano <daniel.lezcano@linaro.org>, linux-serial@vger.kernel.org, Vincent Chen <vincentc@andestech.com>
Message-ID: <20171127142119.oiX548kbccbm1ocYpNZN0RKwyiX6PKuT0bVz3GhgaWs@z>

On Mon, Nov 27, 2017 at 1:28 PM, Greentime Hu <green.hu@gmail.com> wrote:

> diff --git a/arch/nds32/Kconfig.cpu b/arch/nds32/Kconfig.cpu
> new file mode 100644
> index 0000000..6b4013f
> --- /dev/null
> +++ b/arch/nds32/Kconfig.cpu
> @@ -0,0 +1,131 @@
> +comment "Processor Features"
> +
> +config CPU_BIG_ENDIAN
> +       bool "Big endian"
> +       def_bool n
> +
> +config CPU_LITTLE_ENDIAN
> +       bool "Little endian"
> +       def_bool y

These must be mutually exclusive, you surely get some build error if you try to
set both here.

You can either make it a 'choice' statement to pick between the two, or you
can make CPU_LITTLE_ENDIAN a silent option like

config CPU_BIG_ENDIAN
       bool "Big endian"

config CPU_LITTLE_ENDIAN
       def_bool !CPU_BIG_ENDIAN

> +config CPU_CACHE_NONALIASING
> +       bool "Non-aliasing cache"
> +       help
> +         If this CPU is using VIPT data cache and its cache way size is larger
> +         than page size, say N. If it is using PIPT data cache, say Y.
> +
> +         If unsure, say Y.

Can you determine this from the CPU type?

> +choice
> +       prompt "Memory split"
> +       depends on MMU
> +       default VMSPLIT_3G
> +       help
> +         Select the desired split between kernel and user memory.
> +
> +         If you are not absolutely sure what you are doing, leave this
> +         option alone!
> +
> +       config VMSPLIT_3G
> +               bool "3G/1G user/kernel split"
> +       config VMSPLIT_3G_OPT
> +               bool "3G/1G user/kernel split (for full 1G low memory)"
> +       config VMSPLIT_2G
> +               bool "2G/2G user/kernel split"
> +       config VMSPLIT_1G
> +               bool "1G/3G user/kernel split"
> +endchoice

I think you mentioned that the 1GB configuration is quite common, how
about making VMSPLIT_3G_OPT the default here?

       Arnd
