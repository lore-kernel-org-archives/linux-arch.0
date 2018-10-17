Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail-qt1-f193.google.com ([209.85.160.193]:32863 "EHLO
        mail-qt1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727013AbeJQXrN (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 17 Oct 2018 19:47:13 -0400
MIME-Version: 1.0
References: <cover.1539655731.git.ren_guo@c-sky.com> <867b2328e3dbaef58d0b5e7fc58e8545d1510951.1539655732.git.ren_guo@c-sky.com>
In-Reply-To: <867b2328e3dbaef58d0b5e7fc58e8545d1510951.1539655732.git.ren_guo@c-sky.com>
From: Arnd Bergmann <arnd@arndb.de>
Date: Wed, 17 Oct 2018 17:50:33 +0200
Message-ID: <CAK8P3a1WM08tTDKH7E9hQP7GLUXmHndKCyEuaWrvTq5YKGR5+Q@mail.gmail.com>
Subject: Re: [PATCH V9 18/21] dt-bindings: csky CPU Bindings
Content-Type: text/plain; charset="UTF-8"
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Guo Ren <ren_guo@c-sky.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, Daniel Lezcano <daniel.lezcano@linaro.org>, David Miller <davem@davemloft.net>, gregkh <gregkh@linuxfoundation.org>, Christoph Hellwig <hch@infradead.org>, Marc Zyngier <marc.zyngier@arm.com>, Mark Rutland <mark.rutland@arm.com>, Peter Zijlstra <peterz@infradead.org>, Rob Herring <robh@kernel.org>, Thomas Gleixner <tglx@linutronix.de>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-arch <linux-arch@vger.kernel.org>, DTML <devicetree@vger.kernel.org>, Rob Herring <robh+dt@kernel.org>, c-sky_gcc_upstream@c-sky.com
Message-ID: <20181017155033.DUTUcW-4A5CdBSqwmOq0KHDsUcjTgtP17tz_vrT4mgI@z>

On Tue, Oct 16, 2018 at 5:30 AM Guo Ren <ren_guo@c-sky.com> wrote:
>
> This patch adds the documentation to describe that how to add cpu nodes in
> dts for SMP.
>
> Signed-off-by: Guo Ren <ren_guo@c-sky.com>
> Cc: Rob Herring <robh@kernel.org>

I don't see anything wrong, but I'll let Rob or some other DT maintainer
provide an Ack when they are happy.

      Arnd
