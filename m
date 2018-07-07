From: Guo Ren <ren_guo@c-sky.com>
Subject: Re: [PATCH V2 06/19] csky: Cache and TLB routines
Date: Sat, 7 Jul 2018 19:51:09 +0800
Message-ID: <20180707115108.GA3861@guoren-Inspiron-7460>
References: <cover.1530465325.git.ren_guo@c-sky.com>
 <a2c153fa2e585e4ba54a339f13442881553ab6a4.1530465326.git.ren_guo@c-sky.com>
 <20180705174025.GD2530@hirez.programming.kicks-ass.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20180705174025.GD2530@hirez.programming.kicks-ass.net>
Sender: linux-kernel-owner@vger.kernel.org
To: Peter Zijlstra <peterz@infradead.org>
Cc: linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org, tglx@linutronix.de, daniel.lezcano@linaro.org, jason@lakedaemon.net, arnd@arndb.de, c-sky_gcc_upstream@c-sky.com, gnu-csky@mentor.com, thomas.petazzoni@bootlin.com, wbx@uclibc-ng.org, green.hu@gmail.com, Will Deacon <will.deacon@arm.com>
List-Id: linux-arch.vger.kernel.org

On Thu, Jul 05, 2018 at 07:40:25PM +0200, Peter Zijlstra wrote:
> > +#ifdef CONFIG_SMP
> > +#define mb()	asm volatile ("sync.is":::"memory")
> > +#else
> > +#define mb()	asm volatile ("sync":::"memory")
> > +#endif
> 
> This is very suspect, please elaborate.
> 
> What I would've expected is:
> 
> #define mb() asm volatile ("sync" ::: "memory")
> 
> #ifdef CONFIG_SMP
> #define __smp_mb() asm volatile ("sync.is" ::: "memory")
> #endif
> 
> Is that in fact what you meant?
> 
> Do you have a reference to your architecture manual and memory model
> description somewhere?
I'll fixup it in next version patch.
