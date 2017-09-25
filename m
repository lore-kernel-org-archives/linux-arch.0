From: Tejun Heo <tj@kernel.org>
Subject: Re: [PATCH] percpu: make this_cpu_generic_read() atomic w.r.t.
 interrupts
Date: Mon, 25 Sep 2017 08:18:27 -0700
Message-ID: <20170925151826.GK828415@devbig577.frc2.facebook.com>
References: <1506345872-30559-1-git-send-email-mark.rutland@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mail-qk0-f193.google.com ([209.85.220.193]:33636 "EHLO
        mail-qk0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932107AbdIYPSb (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 25 Sep 2017 11:18:31 -0400
Content-Disposition: inline
In-Reply-To: <1506345872-30559-1-git-send-email-mark.rutland@arm.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Mark Rutland <mark.rutland@arm.com>
Cc: linux-kernel@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>, Christoph Lameter <cl@linux.com>, Peter Zijlstra <peterz@infradead.org>, Pranith Kumar <bobby.prani@gmail.com>, linux-arch@vger.kernel.org

Hello, Mark.

On Mon, Sep 25, 2017 at 02:24:32PM +0100, Mark Rutland wrote:
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
> Avoid this by using READ_ONCE() to inhibit tearing.

That's why there are irq-safe variants of the operations.  Adding
READ_ONCE() doesn't generically guarantee that the reads won't be
split - e.g. there are arch which simply can't load a 64bit value with
a single instruction.

Thanks.

-- 
tejun
