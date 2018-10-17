Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail-qk1-f193.google.com ([209.85.222.193]:39548 "EHLO
        mail-qk1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727014AbeJQW4S (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 17 Oct 2018 18:56:18 -0400
MIME-Version: 1.0
References: <cover.1539655731.git.ren_guo@c-sky.com> <22dbcb592386b5f124b16a304315b70da70ed58d.1539655731.git.ren_guo@c-sky.com>
In-Reply-To: <22dbcb592386b5f124b16a304315b70da70ed58d.1539655731.git.ren_guo@c-sky.com>
From: Arnd Bergmann <arnd@arndb.de>
Date: Wed, 17 Oct 2018 16:59:56 +0200
Message-ID: <CAK8P3a3xf_s3s=EH-QTVEYo7yJm=GXVD1FEFC9wpxx4BFgP2Qg@mail.gmail.com>
Subject: Re: [PATCH V9 04/21] csky: Exception handling and mm-fault
Content-Type: text/plain; charset="UTF-8"
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Guo Ren <ren_guo@c-sky.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, Daniel Lezcano <daniel.lezcano@linaro.org>, David Miller <davem@davemloft.net>, gregkh <gregkh@linuxfoundation.org>, Christoph Hellwig <hch@infradead.org>, Marc Zyngier <marc.zyngier@arm.com>, Mark Rutland <mark.rutland@arm.com>, Peter Zijlstra <peterz@infradead.org>, Rob Herring <robh@kernel.org>, Thomas Gleixner <tglx@linutronix.de>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-arch <linux-arch@vger.kernel.org>, DTML <devicetree@vger.kernel.org>, Rob Herring <robh+dt@kernel.org>, c-sky_gcc_upstream@c-sky.com
Message-ID: <20181017145956.opZyNvRMBDIFtNAnZH14HuRikG-NWYAoYVYlnS52EYw@z>

On Tue, Oct 16, 2018 at 5:01 AM Guo Ren <ren_guo@c-sky.com> wrote:
>
> This patch adds exception handling code, cpuinfo and mm-fault code.
>
> Signed-off-by: Guo Ren <ren_guo@c-sky.com>
> Cc: Arnd Bergmann <arnd@arndb.de>

Reviewed-by: Arnd Bergmann <arnd@arndb.de>
