From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: Re: rseq: How to test for compat task at signal delivery
Date: Tue, 26 Jun 2018 17:19:44 -0400 (EDT)
Message-ID: <1453026995.6388.1530047984544.JavaMail.zimbra@efficios.com>
References: <1514459655.4190.1530034687884.JavaMail.zimbra@efficios.com> <170076903.5015.1530038711536.JavaMail.zimbra@efficios.com> <CALCETrXimh61U7Tn9KShr6sKag7NCL3qfraN18Oy2Bk+0VRAUA@mail.gmail.com> <1277536320.5963.1530042608296.JavaMail.zimbra@efficios.com> <CALCETrWhY_+SxKt9Xq2ruiGk8GQeYvrojy84w_Quosrf5fpApQ@mail.gmail.com> <1352608225.6039.1530043932895.JavaMail.zimbra@efficios.com> <CALCETrVs57TZf4V4vrCkh2Aa_x=+HuVO5hYB5yFmS1VqE5rcuw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CALCETrVs57TZf4V4vrCkh2Aa_x=+HuVO5hYB5yFmS1VqE5rcuw@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Andy Lutomirski <luto@amacapital.net>
Cc: linux-arch <linux-arch@vger.kernel.org>, Peter Zijlstra <peterz@infradead.org>, Boqun Feng <boqun.feng@gmail.com>, linux-kernel <linux-kernel@vger.kernel.org>, "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>, Thomas Gleixner <tglx@linutronix.de>
List-Id: linux-arch.vger.kernel.org

----- On Jun 26, 2018, at 4:46 PM, Andy Lutomirski luto@amacapital.net wrote:

