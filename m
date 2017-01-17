From: Dave Martin <Dave.Martin@arm.com>
Subject: Re: [RFC PATCH 08/10] arm64/sve: ptrace: Wire up vector length
 control and reporting
Date: Tue, 17 Jan 2017 10:03:51 +0000
Message-ID: <20170117100349.GR3699@e103592.cambridge.arm.com>
References: <1484220369-23970-1-git-send-email-Dave.Martin@arm.com>
 <1484220369-23970-9-git-send-email-Dave.Martin@arm.com>
 <20170116122038.GG28060@E107787-LIN>
 <20170116133231.GO3699@e103592.cambridge.arm.com>
 <20170116151156.GI28060@E107787-LIN>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <libc-alpha-return-76827-glibc-alpha=m.gmane.org@sourceware.org>
List-Unsubscribe: <mailto:libc-alpha-unsubscribe-glibc-alpha=m.gmane.org@sourceware.org>
List-Subscribe: <mailto:libc-alpha-subscribe@sourceware.org>
List-Archive: <http://sourceware.org/ml/libc-alpha/>
List-Post: <mailto:libc-alpha@sourceware.org>
List-Help: <mailto:libc-alpha-help@sourceware.org>, <http://sourceware.org/ml/#faqs>
Sender: libc-alpha-owner@sourceware.org
Content-Disposition: inline
In-Reply-To: <20170116151156.GI28060@E107787-LIN>
To: Yao Qi <qiyaoltc@gmail.com>
Cc: linux-arch@vger.kernel.org, Florian Weimer <fweimer@redhat.com>, libc-alpha@sourceware.org, Ard Biesheuvel <ard.biesheuvel@linaro.org>, Marc Zyngier <Marc.Zyngier@arm.com>, gdb@sourceware.org, Christoffer Dall <christoffer.dall@linaro.org>, Szabolcs Nagy <szabolcs.nagy@arm.com>, linux-arm-kernel@lists.infradead.org, Alan Hayward <alan.hayward@arm.com>, Torvald Riegel <triegel@redhat.com>, Joseph Myers <joseph@codesourcery.com>
List-Id: linux-arch.vger.kernel.org

On Mon, Jan 16, 2017 at 03:11:56PM +0000, Yao Qi wrote:
> On 17-01-16 13:32:31, Dave Martin wrote:
> > On Mon, Jan 16, 2017 at 12:20:38PM +0000, Yao Qi wrote:
> > > On 17-01-12 11:26:07, Dave Martin wrote:
> > > > This patch adds support for manipulating a task's vector length at
> > > > runtime via ptrace.
> > > > 
> > > 
> > > I hope kernel doesn't provide such interface to ptracer to change vector
> > > length.
> > 
> > It does, with this patch, beacuse...
> > 
> > > The vector length is sort of a read-only property of thread/process/
> > > program to debugger, unless we really have a clear requirement to modify
> > > vector length in debugging.  I may miss something because I haven't debug
> > > SVE code yet.
> > 
> > ...the vector length is no longer read-only for the task, thanks to
> > the new prctls().
> 
> What I meant "read-only" is that debugger can't change it, while the program
> itself can change it via prctl().

I see.

> > 
> > This does add complexity, but I figured that any programmer's model
> > state that the thread can modify for itself should be modifiable by the
> > debugger, if for no other reason than the user may want to experiment to
> > see what happens.  Without a ptrace interface, it would be necessary
> > to inject a prctl() call into the target, which is possible but awkward.
> 
> We only need such interface if it is useful, see more below.
> 
> Suppose it is useful to change vector length through ptrace, we should align
> ptrace interface to prctl() as much as possible.  Looks that both prctl
> change and ptrace change can go through sve_set_vector_length, easy to keep
> two consistent.
> 
> > 
> > gdb must already re-detect the vector length on stop, since the target
> > could have called the prctl() in the meantime.
> 
> Yes, gdb assumes the vector length may be changed, so it re-detects on
> every stop, but I don't see the need for gdb to change the vector length.
> 
> > 
> > Access via ptrace also allows things like trapping on exec, fork or
> > clone and changing the vector length for the new process or thread
> > before it starts to run.  I'm guessing here, but such a scenario seems
> > legitimate (?)
> > 
> 
> Yes, these cases are valid, but the usefulness is still questionable to
> me.  I just doubt that SVE developers do need to change vector length
> when they are debugging code.  Note that it is not my strong objection
> to this patch, if kernel people believe this is useful, I am fine with
> it.

That's fair.  I'll leave the patch there for now and see if anyone else
has a comment to make, but it could be removed without affecting
anything else.

Are there situations in which injecting a function call into the target
won't work, i.e., where we couldn't do:

set prctl(...)

?

Using the prctl interface this way, it would also be preferable to refer
to the #defines by name.

Cheers
---Dave
