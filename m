From: Dave Martin <Dave.Martin@arm.com>
Subject: Re: [RFC PATCH 08/10] arm64/sve: ptrace: Wire up vector length
 control and reporting
Date: Thu, 19 Jan 2017 17:11:59 +0000
Message-ID: <20170119171157.GS3699@e103592.cambridge.arm.com>
References: <1484220369-23970-1-git-send-email-Dave.Martin@arm.com>
 <1484220369-23970-9-git-send-email-Dave.Martin@arm.com>
 <20170116122038.GG28060@E107787-LIN>
 <20170116133231.GO3699@e103592.cambridge.arm.com>
 <20170116151156.GI28060@E107787-LIN>
 <20170117100349.GR3699@e103592.cambridge.arm.com>
 <6610C1B4-C08A-4A15-B272-77A45F341168@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <libc-alpha-return-76874-glibc-alpha=m.gmane.org@sourceware.org>
List-Unsubscribe: <mailto:libc-alpha-unsubscribe-glibc-alpha=m.gmane.org@sourceware.org>
List-Subscribe: <mailto:libc-alpha-subscribe@sourceware.org>
List-Archive: <http://sourceware.org/ml/libc-alpha/>
List-Post: <mailto:libc-alpha@sourceware.org>
List-Help: <mailto:libc-alpha-help@sourceware.org>, <http://sourceware.org/ml/#faqs>
Sender: libc-alpha-owner@sourceware.org
Content-Disposition: inline
In-Reply-To: <6610C1B4-C08A-4A15-B272-77A45F341168@arm.com>
To: Alan Hayward <Alan.Hayward@arm.com>
Cc: "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>, Florian Weimer <fweimer@redhat.com>, nd <nd@arm.com>, "libc-alpha@sourceware.org" <libc-alpha@sourceware.org>, "ard.biesheuvel@linaro.org" <ard.biesheuvel@linaro.org>, Marc Zyngier <Marc.Zyngier@arm.com>, "gdb@sourceware.org" <gdb@sourceware.org>, Joseph Myers <joseph@codesourcery.com>, Yao Qi <qiyaoltc@gmail.com>, Szabolcs Nagy <Szabolcs.Nagy@arm.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, Torvald Riegel <triegel@redhat.com>, Christoffer Dall <christoffer.dall@linaro.org>
List-Id: linux-arch.vger.kernel.org

On Tue, Jan 17, 2017 at 01:31:03PM +0000, Alan Hayward wrote:
> 
> > On 17 Jan 2017, at 10:03, Dave Martin <Dave.Martin@arm.com> wrote:
> > 
> > On Mon, Jan 16, 2017 at 03:11:56PM +0000, Yao Qi wrote:
> >> On 17-01-16 13:32:31, Dave Martin wrote:
> >>> On Mon, Jan 16, 2017 at 12:20:38PM +0000, Yao Qi wrote:
> >>>> On 17-01-12 11:26:07, Dave Martin wrote:
> >>>>> This patch adds support for manipulating a task's vector length at
> >>>>> runtime via ptrace.
> >>>>> 
> >>>> 
> >>>> I hope kernel doesn't provide such interface to ptracer to change vector
> >>>> length.
> >>> 
> >>> It does, with this patch, beacuse...
> >>> 
> >>>> The vector length is sort of a read-only property of thread/process/
> >>>> program to debugger, unless we really have a clear requirement to modify
> >>>> vector length in debugging.  I may miss something because I haven't debug
> >>>> SVE code yet.
> >>> 
> >>> ...the vector length is no longer read-only for the task, thanks to
> >>> the new prctls().
> >> 
> >> What I meant "read-only" is that debugger can't change it, while the program
> >> itself can change it via prctl().
> > 
> > I see.
> > 
> >>> 
> >>> This does add complexity, but I figured that any programmer's model
> >>> state that the thread can modify for itself should be modifiable by the
> >>> debugger, if for no other reason than the user may want to experiment to
> >>> see what happens.  Without a ptrace interface, it would be necessary
> >>> to inject a prctl() call into the target, which is possible but awkward.
> >> 
> >> We only need such interface if it is useful, see more below.
> >> 
> >> Suppose it is useful to change vector length through ptrace, we should align
> >> ptrace interface to prctl() as much as possible.  Looks that both prctl
> >> change and ptrace change can go through sve_set_vector_length, easy to keep
> >> two consistent.
> >> 
> >>> 
> >>> gdb must already re-detect the vector length on stop, since the target
> >>> could have called the prctl() in the meantime.
> >> 
> >> Yes, gdb assumes the vector length may be changed, so it re-detects on
> >> every stop, but I don't see the need for gdb to change the vector length.
> >> 
> >>> 
> >>> Access via ptrace also allows things like trapping on exec, fork or
> >>> clone and changing the vector length for the new process or thread
> >>> before it starts to run.  I'm guessing here, but such a scenario seems
> >>> legitimate (?)
> >>> 
> >> 
> >> Yes, these cases are valid, but the usefulness is still questionable to
> >> me.  I just doubt that SVE developers do need to change vector length
> >> when they are debugging code.  Note that it is not my strong objection
> >> to this patch, if kernel people believe this is useful, I am fine with
> >> it.
> > 
> > That's fair.  I'll leave the patch there for now and see if anyone else
> > has a comment to make, but it could be removed without affecting
> > anything else.
> > 
> 
> I would say that whilst it is a very dangerous thing to do and has many

ptrace is inherently dangerous for the target task... that's rather the
point.

> consequences, there is a requirement for a gdb user to be able to change VL
> whilst debugging a running process, and I don’t think we should see
> changing VL as much different from changing a register value on the fly.
> 
> Say you have a loop in assembly you are trying to debug - you might write
> to $x2 and then single step to see how this effects the result. With SVE
> code you might want to see how different VL values will effect the layout
> of results in the vectors, how it effects the predicates and how it changes
> the number of iterations the loop makes. Of course, once you exit the
> loop all bets are off - just like if you had been changing register values.
> 
> The current proposal for gdb is that we will show $VL in the list of
> registers, therefore for consistency it’d make sense for the gdb user to
> be able to set it as if it was just another register. For this we need a
> simple way to change the VL in another process, and I think ptrace() is
> the easiest way (given that prctl() only changes its own process).

OK, I'll keep it for now, unless somebody has a strong objection.

It doesn't affect the underlying plumbing much -- doing this via
ptrace() is actually the simpler of the two options, since the task
is stopped and thus less synchronisation is needed.

Cheers
---Dave
