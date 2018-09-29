From: Guo Ren <ren_guo@c-sky.com>
Subject: Re: [PATCH V6 01/33] csky: Build infrastructure
Date: Sun, 30 Sep 2018 01:20:33 +0800
Message-ID: <20180929172032.GH27796@guoren-Inspiron-7460>
References: <cover.1538058840.git.ren_guo@c-sky.com>
 <dbd9228bb886c672ba75ad9e479f870957d6bcfa.1538058840.git.ren_guo@c-sky.com>
 <20180928161110.GA19827@infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20180928161110.GA19827@infradead.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Christoph Hellwig <hch@infradead.org>
Cc: akpm@linux-foundation.org, arnd@arndb.de, daniel.lezcano@linaro.org, davem@davemloft.net, gregkh@linuxfoundation.org, jason@lakedaemon.net, marc.zyngier@arm.com, mark.rutland@arm.com, mchehab+samsung@kernel.org, peterz@infradead.org, robh@kernel.org, robh+dt@kernel.org, tglx@linutronix.de, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, devicetree@vger.kernel.org, green.hu@gmail.com
List-Id: linux-arch.vger.kernel.org

On Fri, Sep 28, 2018 at 09:11:10AM -0700, Christoph Hellwig wrote:
> > --- /dev/null
> > +++ b/arch/csky/kernel/Makefile
> > @@ -0,0 +1,8 @@
> > +extra-y := head.o vmlinux.lds
> > +
> > +obj-y += entry.o atomic.o signal.o traps.o irq.o time.o vdso.o \
> > +	 power.o syscall.o platform.o syscall_table.o setup.o \
> > +	 process.o cpu-probe.o ptrace.o dumpstack.o
> > +
> > +obj-$(CONFIG_MODULES)			+= module.o
> 
> You can't just wire up the build infrastructure before th code.
> 
> Please add the objects to the Makefiles when they are actually added.
I don't got it? Patchset should be seperated by makefile dir?
