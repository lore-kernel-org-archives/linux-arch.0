From: Tejun Heo <tj@kernel.org>
Subject: Re: [PATCH] percpu: make this_cpu_generic_read() atomic w.r.t.
 interrupts
Date: Mon, 25 Sep 2017 08:44:04 -0700
Message-ID: <20170925154404.GA560070@devbig577.frc2.facebook.com>
References: <1506345872-30559-1-git-send-email-mark.rutland@arm.com>
 <20170925151826.GK828415@devbig577.frc2.facebook.com>
 <20170925153301.GA29775@leverpostej>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20170925153301.GA29775@leverpostej>
Sender: linux-kernel-owner@vger.kernel.org
To: Mark Rutland <mark.rutland@arm.com>
Cc: linux-kernel@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>, Christoph Lameter <cl@linux.com>, Peter Zijlstra <peterz@infradead.org>, Pranith Kumar <bobby.prani@gmail.com>, linux-arch@vger.kernel.org
List-Id: linux-arch.vger.kernel.org

Hello,

On Mon, Sep 25, 2017 at 04:33:02PM +0100, Mark Rutland wrote:
> Unfortunately, the generic this_cpu_read(), which is intended to be
> irq-safe, is not:
> 
> #define this_cpu_generic_read(pcp)                                      \
> ({                                                                      \
>         typeof(pcp) __ret;                                              \
>         preempt_disable_notrace();                                      \
>         __ret = raw_cpu_generic_read(pcp);                              \
>         preempt_enable_notrace();                                       \
>         __ret;                                                          \
> })

I see.  Yeah, that looks like the bug there.

> I guess it'd be preferable to manipulate that in-place.
> 
> > Adding READ_ONCE() doesn't generically guarantee that the reads won't
> > be split - e.g. there are arch which simply can't load a 64bit value
> > with a single instruction.
> 
> In which case, it really sounds like this_cpu_generic_read() needs to
> disable interrupts too...

Can you please spin up a patch for this?

Thanks.

-- 
tejun
