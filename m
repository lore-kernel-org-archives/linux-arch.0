From: Guo Ren <ren_guo@c-sky.com>
Subject: Re: [PATCH V9 12/21] csky: ELF and module probe
Date: Thu, 18 Oct 2018 10:49:30 +0800
Message-ID: <20181018024929.GC13314@guoren-Inspiron-7460>
References: <cover.1539655731.git.ren_guo@c-sky.com>
 <27589f69f513177892d39868050dccb5f21023aa.1539655732.git.ren_guo@c-sky.com>
 <CAK8P3a2vwe=4SqKfyGruKEJ1yd7txbdBqw6kD_3pN47F8u7OAA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <CAK8P3a2vwe=4SqKfyGruKEJ1yd7txbdBqw6kD_3pN47F8u7OAA@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Arnd Bergmann <arnd@arndb.de>
Cc: Andrew Morton <akpm@linux-foundation.org>, Daniel Lezcano <daniel.lezcano@linaro.org>, David Miller <davem@davemloft.net>, gregkh <gregkh@linuxfoundation.org>, Christoph Hellwig <hch@infradead.org>, Marc Zyngier <marc.zyngier@arm.com>, Mark Rutland <mark.rutland@arm.com>, Peter Zijlstra <peterz@infradead.org>, Rob Herring <robh@kernel.org>, Thomas Gleixner <tglx@linutronix.de>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-arch <linux-arch@vger.kernel.org>, DTML <devicetree@vger.kernel.org>, Rob Herring <robh+dt@kernel.org>, c-sky_gcc_upstream@c-sky.com
List-Id: linux-arch.vger.kernel.org

On Wed, Oct 17, 2018 at 05:18:49PM +0200, Arnd Bergmann wrote:
> On Tue, Oct 16, 2018 at 5:02 AM Guo Ren <ren_guo@c-sky.com> wrote:
> >
> > This patch adds ELF definition and module relocate codes.
> >
> > Signed-off-by: Guo Ren <ren_guo@c-sky.com>
> > Cc: Arnd Bergmann <arnd@arndb.de>
> 
> > +#ifdef __cskyBE__
> > +#define ELF_DATA       ELFDATA2MSB
> > +#else
> > +#define ELF_DATA       ELFDATA2LSB
> > +#endif
> 
> You removed support for big-endian, right? I guess the #ifdef can also
> get removed here then. Aside from that,
Now, we only support little-endian and it could be removed. But maybe we
need support big-endian in future, so I keep it here.

Best Regards
 Guo Ren
