From: Tejun Heo <tj@kernel.org>
Subject: Re: [PATCHv2] percpu: make this_cpu_generic_read() atomic w.r.t.
 interrupts
Date: Tue, 26 Sep 2017 07:41:18 -0700
Message-ID: <20170926144118.GA70381@devbig577.frc2.facebook.com>
References: <1506426112-19826-1-git-send-email-mark.rutland@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1506426112-19826-1-git-send-email-mark.rutland@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Mark Rutland <mark.rutland@arm.com>
Cc: linux-kernel@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>, Christoph Lameter <cl@linux.com>, Peter Zijlstra <peterz@infradead.org>, Pranith Kumar <bobby.prani@gmail.com>, Thomas Gleixner <tglx@linutronix.de>, linux-arch@vger.kernel.org
List-Id: linux-arch.vger.kernel.org

On Tue, Sep 26, 2017 at 12:41:52PM +0100, Mark Rutland wrote:
> As raw_cpu_generic_read() is a plain read from a raw_cpu_ptr() address,
> it's possible (albeit unlikely) that the compiler will split the access
> across multiple instructions.
> 
> In this_cpu_generic_read() we disable preemption but not interrupts
> before calling raw_cpu_generic_read(). Thus, an interrupt could be taken
> in the middle of the split load instructions. If a this_cpu_write() or
> RMW this_cpu_*() op is made to the same variable in the interrupt
> handling path, this_cpu_read() will return a torn value.
> 
> For native word types, we can avoid tearing using READ_ONCE(), but this
> won't work in all cases (e.g. 64-bit types on most 32-bit platforms).
> This patch reworks this_cpu_generic_read() to use READ_ONCE() where
> possible, otherwise falling back to disabling interrupts.
> 
> Signed-off-by: Mark Rutland <mark.rutland@arm.com>
> Cc: Arnd Bergmann <arnd@arndb.de>
> Cc: Christoph Lameter <cl@linux.com>
> Cc: Peter Zijlstra <peterz@infradead.org>
> Cc: Pranith Kumar <bobby.prani@gmail.com>
> Cc: Tejun Heo <tj@kernel.org>
> Cc: Thomas Gleixner <tglx@linutronix.de>
> Cc: linux-arch@vger.kernel.org

Applied to percpu/for-4.14-fixes.

Thanks.

-- 
tejun
