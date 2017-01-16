From: Yao Qi <qiyaoltc@gmail.com>
Subject: Re: [RFC PATCH 08/10] arm64/sve: ptrace: Wire up vector length control and reporting
Date: Mon, 16 Jan 2017 15:11:56 +0000
Message-ID: <20170116151156.GI28060@E107787-LIN>
References: <1484220369-23970-1-git-send-email-Dave.Martin@arm.com> <1484220369-23970-9-git-send-email-Dave.Martin@arm.com> <20170116122038.GG28060@E107787-LIN> <20170116133231.GO3699@e103592.cambridge.arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <gdb-return-45538-gdb-gdb=m.gmane.org@sourceware.org>
List-Unsubscribe: <mailto:gdb-unsubscribe-gdb-gdb=m.gmane.org@sourceware.org>
List-Subscribe: <mailto:gdb-subscribe@sourceware.org>
List-Archive: <http://sourceware.org/ml/gdb/>
List-Post: <mailto:gdb@sourceware.org>
List-Help: <mailto:gdb-help@sourceware.org>, <http://sourceware.org/ml/#faqs>
Sender: gdb-owner@sourceware.org
Content-Disposition: inline
In-Reply-To: <20170116133231.GO3699@e103592.cambridge.arm.com>
To: Dave Martin <Dave.Martin@arm.com>
Cc: linux-arch@vger.kernel.org, Florian Weimer <fweimer@redhat.com>, libc-alpha@sourceware.org, Ard Biesheuvel <ard.biesheuvel@linaro.org>, Marc Zyngier <Marc.Zyngier@arm.com>, gdb@sourceware.org, Joseph Myers <joseph@codesourcery.com>, Szabolcs Nagy <szabolcs.nagy@arm.com>, linux-arm-kernel@lists.infradead.org, Alan Hayward <alan.hayward@arm.com>, Torvald Riegel <triegel@redhat.com>, Christoffer Dall <christoffer.dall@linaro.org>
List-Id: linux-arch.vger.kernel.org

On 17-01-16 13:32:31, Dave Martin wrote:
> On Mon, Jan 16, 2017 at 12:20:38PM +0000, Yao Qi wrote:
> > On 17-01-12 11:26:07, Dave Martin wrote:
> > > This patch adds support for manipulating a task's vector length at
> > > runtime via ptrace.
> > > 
> > 
> > I hope kernel doesn't provide such interface to ptracer to change vector
> > length.
> 
> It does, with this patch, beacuse...
> 
> > The vector length is sort of a read-only property of thread/process/
> > program to debugger, unless we really have a clear requirement to modify
> > vector length in debugging.  I may miss something because I haven't debug
> > SVE code yet.
> 
> ...the vector length is no longer read-only for the task, thanks to
> the new prctls().

What I meant "read-only" is that debugger can't change it, while the program
itself can change it via prctl().

> 
> This does add complexity, but I figured that any programmer's model
> state that the thread can modify for itself should be modifiable by the
> debugger, if for no other reason than the user may want to experiment to
> see what happens.  Without a ptrace interface, it would be necessary
> to inject a prctl() call into the target, which is possible but awkward.

We only need such interface if it is useful, see more below.

Suppose it is useful to change vector length through ptrace, we should align
ptrace interface to prctl() as much as possible.  Looks that both prctl
change and ptrace change can go through sve_set_vector_length, easy to keep
two consistent.

> 
> gdb must already re-detect the vector length on stop, since the target
> could have called the prctl() in the meantime.

Yes, gdb assumes the vector length may be changed, so it re-detects on
every stop, but I don't see the need for gdb to change the vector length.

> 
> Access via ptrace also allows things like trapping on exec, fork or
> clone and changing the vector length for the new process or thread
> before it starts to run.  I'm guessing here, but such a scenario seems
> legitimate (?)
> 

Yes, these cases are valid, but the usefulness is still questionable to
me.  I just doubt that SVE developers do need to change vector length
when they are debugging code.  Note that it is not my strong objection
to this patch, if kernel people believe this is useful, I am fine with
it.

-- 
Yao (齐尧)