> On Tue, Jun 26, 2018 at 1:12 PM Mathieu Desnoyers
> <mathieu.desnoyers@efficios.com> wrote:
>>
>> ----- On Jun 26, 2018, at 3:55 PM, Andy Lutomirski luto@amacapital.net wrote:
>>
>> > On Tue, Jun 26, 2018 at 12:50 PM Mathieu Desnoyers
>> > <mathieu.desnoyers@efficios.com> wrote:
>> >>
>> >> ----- On Jun 26, 2018, at 3:32 PM, Andy Lutomirski luto@amacapital.net wrote:
>> >>
>> >> > On Tue, Jun 26, 2018 at 11:45 AM Mathieu Desnoyers
>> >> > <mathieu.desnoyers@efficios.com> wrote:
>> >> >>
>> >> >> ----- On Jun 26, 2018, at 1:38 PM, Mathieu Desnoyers
>> >> >> mathieu.desnoyers@efficios.com wrote:
>> >> >>
>> >> >> > Hi Andy,
>> >> >> >
>> >> >> > I would like to make the behavior rseq on compat tasks more robust
>> >> >> > by ensuring that kernel/rseq.c:rseq_get_rseq_cs() clears the high
>> >> >> > bits of rseq_cs->abort_ip, rseq_cs->start_ip and
>> >> >> > rseq_cs->post_commit_offset when a 32-bit binary is run on a 64-bit
>> >> >> > kernel.
>> >> >> >
>> >> >> > The intent here is that if user-space has garbage rather than zeroes
>> >> >> > in its struct rseq_cs fields padding, the behavior will be the same
>> >> >> > whether the binary is run on 32-bit or 64 kernels.
>> >> >> >
>> >> >> > I know that internally, the kernel is making a transition from
>> >> >> > is_compat_task() to in_compat_syscall().
>> >> >> >
>> >> >> > I'm fine with using in_compat_syscall() when rseq_get_rseq_cs() is
>> >> >> > invoked from a system call, but is it OK to call it when it is
>> >> >> > invoked from signal delivery ? AFAIU, signals can be delivered
>> >> >> > upon return from interrupt as well.
>> >> >> >
>> >> >> > If not, what strategy do you recommend for arch-agnostic code ?
>> >> >>
>> >> >> I think what we're missing here is a new "is_compat_frame(struct ksignal *ksig)"
>> >> >> which I could use in the rseq code. I'll prepare a patch and we can discuss
>> >> >> from there.
>> >> >>
>> >> >
>> >> > That sounds about right.
>> >> >
>> >> > I'm confused, though.  Wouldn't it be more consistent to just segfault
>> >> > if the high 32 bits are not clear when rseq transitions to a 32-bit
>> >> > context?  If there's garbage in 64-bit mode, the program will crash.
>> >> > Why should 32-bit mode be any different?
>> >>
>> >> Currently, if a 32-bit binary puts garbage in the high bits of
>> >> start_ip, post_commit_offset, and abort_ip in
>> >>
>> >> include/uapi/linux/rseq.h:
>> >>
>> >> struct rseq_cs {
>> >>         /* Version of this structure. */
>> >>         __u32 version;
>> >>         /* enum rseq_cs_flags */
>> >>         __u32 flags;
>> >>         LINUX_FIELD_u32_u64(start_ip);
>> >>         /* Offset from start_ip. */
>> >>         LINUX_FIELD_u32_u64(post_commit_offset);
>> >>         LINUX_FIELD_u32_u64(abort_ip);
>> >> } __attribute__((aligned(4 * sizeof(__u64))));
>> >
>> > This ABI isn't real ABI until a stable kernel happens, right?  So how
>> > about just making all those fields be u64?
>>
>> Good point. Unlike the rseq_cs field in the struct rseq TLS, those
>> fields don't need to be word-sized/word-aligned, so we could simply
>> declare them as __u64.
>>
>> >
>> >>
>> >> A 32-bit kernel just never reads the padding, thus in reality acting
>> >> as if those were zeroes. However, a 64-bit kernel dealing with this
>> >> 32-bit compat task will read that padding, handling those as very
>> >> large values.
>> >
>> > Sounds like a design error.  Have all kernels read the fields no
>> > matter what.  A 32-bit kernel will send SIGSEGV if the high bits are
>> > set.  A 64-bit kernel running compat userspace should make sure that a
>> > 32-bit task dies if the high bits are set.
>>
>> If we end up declaring those as __u64, that approach makes sense.
>>
>> >
>> >>
>> >> We need to improve that by introducing a consistent behavior across
>> >> native 32-bit kernels and 32-bit compat mode on 64-bit kernels.
>> >>
>> >> There are two ways to achieve this: either the 32-bit kernel validates
>> >> the padding by killing the process if padding is non-zero, or the
>> >> 64-bit kernel treats compat mode by zeroing the high bits of padding.
>> >>
>> >> If we look at system call interfaces in general, I think the usual
>> >> approach is to clear the top bits whenever a value read from a
>> >> compat task ends up being used as a pointer. This is why I am tempted
>> >> to go for the "clear high bits" approach rather than killing the task.
>> >
>> > I think the modern preference is to use fields of fixed size rather
>> > than long when UABI is involved.
>> >
>> > In any event, I think the test you want is user_64bit_mode().
>>
>> Currently, user_64bit_mode is only implemented on x86.
>>
>> Should we introduce an architecture-agnostic user_64bit_mode(struct pt_regs *)
>> which maps to is_compat_task() for non-x86 ? I'm just worried that ptrace
>> code could try to use it from the context of another task and get mixed up.
> 
> I'm not sure other archs can do this.  It might need to have a
> task_struct pointer, too.
> 
> But I think the only actual consideration is that a lot of
> architectures might fail to kill the task if the task is 32-bit and
> regs->ip or regs->sp ends up with garbage in the high bits.  Certainly
> x86 is not consistent about this.  So maybe a helper to fully validate
> all 64 bits of ip and sp or perhaps helpers to set them and check for
> full validity would be better.  Like:
> 
> void set_task_64bit_ip_or_signal(struct task_struct *, u64 value);
> 
> that promises to actually signal the task if value is garbage?
> 
> Let's ask linux-arch here.  I'm not nearly familiar enough with the
> nasty details of other compat-capable architectures.  x86 is very,
> very, very inconsistent about how what the high bits of the registers
> mean, and there are cases where the "high bits" involved are actually
> the high 48 bits, not the high 32 bits.  Sigh.

For the records, I just sent out 2 patches as RFC implementing the
is_compat_frame() approach, and clearing the high bits for compat tasks.

It has the merit to be straightforward and introduce few changes at
this stage of the -rc.

Thanks,

Mathieu


-- 
Mathieu Desnoyers
EfficiOS Inc.
http://www.efficios.com
