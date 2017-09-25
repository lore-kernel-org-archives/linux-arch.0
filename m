Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail-qk0-f174.google.com ([209.85.220.174]:53637 "EHLO
        mail-qk0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933472AbdIYPoI (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 25 Sep 2017 11:44:08 -0400
Date: Mon, 25 Sep 2017 08:44:04 -0700
From: Tejun Heo <tj@kernel.org>
Subject: Re: [PATCH] percpu: make this_cpu_generic_read() atomic w.r.t.
 interrupts
Message-ID: <20170925154404.GA560070@devbig577.frc2.facebook.com>
References: <1506345872-30559-1-git-send-email-mark.rutland@arm.com>
 <20170925151826.GK828415@devbig577.frc2.facebook.com>
 <20170925153301.GA29775@leverpostej>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170925153301.GA29775@leverpostej>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Mark Rutland <mark.rutland@arm.com>
Cc: linux-kernel@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>, Christoph Lameter <cl@linux.com>, Peter Zijlstra <peterz@infradead.org>, Pranith Kumar <bobby.prani@gmail.com>, linux-arch@vger.kernel.org
Message-ID: <20170925154404.YyWTuBC5WvHioLCnj71YkuBNgAkRpkcyyZpv9OanQTQ@z>

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
