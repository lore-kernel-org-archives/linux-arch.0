From: Guo Ren <ren_guo@c-sky.com>
Subject: Re: [PATCH V3 06/26] csky: Cache and TLB routines
Date: Sat, 8 Sep 2018 10:20:12 +0800
Message-ID: <20180908022011.GB29088@guoren-Inspiron-7460>
References: <cover.1536138304.git.ren_guo@c-sky.com>
 <16105a3e54f1c4bb65a5ec81d77af7c176e705c6.1536138304.git.ren_guo@c-sky.com>
 <CAK8P3a1fYM0X=F+9yD6BVLq=57eJeFWXCvywjQOFwEHz7oAhcg@mail.gmail.com>
 <20180907030447.GA10434@guoren-Inspiron-7460>
 <CAK8P3a2K_ecCQEs840hQMrjsf4H8hHxS+HtM2TtPDYpRu8-LeQ@mail.gmail.com>
 <20180907125536.GA2308@guoren>
 <CAK8P3a3b+dM2kxSG7kCqTR=NmiqvZoMwOwSmQKRQLQjXqpqxYw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <CAK8P3a3b+dM2kxSG7kCqTR=NmiqvZoMwOwSmQKRQLQjXqpqxYw@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Arnd Bergmann <arnd@arndb.de>
Cc: linux-arch <linux-arch@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Thomas Gleixner <tglx@linutronix.de>, Daniel Lezcano <daniel.lezcano@linaro.org>, Jason Cooper <jason@lakedaemon.net>, c-sky_gcc_upstream@c-sky.com, gnu-csky@mentor.com, Thomas Petazzoni <thomas.petazzoni@bootlin.com>, wbx@uclibc-ng.org, Greentime Hu <green.hu@gmail.com>
List-Id: linux-arch.vger.kernel.org

On Fri, Sep 07, 2018 at 04:13:35PM +0200, Arnd Bergmann wrote:
> On Fri, Sep 7, 2018 at 2:55 PM Guo Ren <ren_guo@c-sky.com> wrote:
> >
> > On Fri, Sep 07, 2018 at 10:14:38AM +0200, Arnd Bergmann wrote:
> > > On Fri, Sep 7, 2018 at 5:04 AM Guo Ren <ren_guo@c-sky.com> wrote:
> > > > On Thu, Sep 06, 2018 at 04:31:16PM +0200, Arnd Bergmann wrote:
> > > Similarly, an MMIO read may be used to see if a DMA has completed
> > > and the device register tells you that the DMA has left the device,
> > > but without a barrier, the CPU may have prefetched the DMA
> > > data while waiting for the MMIO-read to complete. The __io_ar()
> > > barrier() in asm-generic/io.h prevents the compiler from reordering
> > > the two reads, but if an weakly ordered read (in coherent DMA buffer)
> > > can bypass a strongly ordered read (MMIO), then it's still still
> > > broken.
> > __io_ar() barrier()? not rmb() ?! I've defined the rmb in asm/barrier, So
> > I got rmb() here not barrier().
> >
> > Only __io_br() is barrier().
> 
> Ah right, I misremembered the defaults. It's probably ok then.
Thx for the review and comments. These let me re-consider the mmio
issues and help to improve the csky asm/io.h in future. 
> 
> > > > > - How does endianess work? Are there any buses that flip bytes around
> > > > >   when running big-endian, or do you always do that in software?
> > > > Currently we only support little-endian and soc will follow it.
> > >
> > > Ok, that makes it easier. If you think that you won't even need big-endian
> > > support in the long run, you could also remove your asm/byteorder.h
> > > header. If you're not sure, it doesn't hurt to keep it of course.
> > Em... I'm not sure, so let me keep it for a while.
> 
> Ok. I think overall the trend is to be little-endian only for most
> architectures: powerpc64 moved from big-endian only to little-endian
> by default, ARM rarely uses big-endian (basically only for legacy
> applications ported from BE MIPS or ppc), and all new architectures
> we added in the last years are little-endian (OpenRISC being the
> main exception).
Good news, I really don't want to support big-endian and it makes CI
double.

Best Regards
 Guo Ren
