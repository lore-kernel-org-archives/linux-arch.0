From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH V9 08/21] csky: Process management and Signal
Date: Wed, 17 Oct 2018 17:11:00 +0200
Message-ID: <CAK8P3a31sVAMCPXLqyqMpvj-gsxOmuf2qL0bT5crDQo0Wcg__g@mail.gmail.com>
References: <cover.1539655731.git.ren_guo@c-sky.com> <9ae1d1609a49d976ae7659157507018b0c846423.1539655732.git.ren_guo@c-sky.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <9ae1d1609a49d976ae7659157507018b0c846423.1539655732.git.ren_guo@c-sky.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Guo Ren <ren_guo@c-sky.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, Daniel Lezcano <daniel.lezcano@linaro.org>, David Miller <davem@davemloft.net>, gregkh <gregkh@linuxfoundation.org>, Christoph Hellwig <hch@infradead.org>, Marc Zyngier <marc.zyngier@arm.com>, Mark Rutland <mark.rutland@arm.com>, Peter Zijlstra <peterz@infradead.org>, Rob Herring <robh@kernel.org>, Thomas Gleixner <tglx@linutronix.de>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-arch <linux-arch@vger.kernel.org>, DTML <devicetree@vger.kernel.org>, Rob Herring <robh+dt@kernel.org>, c-sky_gcc_upstream@c-sky.com
List-Id: linux-arch.vger.kernel.org

On Tue, Oct 16, 2018 at 5:01 AM Guo Ren <ren_guo@c-sky.com> wrote:
>
> This patch adds files related to task_switch, sigcontext, signal,
> fpu context switch.
>
> Signed-off-by: Guo Ren <ren_guo@c-sky.com>
> Cc: Arnd Bergmann <arnd@arndb.de>
> ---
> Changelog:
>  - abiv2/fpu.c: Userspace should never be sent NSIGXXX as a si_code.
>    Use FPE_FLTUNK instead.
>  - abiv2/fpu.c: Use force_sig_fault instead.

I'm hesitant to provide a Reviewed-by: tag for this one, as I don't
understand the signal handling enough myself, and it's something
that should be reviewed properly because of the ABI implications.

Maybe someone else can have a closer look at this?

       Arnd
