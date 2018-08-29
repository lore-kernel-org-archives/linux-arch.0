From: Andy Lutomirski <luto@kernel.org>
Subject: Re: [RFC PATCH 5/6] x86/alternatives: use temporary mm for text poking
Date: Wed, 29 Aug 2018 08:46:04 -0700
Message-ID: <CALCETrXe9CUMo3c44UtmkxD4w68PvmoypdCyvCFvWiZVuxy=sQ@mail.gmail.com>
References: <20180829081147.184610-1-namit@vmware.com> <20180829081147.184610-6-namit@vmware.com>
 <20180829092839.GP24124@hirez.programming.kicks-ass.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180829092839.GP24124@hirez.programming.kicks-ass.net>
Sender: linux-kernel-owner@vger.kernel.org
To: Peter Zijlstra <peterz@infradead.org>
Cc: Nadav Amit <namit@vmware.com>, Thomas Gleixner <tglx@linutronix.de>, LKML <linux-kernel@vger.kernel.org>, Ingo Molnar <mingo@redhat.com>, X86 ML <x86@kernel.org>, Arnd Bergmann <arnd@arndb.de>, linux-arch <linux-arch@vger.kernel.org>, Andy Lutomirski <luto@kernel.org>, Masami Hiramatsu <mhiramat@kernel.org>, Kees Cook <keescook@chromium.org>
List-Id: linux-arch.vger.kernel.org

On Wed, Aug 29, 2018 at 2:28 AM, Peter Zijlstra <peterz@infradead.org> wrote:
> On Wed, Aug 29, 2018 at 01:11:46AM -0700, Nadav Amit wrote:

>> +     pte_clear(poking_mm, poking_addr, ptep);
>> +
>> +     /*
>> +      * __flush_tlb_one_user() performs a redundant TLB flush when PTI is on,
>> +      * as it also flushes the corresponding "user" address spaces, which
>> +      * does not exist.
>> +      *
>> +      * Poking, however, is already very inefficient since it does not try to
>> +      * batch updates, so we ignore this problem for the time being.
>> +      *
>> +      * Since the PTEs do not exist in other kernel address-spaces, we do
>> +      * not use __flush_tlb_one_kernel(), which when PTI is on would cause
>> +      * more unwarranted TLB flushes.
>> +      */
>
> yuck :-), but yeah.

I'm sure we covered this ad nauseum when PTI was being developed, but
we were kind of in a rush, so:

Why do we do INVPCID at all?  The fallback path for non-INVPCID
systems uses invalidate_user_asid(), which should be faster than the
invpcid path.  And doesn't do a redundant flush in this case.

Can we just drop the INVPCID?  While we're at it, we could drop
X86_FEATURE_INVPCID_SINGLE entirely, since that's the only user.

--Andy
