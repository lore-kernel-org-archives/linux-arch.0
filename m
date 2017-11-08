From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH 08/31] nds32: Cache and TLB routines
Date: Wed, 8 Nov 2017 09:45:03 +0100
Message-ID: <CAK8P3a0ObXRL+39bPHF_e-06-aC=4X46DqMuC1hPLWH6CW+FOQ@mail.gmail.com>
References: <cover.1510118606.git.green.hu@gmail.com> <220aabe68365f970ed6de79ef88f9598f272dcb9.1510118606.git.green.hu@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mail-oi0-f52.google.com ([209.85.218.52]:56547 "EHLO
        mail-oi0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750832AbdKHIpE (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 8 Nov 2017 03:45:04 -0500
In-Reply-To: <220aabe68365f970ed6de79ef88f9598f272dcb9.1510118606.git.green.hu@gmail.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Greentime Hu <green.hu@gmail.com>
Cc: greentime@andestech.com, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-arch <linux-arch@vger.kernel.org>, Thomas Gleixner <tglx@linutronix.de>, Jason Cooper <jason@lakedaemon.net>, Marc Zyngier <marc.zyngier@arm.com>, Rob Herring <robh+dt@kernel.org>, Networking <netdev@vger.kernel.org>, Vincent Chen <vincentc@andestech.com>

On Wed, Nov 8, 2017 at 6:54 AM, Greentime Hu <green.hu@gmail.com> wrote:

> +#ifndef __NDS32_PROCFNS_H__
> +#define __NDS32_PROCFNS_H__
> +
> +#define CPU_NAME n13
> +
> +#ifdef __KERNEL__
> +
> +#ifdef __STDC__
> +#define ____cpu_fn(name,fn)       name##fn
> +#else
> +#define ____cpu_fn(name,fn)       name/**/fn
> +#endif
> +#define __cpu_fn(name,fn)         ____cpu_fn(name,fn)
> +
> +#define cpu_proc_init                  __cpu_fn( CPU_NAME, _proc_init)
> +#define cpu_proc_fin                   __cpu_fn( CPU_NAME, _proc_fin)
> +#define cpu_do_idle                    __cpu_fn( CPU_NAME, _do_idle)
> +#define cpu_reset                      __cpu_fn( CPU_NAME, _reset)
> +#define cpu_switch_mm                  __cpu_fn( CPU_NAME, _switch_mm)

I see you have copied this from ARM. Do you actually need the same complexity,
with the ability to build either optimal code for a particular CPU or
a multi-CPU
version?

Most other architectures seem to have settled for doing just one of the two
models. How many CPU implementations to you expect to support that
differ in all of those functions?

      Arnd
