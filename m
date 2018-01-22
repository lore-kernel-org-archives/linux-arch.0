From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH v4.1 02/10] asm/nospec, array_ptr: sanitize speculative
 array de-references
Date: Mon, 22 Jan 2018 10:37:58 -0800
Message-ID: <CA+55aFyqAGRE4+QteYyvNyMzepFXHVVBn=A07Adj-yBs=tS_Ww@mail.gmail.com>
References: <151648235823.34747.15181877619346237802.stgit@dwillia2-desk3.amr.corp.intel.com>
 <151648236968.34747.390507912161115784.stgit@dwillia2-desk3.amr.corp.intel.com>
 <20180121104019.GS17719@n2100.armlinux.org.uk> <CAPcyv4iY9PWULZfGnKnTiD4tVxHSw4QfSwUBV4d=1KfnUjbgWw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mail-io0-f177.google.com ([209.85.223.177]:44335 "EHLO
        mail-io0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751113AbeAVSiB (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 22 Jan 2018 13:38:01 -0500
Received: by mail-io0-f177.google.com with SMTP id z6so10432617iob.11
        for <linux-arch@vger.kernel.org>; Mon, 22 Jan 2018 10:38:00 -0800 (PST)
In-Reply-To: <CAPcyv4iY9PWULZfGnKnTiD4tVxHSw4QfSwUBV4d=1KfnUjbgWw@mail.gmail.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Dan Williams <dan.j.williams@intel.com>
Cc: Russell King - ARM Linux <linux@armlinux.org.uk>, Thomas Gleixner <tglx@linutronix.de>, linux-arch <linux-arch@vger.kernel.org>, Kernel Hardening <kernel-hardening@lists.openwall.com>, Peter Zijlstra <peterz@infradead.org>, Catalin Marinas <catalin.marinas@arm.com>, X86 ML <x86@kernel.org>, Will Deacon <will.deacon@arm.com>, Ingo Molnar <mingo@redhat.com>, Greg KH <gregkh@linuxfoundation.org>, "H. Peter Anvin" <hpa@zytor.com>, Alan Cox <alan@linux.intel.com>

On Mon, Jan 22, 2018 at 10:07 AM, Dan Williams <dan.j.williams@intel.com> wrote:
> On Sun, Jan 21, 2018 at 2:40 AM, Russell King - ARM Linux
> <linux@armlinux.org.uk> wrote:
>>
>> I'd suggest changing the description to something like:
>>
>>   * If 0 <= idx < size, return a mask of ~0UL, otherwise return zero.

Yes. HOWEVER.

We should make it clear that the signedness of the comparisons is
undefined, and that 'size' should always be positive for the above to
be well-specified.

Why?

Because one valid implementation of the above is:

   idx U< size ? ~0UL : 0

as a single unsigned comparison (I'm using "U<" as a "unsigned less than").

But an equally valid implementation of it might be

   idx S>= 0 && idx S< size ? ~0UL : 0

which does two signed comparisons instead.

And they are not exactly the same. They are the same _IFF_ 'size' is
positive in 'long'. But if size is an unsigned value so big as to be
negative in 'long', they give different results for 'idx'.

In fact, the ALU-only version actually did a third version of the
above that only uses "signed comparison against zero":

   idx S> 0 && (size - idx - 1) S>= 0 ? ~0UL : 0

which again is equivalent only when 'size' is positive in 'long'.

Note that 'idx' itself can have any range (that's kind of the _point_,
after all: checking that idx is in some range). But the logic only
works for a positive array size.

Which honestly is not really a limitation, but it's worth spelling out, I think.

In particular, if you have a user pointer, and a 3G:1G split in
user:kernel address space, you camn *not* do something like

    uptr = array_ptr(NULL, userptr, TASK_SIZE);

to get a sanitized user pointer, because TASK_SIZE is not positive in 'long'.

Hmm?

                     Linus
