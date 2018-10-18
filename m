From: Guo Ren <ren_guo@c-sky.com>
Subject: Re: [PATCH V9 05/21] csky: System Call
Date: Thu, 18 Oct 2018 10:02:04 +0800
Message-ID: <20181018020203.GA12027@guoren-Inspiron-7460>
References: <cover.1539655731.git.ren_guo@c-sky.com>
 <d83762614122402ba4b55524e35b418c9f6baf53.1539655731.git.ren_guo@c-sky.com>
 <CAK8P3a3bNST+ZuPjLG0_sHjC=Ac0ir1omhHvMn9tz4zs+Kg9yw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <CAK8P3a3bNST+ZuPjLG0_sHjC=Ac0ir1omhHvMn9tz4zs+Kg9yw@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Arnd Bergmann <arnd@arndb.de>
Cc: Andrew Morton <akpm@linux-foundation.org>, Daniel Lezcano <daniel.lezcano@linaro.org>, David Miller <davem@davemloft.net>, gregkh <gregkh@linuxfoundation.org>, Christoph Hellwig <hch@infradead.org>, Marc Zyngier <marc.zyngier@arm.com>, Mark Rutland <mark.rutland@arm.com>, Peter Zijlstra <peterz@infradead.org>, Rob Herring <robh@kernel.org>, Thomas Gleixner <tglx@linutronix.de>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-arch <linux-arch@vger.kernel.org>, DTML <devicetree@vger.kernel.org>, Rob Herring <robh+dt@kernel.org>, c-sky_gcc_upstream@c-sky.com
List-Id: linux-arch.vger.kernel.org

On Wed, Oct 17, 2018 at 05:02:33PM +0200, Arnd Bergmann wrote:
> On Tue, Oct 16, 2018 at 5:01 AM Guo Ren <ren_guo@c-sky.com> wrote:
> >
> > This patch adds files related to syscall.
> >
> > Signed-off-by: Guo Ren <ren_guo@c-sky.com>
> > Cc: Arnd Bergmann <arnd@arndb.de>
> 
> Reviewed-by: Arnd Bergmann <arnd@arndb.de>
> 
> I had a detailed look at this one and provided lots of comments, however
> one tiny thing escaped me:
> 
> > +#define __NR_set_thread_area   (__NR_arch_specific_syscall + 0)
> > +__SYSCALL(__NR_set_thread_area, sys_set_thread_area)
> > +#define __NR_cacheflush                (__NR_arch_specific_syscall + 4)
> > +__SYSCALL(__NR_cacheflush, sys_cacheflush)
> 
> It's odd that the second one uses __NR_arch_specific_syscall + 4 rather
> than +1. If you can still change that changing too much other stuff,
> that might avoid some head-scratching later. If it causes problems,
> just leave it and maybe add a comment saying that the numbers
> inbetween are still available.
Change to (__NR_arch_specific_syscall + 1) is ok for now.

Best Regards
 Guo Ren
