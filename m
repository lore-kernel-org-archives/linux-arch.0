From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH 20/31] nds32: L2 cache support
Date: Wed, 8 Nov 2017 10:48:15 +0100
Message-ID: <CAK8P3a22ROs70434v=vJ8BMaa4_-5CeBTjTGxPwz8Ri3z2EPyA@mail.gmail.com>
References: <cover.1510118606.git.green.hu@gmail.com> <b8c4d4dd7b5ce02123300018041923d0dfa97af9.1510118606.git.green.hu@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <b8c4d4dd7b5ce02123300018041923d0dfa97af9.1510118606.git.green.hu@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Greentime Hu <green.hu@gmail.com>
Cc: greentime@andestech.com, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-arch <linux-arch@vger.kernel.org>, Thomas Gleixner <tglx@linutronix.de>, Jason Cooper <jason@lakedaemon.net>, Marc Zyngier <marc.zyngier@arm.com>, Rob Herring <robh+dt@kernel.org>, Networking <netdev@vger.kernel.org>, Vincent Chen <vincentc@andestech.com>
List-Id: linux-arch.vger.kernel.org

On Wed, Nov 8, 2017 at 6:55 AM, Greentime Hu <green.hu@gmail.com> wrote:
> From: Greentime Hu <greentime@andestech.com>
>
> Signed-off-by: Vincent Chen <vincentc@andestech.com>
> Signed-off-by: Greentime Hu <greentime@andestech.com>

> +
> +/* This is defined for head.S to use due to device tree is not yet built. */
> +#define L2CC_PA_BASE           0x90F00000

This looks problematic, since it prevents you from using the same head.S for
multiple SoCs that have different L2 controllers or that have them at different
addresses.

What does head.S actually do to the L2CC? Could the boot protocol require
that to be done by the boot loader before entering the kernel instead?

     Arnd
