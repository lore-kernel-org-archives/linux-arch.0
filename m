Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from Galois.linutronix.de ([193.142.43.55]:59856 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729108AbfIWUnL (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 23 Sep 2019 16:43:11 -0400
Date: Mon, 23 Sep 2019 22:43:04 +0200 (CEST)
From: Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [RFC patch 02/15] x86/entry: Remove _TIF_NOHZ from
 _TIF_WORK_SYSCALL_ENTRY
In-Reply-To: <CALCETrWHkRiXx_r8x6k=ArxTZc5YS0DewMQDVHFrjVY3Xt+H7A@mail.gmail.com>
Message-ID: <alpine.DEB.2.21.1909232242370.1934@nanos.tec.linutronix.de>
References: <20190919150314.054351477@linutronix.de> <20190919150808.617944343@linutronix.de> <CALCETrWHkRiXx_r8x6k=ArxTZc5YS0DewMQDVHFrjVY3Xt+H7A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Andy Lutomirski <luto@kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>, X86 ML <x86@kernel.org>, Peter Zijlstra <peterz@infradead.org>, Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Marc Zyngier <maz@kernel.org>, Paolo Bonzini <pbonzini@redhat.com>, kvm list <kvm@vger.kernel.org>, linux-arch <linux-arch@vger.kernel.org>
Message-ID: <20190923204304.kHroV5jMoKWiXMiHDkoCZ8vFgFryo-jtFrU783pLu5w@z>

On Fri, 20 Sep 2019, Andy Lutomirski wrote:

> On Thu, Sep 19, 2019 at 8:09 AM Thomas Gleixner <tglx@linutronix.de> wrote:
> >
> > Evaluating _TIF_NOHZ to decide whether to use the slow syscall entry path
> > is not only pointless, it's actually counterproductive:
> >
> >  1) Context tracking code is invoked unconditionally before that flag is
> >     evaluated.
> >
> >  2) If the flag is set the slow path is invoked for nothing due to #1
> 
> Can we also get rid of TIF_NOHZ on x86?

If we make the usage in context_tracking_cpu_set() conditional.

Thanks,

	tglx
