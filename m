From: Guo Ren <ren_guo@c-sky.com>
Subject: Re: [PATCH V9 07/21] csky: MMU and page table management
Date: Thu, 18 Oct 2018 10:05:54 +0800
Message-ID: <20181018020552.GB12027@guoren-Inspiron-7460>
References: <cover.1539655731.git.ren_guo@c-sky.com>
 <783a90d35138634a1cb899e2c551c96f3b5178af.1539655731.git.ren_guo@c-sky.com>
 <CAK8P3a1ME=1Gb1d_q_+9zP4bLr9wJC7hmEv4KGCt5GN6dG5F8g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <CAK8P3a1ME=1Gb1d_q_+9zP4bLr9wJC7hmEv4KGCt5GN6dG5F8g@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Arnd Bergmann <arnd@arndb.de>
Cc: Andrew Morton <akpm@linux-foundation.org>, Daniel Lezcano <daniel.lezcano@linaro.org>, David Miller <davem@davemloft.net>, gregkh <gregkh@linuxfoundation.org>, Christoph Hellwig <hch@infradead.org>, Marc Zyngier <marc.zyngier@arm.com>, Mark Rutland <mark.rutland@arm.com>, Peter Zijlstra <peterz@infradead.org>, Rob Herring <robh@kernel.org>, Thomas Gleixner <tglx@linutronix.de>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-arch <linux-arch@vger.kernel.org>, DTML <devicetree@vger.kernel.org>, Rob Herring <robh+dt@kernel.org>, c-sky_gcc_upstream@c-sky.com
List-Id: linux-arch.vger.kernel.org

On Wed, Oct 17, 2018 at 05:06:56PM +0200, Arnd Bergmann wrote:
> On Tue, Oct 16, 2018 at 5:01 AM Guo Ren <ren_guo@c-sky.com> wrote:
> >
> > This patch adds files related to memory management and here is our
> > memory-layout:
> >
> >    Fixmap       : 0xffc02000 – 0xfffff000       (4 MB - 12KB)
> >    Pkmap        : 0xff800000 – 0xffc00000       (4 MB)
> >    Vmalloc      : 0xf0200000 – 0xff000000       (238 MB)
> >    Lowmem       : 0x80000000 – 0xc0000000       (1GB)
> >
> > abiv1 CPU (CK610) is VIPT cache and it doesn't support highmem.
> > abiv2 CPUs are all PIPT cache and they could support highmem.
> >
> > Lowmem is directly mapped by msa0 & msa1 reg, and we needn't setup
> > memory page table for it.
> >
> > Link:https://lore.kernel.org/lkml/20180518215548.GH17671@n2100.armlinux.org.uk/
> > Signed-off-by: Guo Ren <ren_guo@c-sky.com>
> > Cc: Christoph Hellwig <hch@infradead.org>
> > Cc: Arnd Bergmann <arnd@arndb.de>
> 
> Reviewed-by: Arnd Bergmann <arnd@arndb.de>
> 
> Christoph had all the useful comments on this one, I just checked that I didn't
> spot anything beyond that.
Yes, Christoph help a lot and find a critical bug of "sync_dma > 4K".

Best Regards
 Guo Ren
