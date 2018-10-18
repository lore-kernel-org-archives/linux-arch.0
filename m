Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from smtp2200-217.mail.aliyun.com ([121.197.200.217]:46030 "EHLO
        smtp2200-217.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727309AbeJRKiJ (ORCPT
        <rfc822;linux-arch@vger.kernel.org>);
        Thu, 18 Oct 2018 06:38:09 -0400
Date: Thu, 18 Oct 2018 10:39:19 +0800
From: Guo Ren <ren_guo@c-sky.com>
Subject: Re: [PATCH V9 10/21] csky: IRQ handling
Message-ID: <20181018023919.GA13314@guoren-Inspiron-7460>
References: <cover.1539655731.git.ren_guo@c-sky.com>
 <131eaaee23e5f55cdce90b76b2a64f67cdf0c685.1539655732.git.ren_guo@c-sky.com>
 <CAK8P3a1B9jtV=3e0HrBXNyf=-HvnLmCgeFUhsr0-HZmOyFEHzA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAK8P3a1B9jtV=3e0HrBXNyf=-HvnLmCgeFUhsr0-HZmOyFEHzA@mail.gmail.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Arnd Bergmann <arnd@arndb.de>
Cc: Andrew Morton <akpm@linux-foundation.org>, Daniel Lezcano <daniel.lezcano@linaro.org>, David Miller <davem@davemloft.net>, gregkh <gregkh@linuxfoundation.org>, Christoph Hellwig <hch@infradead.org>, Marc Zyngier <marc.zyngier@arm.com>, Mark Rutland <mark.rutland@arm.com>, Peter Zijlstra <peterz@infradead.org>, Rob Herring <robh@kernel.org>, Thomas Gleixner <tglx@linutronix.de>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-arch <linux-arch@vger.kernel.org>, DTML <devicetree@vger.kernel.org>, Rob Herring <robh+dt@kernel.org>, c-sky_gcc_upstream@c-sky.com
Message-ID: <20181018023919.8-VxA4UGKV3Jca6pkpdrFegaOLc4BktwfYS9Hh0V8rA@z>

On Wed, Oct 17, 2018 at 05:14:48PM +0200, Arnd Bergmann wrote:
> On Tue, Oct 16, 2018 at 5:02 AM Guo Ren <ren_guo@c-sky.com> wrote:
> >
> > This patch adds IRQ handling files.
> >
> > Signed-off-by: Guo Ren <ren_guo@c-sky.com>
> > Cc: Arnd Bergmann <arnd@arndb.de>
> > Cc: Thomas Gleixner <tglx@linutronix.de>
> > ---
> > Changelog:
> >  - Use CONFIG_GENERIC_IRQ_MULTI_HANDLER
> 
> Reviewed-by: Arnd Bergmann <arnd@arndb.de>
> 
> Using CONFIG_GENERIC_IRQ_MULTI_HANDLER makes this really
> short, nice!
Yes, this is tglx's suggestion.

Best Regards
 Guo Ren
