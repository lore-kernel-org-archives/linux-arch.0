From: Mark Rutland <mark.rutland@arm.com>
Subject: Re: [PATCH] percpu: make this_cpu_generic_read() atomic w.r.t.
 interrupts
Date: Mon, 25 Sep 2017 16:33:02 +0100
Message-ID: <20170925153301.GA29775@leverpostej>
References: <1506345872-30559-1-git-send-email-mark.rutland@arm.com>
 <20170925151826.GK828415@devbig577.frc2.facebook.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20170925151826.GK828415@devbig577.frc2.facebook.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Tejun Heo <tj@kernel.org>
Cc: linux-kernel@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>, Christoph Lameter <cl@linux.com>, Peter Zijlstra <peterz@infradead.org>, Pranith Kumar <bobby.prani@gmail.com>, linux-arch@vger.kernel.org
List-Id: linux-arch.vger.kernel.org

On Mon, Sep 25, 2017 at 08:18:27AM -0700, Tejun Heo wrote:
> Hello, Mark.
> 
> On Mon, Sep 25, 2017 at 02:24:32PM +0100, Mark Rutland wrote:
> > As raw_cpu_generic_read() is a plain read from a raw_cpu_ptr() address,
> > it's possible (albeit unlikely) that the compiler will split the access
> > across multiple instructions.
> > 
> > In this_cpu_generic_read() we disable preemption but not interrupts
> > before calling raw_cpu_generic_read(). Thus, an interrupt could be taken
> > in the middle of the split load instructions. If a this_cpu_write() or
> > RMW this_cpu_*() op is made to the same variable in the interrupt
> > handling path, this_cpu_read() will return a torn value.
> > 
> > Avoid this by using READ_ONCE() to inhibit tearing.
> 
> That's why there are irq-safe variants of the operations. 

Unfortunately, the generic this_cpu_read(), which is intended to be
irq-safe, is not:

#define this_cpu_generic_read(pcp)                                      \
({                                                                      \
        typeof(pcp) __ret;                                              \
        preempt_disable_notrace();                                      \
        __ret = raw_cpu_generic_read(pcp);                              \
        preempt_enable_notrace();                                       \
        __ret;                                                          \
})

I guess it'd be preferable to manipulate that in-place.

> Adding READ_ONCE() doesn't generically guarantee that the reads won't
> be split - e.g. there are arch which simply can't load a 64bit value
> with a single instruction.

True.

In which case, it really sounds like this_cpu_generic_read() needs to
disable interrupts too...

Thanks,
Mark.
