Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from foss.arm.com ([217.140.101.70]:51886 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728937AbfBZSZp (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Tue, 26 Feb 2019 13:25:45 -0500
Date: Tue, 26 Feb 2019 18:25:39 +0000
From: Will Deacon <will.deacon@arm.com>
Subject: Re: [RFC PATCH 01/20] asm-generic/mmiowb: Add generic implementation
 of mmiowb() tracking
Message-ID: <20190226182539.GB28709@fuggles.cambridge.arm.com>
References: <20190222185026.10973-1-will.deacon@arm.com>
 <20190222185026.10973-2-will.deacon@arm.com>
 <CAHk-=wgamK0=rNsCfDfDzmNXUF_MqUHb0okzqN1Tir9vm65pNg@mail.gmail.com>
 <CAHk-=whK=Pb9QZhYkqFGUjK1Sas620qjO1Y_EzSBiHSXxJfTYQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=whK=Pb9QZhYkqFGUjK1Sas620qjO1Y_EzSBiHSXxJfTYQ@mail.gmail.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-arch <linux-arch@vger.kernel.org>, Linux List Kernel Mailing <linux-kernel@vger.kernel.org>, "Paul E. McKenney" <paulmck@linux.ibm.com>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Michael Ellerman <mpe@ellerman.id.au>, Arnd Bergmann <arnd@arndb.de>, Peter Zijlstra <peterz@infradead.org>, Andrea Parri <andrea.parri@amarulasolutions.com>, Palmer Dabbelt <palmer@sifive.com>, Daniel Lustig <dlustig@nvidia.com>, David Howells <dhowells@redhat.com>, Alan Stern <stern@rowland.harvard.edu>, "Maciej W. Rozycki" <macro@linux-mips.org>, Paul Burton <paul.burton@mips.com>, Ingo Molnar <mingo@kernel.org>, Yoshinori Sato <ysato@users.sourceforge.jp>, Rich Felker <dalias@libc.org>, Tony Luck <tony.luck@intel.com>
Message-ID: <20190226182539.V3n54vtNXrWQ9e_JNShvJstRVptWzbnbH_MR5WgMuFA@z>

On Fri, Feb 22, 2019 at 01:55:20PM -0800, Linus Torvalds wrote:
> On Fri, Feb 22, 2019 at 1:49 PM Linus Torvalds
> <torvalds@linux-foundation.org> wrote:
> >
> > The case we want to go fast is the spin-lock and unlock case, not the
> > "set pending" case.
> >
> > And the way you implemented this, it's exactly the wrong way around.
> 
> Oh, one more comment: couldn't we make that mmiowb flag be right next
> to the preemption count?
> 
> Because that's the common case anyway, where a spinlock increments the
> preemption count too. If we put the mmiowb state in the same
> cacheline, we don't cause extra cache effects, which is what really
> matters, I guess.
> 
> I realize this is somewhat inconvenient, because some architectures
> put preempt count in the thread structure, and others do it as a
> percpu variable. But maybe the architecture could just declare where
> the mmiowb state is?

I think that should be doable... I'll have a play.

Will
