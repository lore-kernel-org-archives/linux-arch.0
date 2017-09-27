From: Mark Rutland <mark.rutland@arm.com>
Subject: Re: [PATCH] percpu: make this_cpu_generic_read() atomic w.r.t.
 interrupts
Date: Wed, 27 Sep 2017 11:10:19 +0100
Message-ID: <20170927101019.GB32150@leverpostej>
References: <1506345872-30559-1-git-send-email-mark.rutland@arm.com>
 <20170925151826.GK828415@devbig577.frc2.facebook.com>
 <20170925153301.GA29775@leverpostej>
 <20170925154404.GA560070@devbig577.frc2.facebook.com>
 <alpine.DEB.2.20.1709260143330.21864@nuc-kabylake>
 <alpine.DEB.2.20.1709260941040.1941@nanos>
 <alpine.DEB.2.20.1709261134280.25986@nuc-kabylake>
 <alpine.DEB.2.20.1709271058030.4773@nanos>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from foss.arm.com ([217.140.101.70]:43598 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751800AbdI0KLs (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Wed, 27 Sep 2017 06:11:48 -0400
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.20.1709271058030.4773@nanos>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Thomas Gleixner <tglx@linutronix.de>
Cc: Christopher Lameter <cl@linux.com>, Tejun Heo <tj@kernel.org>, linux-kernel@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>, Peter Zijlstra <peterz@infradead.org>, Pranith Kumar <bobby.prani@gmail.com>, linux-arch@vger.kernel.org, "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>

On Wed, Sep 27, 2017 at 11:01:13AM +0200, Thomas Gleixner wrote:
> The default for 32bit architectures is that they CANNOT do atomic
> fetch/write of 8 bytes.

Indeed.

In addition, even the native word size accesses weren't guaranteed to be
atomic, as we hadn't used the appropriate accessors to prevent the
compiler from messing with things behind our backs.

> So instead of forcing that to be implemented in every affected
> architecture this wants to be addressed in generic code and those few
> 32bit architectures which can do atomic double word fetch/write
> implement the magic functions to do so.

I've done this in v2 [1], which Tejun has queued [2] as a fix for v4.14.

Thanks,
Mark.

[1] https://lkml.kernel.org/r/1506426112-19826-1-git-send-email-mark.rutland@arm.com
[2] https://lkml.kernel.org/r/20170926144118.GA70381@devbig577.frc2.facebook.com
