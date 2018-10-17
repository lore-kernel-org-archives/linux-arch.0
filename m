From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH V9 03/21] csky: Kernel booting
Date: Wed, 17 Oct 2018 16:58:52 +0200
Message-ID: <CAK8P3a0PxhheSTuiMX76R3HZNvkJ9+qPM37AQPgmHgK2-TV1wQ@mail.gmail.com>
References: <cover.1539655731.git.ren_guo@c-sky.com> <4fc690db42b5b43edb15fd23517a6f3ba5b2c9ff.1539655731.git.ren_guo@c-sky.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <4fc690db42b5b43edb15fd23517a6f3ba5b2c9ff.1539655731.git.ren_guo@c-sky.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Guo Ren <ren_guo@c-sky.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, Daniel Lezcano <daniel.lezcano@linaro.org>, David Miller <davem@davemloft.net>, gregkh <gregkh@linuxfoundation.org>, Christoph Hellwig <hch@infradead.org>, Marc Zyngier <marc.zyngier@arm.com>, Mark Rutland <mark.rutland@arm.com>, Peter Zijlstra <peterz@infradead.org>, Rob Herring <robh@kernel.org>, Thomas Gleixner <tglx@linutronix.de>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-arch <linux-arch@vger.kernel.org>, DTML <devicetree@vger.kernel.org>, Rob Herring <robh+dt@kernel.org>, c-sky_gcc_upstream@c-sky.com
List-Id: linux-arch.vger.kernel.org

On Tue, Oct 16, 2018 at 4:59 AM Guo Ren <ren_guo@c-sky.com> wrote:
>
> This patch add boot code. Thx boot params is all in dtb and it's
> the only way to let kernel get bootloader param information.
>
> Signed-off-by: Guo Ren <ren_guo@c-sky.com>
> Cc: Arnd Bergmann <arnd@arndb.de>
> ---
> Changelog:
>  - Use built-in dtb when dtb param is NULL.
>  - Add dummy console for allmodconfig.
> ---

Reviewed-by: Arnd Bergmann <arnd@arndb.de>
