From: Christopher Lameter <cl@linux.com>
Subject: Re: [PATCH] percpu: make this_cpu_generic_read() atomic w.r.t.
 interrupts
Date: Tue, 26 Sep 2017 01:47:27 -0500 (CDT)
Message-ID: <alpine.DEB.2.20.1709260143330.21864@nuc-kabylake>
References: <1506345872-30559-1-git-send-email-mark.rutland@arm.com> <20170925151826.GK828415@devbig577.frc2.facebook.com> <20170925153301.GA29775@leverpostej> <20170925154404.GA560070@devbig577.frc2.facebook.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from resqmta-ch2-06v.sys.comcast.net ([69.252.207.38]:59948 "EHLO
        resqmta-ch2-06v.sys.comcast.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S936598AbdIZGr3 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>);
        Tue, 26 Sep 2017 02:47:29 -0400
In-Reply-To: <20170925154404.GA560070@devbig577.frc2.facebook.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Tejun Heo <tj@kernel.org>
Cc: Mark Rutland <mark.rutland@arm.com>, linux-kernel@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>, Peter Zijlstra <peterz@infradead.org>, Pranith Kumar <bobby.prani@gmail.com>, linux-arch@vger.kernel.org

On Mon, 25 Sep 2017, Tejun Heo wrote:

> Hello,
>
> On Mon, Sep 25, 2017 at 04:33:02PM +0100, Mark Rutland wrote:
> > Unfortunately, the generic this_cpu_read(), which is intended to be
> > irq-safe, is not:
> >
> > #define this_cpu_generic_read(pcp)                                      \
> > ({                                                                      \
> >         typeof(pcp) __ret;                                              \
> >         preempt_disable_notrace();                                      \
> >         __ret = raw_cpu_generic_read(pcp);                              \
> >         preempt_enable_notrace();                                       \
> >         __ret;                                                          \
> > })
>
> I see.  Yeah, that looks like the bug there.

This is a single fetch operation of a value that needs to be atomic. It
really does not matter if an interrupt happens before or after that load
because it could also occur before or after the preempt_enable/disable
without the code being able to distinguish that case.

The fetch of a scalar value from memory is an atomic operation and that is
required from all arches. There is an exception for double word fetches.
Maybe we would need to special code that case but so far this does not
seem to have been an issue.
