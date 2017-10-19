From: Greg KH <greg@kroah.com>
Subject: Re: [PATCH v4.4.y] percpu: make this_cpu_generic_read() atomic
 w.r.t. interrupts
Date: Thu, 19 Oct 2017 11:25:28 +0200
Message-ID: <20171019092528.GB16355@kroah.com>
References: <20171018133237.55218-1-mark.rutland@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from out4-smtp.messagingengine.com ([66.111.4.28]:37167 "EHLO
        out4-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1752557AbdJSJZU (ORCPT
        <rfc822;linux-arch@vger.kernel.org>);
        Thu, 19 Oct 2017 05:25:20 -0400
Content-Disposition: inline
In-Reply-To: <20171018133237.55218-1-mark.rutland@arm.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Mark Rutland <mark.rutland@arm.com>
Cc: stable@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>, Christoph Lameter <cl@linux.com>, Peter Zijlstra <peterz@infradead.org>, Pranith Kumar <bobby.prani@gmail.com>, Tejun Heo <tj@kernel.org>, Thomas Gleixner <tglx@linutronix.de>, linux-arch@vger.kernel.org

On Wed, Oct 18, 2017 at 02:32:37PM +0100, Mark Rutland wrote:
> Commit e88d62cd4b2f0b1ae55e9008e79c2794b1fc914d upstream.
> 
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
> Cc: stable@vger.kernel.org
> Signed-off-by: Tejun Heo <tj@kernel.org>
> [Mark: backport to v4.4.y]

Now applied, thanks!

greg k-h
