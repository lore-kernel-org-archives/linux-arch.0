From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH V9 16/21] csky: SMP support
Date: Wed, 17 Oct 2018 17:47:46 +0200
Message-ID: <CAK8P3a3nnFP_=u7Z-WeBr0kE07BCsaD=mVtG3Qm2zzPpH4RCqQ@mail.gmail.com>
References: <cover.1539655731.git.ren_guo@c-sky.com> <4fca35ebfae9208ed6117bbe41c863a33730681e.1539655732.git.ren_guo@c-sky.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <4fca35ebfae9208ed6117bbe41c863a33730681e.1539655732.git.ren_guo@c-sky.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Guo Ren <ren_guo@c-sky.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, Daniel Lezcano <daniel.lezcano@linaro.org>, David Miller <davem@davemloft.net>, gregkh <gregkh@linuxfoundation.org>, Christoph Hellwig <hch@infradead.org>, Marc Zyngier <marc.zyngier@arm.com>, Mark Rutland <mark.rutland@arm.com>, Peter Zijlstra <peterz@infradead.org>, Rob Herring <robh@kernel.org>, Thomas Gleixner <tglx@linutronix.de>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-arch <linux-arch@vger.kernel.org>, DTML <devicetree@vger.kernel.org>, Rob Herring <robh+dt@kernel.org>, c-sky_gcc_upstream@c-sky.com
List-Id: linux-arch.vger.kernel.org

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
