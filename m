Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail-qk1-f195.google.com ([209.85.222.195]:46314 "EHLO
        mail-qk1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727182AbeJQXEu (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 17 Oct 2018 19:04:50 -0400
MIME-Version: 1.0
References: <cover.1539655731.git.ren_guo@c-sky.com> <e078ec6a6ae8f116ac2ca381a92c81630e6b70f0.1539655731.git.ren_guo@c-sky.com>
In-Reply-To: <e078ec6a6ae8f116ac2ca381a92c81630e6b70f0.1539655731.git.ren_guo@c-sky.com>
From: Arnd Bergmann <arnd@arndb.de>
Date: Wed, 17 Oct 2018 17:08:26 +0200
Message-ID: <CAK8P3a2Wnq-nBaXjz=_YxN5+XPCEYqO6akPe-7KGOiBui69FaA@mail.gmail.com>
Subject: Re: [PATCH V9 06/21] csky: Cache and TLB routines
Content-Type: text/plain; charset="UTF-8"
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Guo Ren <ren_guo@c-sky.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, Daniel Lezcano <daniel.lezcano@linaro.org>, David Miller <davem@davemloft.net>, gregkh <gregkh@linuxfoundation.org>, Christoph Hellwig <hch@infradead.org>, Marc Zyngier <marc.zyngier@arm.com>, Mark Rutland <mark.rutland@arm.com>, Peter Zijlstra <peterz@infradead.org>, Rob Herring <robh@kernel.org>, Thomas Gleixner <tglx@linutronix.de>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-arch <linux-arch@vger.kernel.org>, DTML <devicetree@vger.kernel.org>, Rob Herring <robh+dt@kernel.org>, c-sky_gcc_upstream@c-sky.com
Message-ID: <20181017150826.XBABNQkTQM9BQNDLy2qoznIa8zdx90lHu83CkqpUMmk@z>

On Tue, Oct 16, 2018 at 5:01 AM Guo Ren <ren_guo@c-sky.com> wrote:
>
> This patch adds cache and tlb sync codes for abiv1 & abiv2.
>
> Signed-off-by: Guo Ren <ren_guo@c-sky.com>
> Cc: Arnd Bergmann <arnd@arndb.de>

Reviewed-by: Arnd Bergmann <arnd@arndb.de>
