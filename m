From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH V9 10/21] csky: IRQ handling
Date: Wed, 17 Oct 2018 17:14:48 +0200
Message-ID: <CAK8P3a1B9jtV=3e0HrBXNyf=-HvnLmCgeFUhsr0-HZmOyFEHzA@mail.gmail.com>
References: <cover.1539655731.git.ren_guo@c-sky.com> <131eaaee23e5f55cdce90b76b2a64f67cdf0c685.1539655732.git.ren_guo@c-sky.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <131eaaee23e5f55cdce90b76b2a64f67cdf0c685.1539655732.git.ren_guo@c-sky.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Guo Ren <ren_guo@c-sky.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, Daniel Lezcano <daniel.lezcano@linaro.org>, David Miller <davem@davemloft.net>, gregkh <gregkh@linuxfoundation.org>, Christoph Hellwig <hch@infradead.org>, Marc Zyngier <marc.zyngier@arm.com>, Mark Rutland <mark.rutland@arm.com>, Peter Zijlstra <peterz@infradead.org>, Rob Herring <robh@kernel.org>, Thomas Gleixner <tglx@linutronix.de>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-arch <linux-arch@vger.kernel.org>, DTML <devicetree@vger.kernel.org>, Rob Herring <robh+dt@kernel.org>, c-sky_gcc_upstream@c-sky.com
List-Id: linux-arch.vger.kernel.org

On Tue, Oct 16, 2018 at 5:02 AM Guo Ren <ren_guo@c-sky.com> wrote:
>
> This patch adds IRQ handling files.
>
> Signed-off-by: Guo Ren <ren_guo@c-sky.com>
> Cc: Arnd Bergmann <arnd@arndb.de>
> Cc: Thomas Gleixner <tglx@linutronix.de>
> ---
> Changelog:
>  - Use CONFIG_GENERIC_IRQ_MULTI_HANDLER

Reviewed-by: Arnd Bergmann <arnd@arndb.de>

Using CONFIG_GENERIC_IRQ_MULTI_HANDLER makes this really
short, nice!
