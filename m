From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH V9 09/21] csky: VDSO and rt_sigreturn
Date: Wed, 17 Oct 2018 17:13:11 +0200
Message-ID: <CAK8P3a2Mbks25yEh7UQVFcBgtrFGext4QY33f3k-geABcsB5_g@mail.gmail.com>
References: <cover.1539655731.git.ren_guo@c-sky.com> <cdb473fa2fc1dd5752a989a03b1b9fb2016cb1a2.1539655732.git.ren_guo@c-sky.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <cdb473fa2fc1dd5752a989a03b1b9fb2016cb1a2.1539655732.git.ren_guo@c-sky.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Guo Ren <ren_guo@c-sky.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, Daniel Lezcano <daniel.lezcano@linaro.org>, David Miller <davem@davemloft.net>, gregkh <gregkh@linuxfoundation.org>, Christoph Hellwig <hch@infradead.org>, Marc Zyngier <marc.zyngier@arm.com>, Mark Rutland <mark.rutland@arm.com>, Peter Zijlstra <peterz@infradead.org>, Rob Herring <robh@kernel.org>, Thomas Gleixner <tglx@linutronix.de>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-arch <linux-arch@vger.kernel.org>, DTML <devicetree@vger.kernel.org>, Rob Herring <robh+dt@kernel.org>, c-sky_gcc_upstream@c-sky.com
List-Id: linux-arch.vger.kernel.org

On Tue, Oct 16, 2018 at 5:01 AM Guo Ren <ren_guo@c-sky.com> wrote:
>
> This patch adds files related to VDSO and our VDSO only support
> rt_sigreturn.
>
> Signed-off-by: Guo Ren <ren_guo@c-sky.com>
> Cc: Arnd Bergmann <arnd@arndb.de>

I was a little worried about the VDSO because of the discussion we had about
64-bit time_t. Since there is no gettimeofday call in here, that's fine, so

Reviewed-by: Arnd Bergmann <arnd@arndb.de>
