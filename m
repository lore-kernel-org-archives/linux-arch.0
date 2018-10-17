Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail-qk1-f195.google.com ([209.85.222.195]:35956 "EHLO
        mail-qk1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727028AbeJQXpn (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 17 Oct 2018 19:45:43 -0400
MIME-Version: 1.0
References: <cover.1539655731.git.ren_guo@c-sky.com> <efa8d7e6a2e6407707b77d9ed0d5bfaeea62692a.1539655732.git.ren_guo@c-sky.com>
In-Reply-To: <efa8d7e6a2e6407707b77d9ed0d5bfaeea62692a.1539655732.git.ren_guo@c-sky.com>
From: Arnd Bergmann <arnd@arndb.de>
Date: Wed, 17 Oct 2018 17:49:08 +0200
Message-ID: <CAK8P3a38Q9y4fBHWA37ikzoPLNtGYNwOApQMr_=9T12pp-tH7Q@mail.gmail.com>
Subject: Re: [PATCH V9 17/21] csky: Misc headers
Content-Type: text/plain; charset="UTF-8"
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Guo Ren <ren_guo@c-sky.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, Daniel Lezcano <daniel.lezcano@linaro.org>, David Miller <davem@davemloft.net>, gregkh <gregkh@linuxfoundation.org>, Christoph Hellwig <hch@infradead.org>, Marc Zyngier <marc.zyngier@arm.com>, Mark Rutland <mark.rutland@arm.com>, Peter Zijlstra <peterz@infradead.org>, Rob Herring <robh@kernel.org>, Thomas Gleixner <tglx@linutronix.de>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-arch <linux-arch@vger.kernel.org>, DTML <devicetree@vger.kernel.org>, Rob Herring <robh+dt@kernel.org>, c-sky_gcc_upstream@c-sky.com
Message-ID: <20181017154908.OnAytpcrY5aWHOclhX4wPeBx-rNe6tBLvXuUQZeI_ek@z>

On Tue, Oct 16, 2018 at 5:29 AM Guo Ren <ren_guo@c-sky.com> wrote:
>
> This patch adds csky registers' definition, bitops, byteorder,
> asm-offsets codes.
>
> Signed-off-by: Guo Ren <ren_guo@c-sky.com>
> Cc: Arnd Bergmann <arnd@arndb.de>

Reviewed-by: Arnd Bergmann <arnd@arndb.de>
