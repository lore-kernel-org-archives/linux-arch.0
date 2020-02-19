From: Borislav Petkov <bp@alien8.de>
Subject: Re: [PATCH v3 01/22] hardirq/nmi: Allow nested nmi_enter()
Date: Wed, 19 Feb 2020 17:56:50 +0100
Message-ID: <20200219165650.GB32346@zn.tnic>
References: <20200219144724.800607165@infradead.org>
 <20200219150744.428764577@infradead.org>
 <20200219103126.33f67cf3@gandalf.local.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20200219103126.33f67cf3@gandalf.local.home>
Sender: linux-kernel-owner@vger.kernel.org
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Peter Zijlstra <peterz@infradead.org>, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, mingo@kernel.org, joel@joelfernandes.org, gregkh@linuxfoundation.org, gustavo@embeddedor.com, tglx@linutronix.de, paulmck@kernel.org, josh@joshtriplett.org, mathieu.desnoyers@efficios.com, jiangshanlai@gmail.com, luto@kernel.org, tony.luck@intel.com, frederic@kernel.org, dan.carpenter@oracle.com, mhiramat@kernel.org, Will Deacon <will@kernel.org>, Marc Zyngier <maz@kernel.org>, Michael Ellerman <mpe@ellerman.id.au>, Petr Mladek <pmladek@suse.com>
List-Id: linux-arch.vger.kernel.org

On Wed, Feb 19, 2020 at 10:31:26AM -0500, Steven Rostedt wrote:
> Probably should document somewhere (in a comment above nmi_enter()?)
> that we allow nmi_enter() to nest up to 15 times.

Yah, and can we make the BUG_ON() WARN_ON or so instead, so that there's
at least a chance to be able to catch it for debugging. Or is the box
going to be irreparably wedged after the 4 bits overflow?

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
