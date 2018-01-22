From: Andy Lutomirski <luto@kernel.org>
Subject: Re: [kernel-hardening] Re: [PATCH v4.1 07/10] x86: narrow out of
 bounds syscalls to sys_read under speculation
Date: Sun, 21 Jan 2018 18:23:59 -0800
Message-ID: <CALCETrWUrm3Vj7cSY0V8U6VDp2z43QzeVqWGVdmzqiZ93aJoTA@mail.gmail.com>
References: <151648235823.34747.15181877619346237802.stgit@dwillia2-desk3.amr.corp.intel.com>
 <151648239535.34747.4422108674633222531.stgit@dwillia2-desk3.amr.corp.intel.com>
 <867402A5-BED8-4A44-9770-7D3B153BEE82@amacapital.net> <CAG48ez3dWLJEoiUOLKRD3e8uJmAz87FNQB5MOLTxJg=y3KahRw@mail.gmail.com>
 <CALCETrVxf06iNYWUxtsBU4ApNSK0jbnEUBoSvnGGQ7z1cyPJ9A@mail.gmail.com> <CA+55aFxLOMcSfodeV5WV=n0+tuz7rVs4bEtnfv9qT9c8H0TfLA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:51676 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751092AbeAVCYV (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Sun, 21 Jan 2018 21:24:21 -0500
Received: from mail-it0-f47.google.com (mail-it0-f47.google.com [209.85.214.47])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id EDCE221795
        for <linux-arch@vger.kernel.org>; Mon, 22 Jan 2018 02:24:20 +0000 (UTC)
Received: by mail-it0-f47.google.com with SMTP id x42so8234728ita.4
        for <linux-arch@vger.kernel.org>; Sun, 21 Jan 2018 18:24:20 -0800 (PST)
In-Reply-To: <CA+55aFxLOMcSfodeV5WV=n0+tuz7rVs4bEtnfv9qT9c8H0TfLA@mail.gmail.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Andy Lutomirski <luto@kernel.org>, Jann Horn <jannh@google.com>, Dan Williams <dan.j.williams@intel.com>, Thomas Gleixner <tglx@linutronix.de>, linux-arch <linux-arch@vger.kernel.org>, Kernel Hardening <kernel-hardening@lists.openwall.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, the arch/x86 maintainers <x86@kernel.org>, Ingo Molnar <mingo@redhat.com>, "H. Peter Anvin" <hpa@zytor.com>, Alan Cox <alan@linux.intel.com>

On Sun, Jan 21, 2018 at 6:04 PM, Linus Torvalds
<torvalds@linux-foundation.org> wrote:
> On Sun, Jan 21, 2018 at 5:38 PM, Andy Lutomirski <luto@kernel.org> wrote:
>>
>> 3. What's with sbb; and?  I can see two sane ways to do this.  One is
>> cmovaq [something safe], %rax,
>
> Heh. I think it's partly about being old-fashioned. sbb has always
> been around, and is the traditional trick for 0/-1.
>
> Also, my original suggested thing did the *access* too, and masked the
> result with the same mask.
>
> But I guess we could use cmov instead. It has very similar performance
> (ie it was relatively slow on P4, but so was sbb).
>
> However, I suspect it actually has a slightly higher register
> pressure, since you'd need to have that zero register (zero being the
> "safe" value), and the only good way to get a zero value is the xor
> thing, which affects flags and thus needs to be before the cmp.
>
> In contrast, the sbb trick has no early inputs needed.
>
> So on the whole, 'cmov' may be more natural on a conceptual level, but
> the sbb trick really is a very "traditional x86 thing" to do.

Fair enough.

That being said, what I *actually* want to do is to nuke this thing
entirely.  I just wrote a patch to turn off the SYSCALL64 fast path
entirely when retpolines are on.  Then this issue can be dealt with in
C.  I assume someone has a brilliant way to make gcc automatically do
something intelligent about guarded array access in C. </snicker>
Seriously, though, the retpolined fast path is actually slower than
the slow path on a "minimal" retpoline kernel (which is what I'm using
because Fedora hasn't pushed out a retpoline compiler yet), and I
doubt it's more than the tiniest speedup on a full retpoline kernel.

I've read a bunch of emails flying around saying that retpolines
aren't that bad.  In very informal benchmarking, a single mispredicted
ret (which is what a retpoline is) seems to take 20-30 cycles on
Skylake.  That's pretty far from "not bad".  Is IBRS somehow doing
something that adversely affects code that doesn't use indirect
branches?  Because I'm having a bit of a hard time imagining IBRS
hurting indirect branches worse than retpolines do.
