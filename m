Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from resqmta-ch2-08v.sys.comcast.net ([69.252.207.40]:57536 "EHLO
        resqmta-ch2-08v.sys.comcast.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S967764AbdIZQmL (ORCPT
        <rfc822;linux-arch@vger.kernel.org>);
        Tue, 26 Sep 2017 12:42:11 -0400
Date: Tue, 26 Sep 2017 11:42:09 -0500 (CDT)
From: Christopher Lameter <cl@linux.com>
Subject: Re: [PATCH] percpu: make this_cpu_generic_read() atomic w.r.t.
 interrupts
In-Reply-To: <alpine.DEB.2.20.1709260941040.1941@nanos>
Message-ID: <alpine.DEB.2.20.1709261134280.25986@nuc-kabylake>
References: <1506345872-30559-1-git-send-email-mark.rutland@arm.com> <20170925151826.GK828415@devbig577.frc2.facebook.com> <20170925153301.GA29775@leverpostej> <20170925154404.GA560070@devbig577.frc2.facebook.com> <alpine.DEB.2.20.1709260143330.21864@nuc-kabylake>
 <alpine.DEB.2.20.1709260941040.1941@nanos>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Thomas Gleixner <tglx@linutronix.de>
Cc: Tejun Heo <tj@kernel.org>, Mark Rutland <mark.rutland@arm.com>, linux-kernel@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>, Peter Zijlstra <peterz@infradead.org>, Pranith Kumar <bobby.prani@gmail.com>, linux-arch@vger.kernel.org, "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
Message-ID: <20170926164209.ThyGnRs6WlmaKxsvfnh9xCW7F-cvlM1Oj_EQ20Tr0_k@z>

On Tue, 26 Sep 2017, Thomas Gleixner wrote:

> > because it could also occur before or after the preempt_enable/disable
> > without the code being able to distinguish that case.
> >
> > The fetch of a scalar value from memory is an atomic operation and that is
> > required from all arches. There is an exception for double word fetches.
>
> this_cpu_read_8() is a double word fetch on many 32bit architectures.

Ok then this_cpu_read_8 for those platforms need to disable interrupts.
But that is not true for all arches.

> > Maybe we would need to special code that case but so far this does not
> > seem to have been an issue.
>
> Just because nobody ran into problem with that it is a non issue? That's
> just hillarious.

Its is even more (see your above statement) stupid to figure out that this
is actually unnecessary in the generic case and then continue the
argument.

> It's obviously not correct and needs to be fixed _before_ someone has to go
> through the pain of debugging such a problem.

As you pointed out the current approach *is* correct. Fetching a scalar
word is an atomic operation and must be one. If an arch cannot guarantee
that then arch specific measures need to be implemented to ensure that
this guarantee is kept. Could be done with interrupts disables, cmpxchg or
the reservation scheme on RISC processors. It definitely does not
belong into generic code.
