From: Christoph Hellwig <hch@infradead.org>
Subject: Re: [PATCH V6 01/33] csky: Build infrastructure
Date: Fri, 28 Sep 2018 09:11:10 -0700
Message-ID: <20180928161110.GA19827@infradead.org>
References: <cover.1538058840.git.ren_guo@c-sky.com>
 <dbd9228bb886c672ba75ad9e479f870957d6bcfa.1538058840.git.ren_guo@c-sky.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <dbd9228bb886c672ba75ad9e479f870957d6bcfa.1538058840.git.ren_guo@c-sky.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Guo Ren <ren_guo@c-sky.com>
Cc: akpm@linux-foundation.org, arnd@arndb.de, daniel.lezcano@linaro.org, davem@davemloft.net, gregkh@linuxfoundation.org, jason@lakedaemon.net, marc.zyngier@arm.com, mark.rutland@arm.com, mchehab+samsung@kernel.org, peterz@infradead.org, robh@kernel.org, robh+dt@kernel.org, tglx@linutronix.de, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, devicetree@vger.kernel.org, green.hu@gmail.com
List-Id: linux-arch.vger.kernel.org

> --- /dev/null
> +++ b/arch/csky/kernel/Makefile
> @@ -0,0 +1,8 @@
> +extra-y := head.o vmlinux.lds
> +
> +obj-y += entry.o atomic.o signal.o traps.o irq.o time.o vdso.o \
> +	 power.o syscall.o platform.o syscall_table.o setup.o \
> +	 process.o cpu-probe.o ptrace.o dumpstack.o
> +
> +obj-$(CONFIG_MODULES)			+= module.o

You can't just wire up the build infrastructure before th code.

Please add the objects to the Makefiles when they are actually added.
