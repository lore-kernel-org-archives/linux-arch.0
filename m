Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail-qt1-f195.google.com ([209.85.160.195]:43122 "EHLO
        mail-qt1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727271AbeJQXoU (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 17 Oct 2018 19:44:20 -0400
MIME-Version: 1.0
References: <cover.1539655731.git.ren_guo@c-sky.com> <4fca35ebfae9208ed6117bbe41c863a33730681e.1539655732.git.ren_guo@c-sky.com>
In-Reply-To: <4fca35ebfae9208ed6117bbe41c863a33730681e.1539655732.git.ren_guo@c-sky.com>
From: Arnd Bergmann <arnd@arndb.de>
Date: Wed, 17 Oct 2018 17:47:46 +0200
Message-ID: <CAK8P3a3nnFP_=u7Z-WeBr0kE07BCsaD=mVtG3Qm2zzPpH4RCqQ@mail.gmail.com>
Subject: Re: [PATCH V9 16/21] csky: SMP support
Content-Type: text/plain; charset="UTF-8"
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Guo Ren <ren_guo@c-sky.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, Daniel Lezcano <daniel.lezcano@linaro.org>, David Miller <davem@davemloft.net>, gregkh <gregkh@linuxfoundation.org>, Christoph Hellwig <hch@infradead.org>, Marc Zyngier <marc.zyngier@arm.com>, Mark Rutland <mark.rutland@arm.com>, Peter Zijlstra <peterz@infradead.org>, Rob Herring <robh@kernel.org>, Thomas Gleixner <tglx@linutronix.de>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-arch <linux-arch@vger.kernel.org>, DTML <devicetree@vger.kernel.org>, Rob Herring <robh+dt@kernel.org>, c-sky_gcc_upstream@c-sky.com
Message-ID: <20181017154746.6XXdSaX50o5pSQ_2VLJPqUKBKagPahBQguyDqNjvoAU@z>

On Tue, Oct 16, 2018 at 5:09 AM Guo Ren <ren_guo@c-sky.com> wrote:
>
> This patch adds boot, ipi, hotplug codes for SMP.
>
> Signed-off-by: Guo Ren <ren_guo@c-sky.com>
> Cc: Marc Zyngier <marc.zyngier@arm.com>
> Cc: Mark Rutland <mark.rutland@arm.com>
> Cc: Peter Zijlstra <peterz@infradead.org>
> Cc: Arnd Bergmann <arnd@arndb.de>

Reviewed-by: Arnd Bergmann <arnd@arndb.de>
