From: Dan Williams <dan.j.williams@intel.com>
Subject: Re: [PATCH 16/18] net: mpls: prevent bounds-check bypass via
 speculative execution
Date: Tue, 9 Jan 2018 10:01:47 -0800
Message-ID: <CAPcyv4jQ=2s25keWbk-6bHK=xqeKbvbd0wX5319Csgg+iM+b2w@mail.gmail.com>
References: <151520099201.32271.4677179499894422956.stgit@dwillia2-desk3.amr.corp.intel.com>
 <151520108080.32271.16420298348259030860.stgit@dwillia2-desk3.amr.corp.intel.com>
 <87lgh7n2tf.fsf@xmission.com> <CAPcyv4iErvcOOSkaQbMa=9OJCmxNO7sDqi3qzg2ODvKqCApULQ@mail.gmail.com>
 <87373fj9bv.fsf@xmission.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mail-ot0-f196.google.com ([74.125.82.196]:41121 "EHLO
        mail-ot0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755932AbeAISBs (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 9 Jan 2018 13:01:48 -0500
Received: by mail-ot0-f196.google.com with SMTP id 5so4089150oth.8
        for <linux-arch@vger.kernel.org>; Tue, 09 Jan 2018 10:01:48 -0800 (PST)
In-Reply-To: <87373fj9bv.fsf@xmission.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: "Eric W. Biederman" <ebiederm@xmission.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-arch@vger.kernel.org, Peter Zijlstra <peterz@infradead.org>, Netdev <netdev@vger.kernel.org>, Greg KH <gregkh@linuxfoundation.org>, Thomas Gleixner <tglx@linutronix.de>, Linus Torvalds <torvalds@linux-foundation.org>, "David S. Miller" <davem@davemloft.net>, Elena Reshetova <elena.reshetova@intel.com>, Alan Cox <alan@linux.intel.com>

On Tue, Jan 9, 2018 at 8:17 AM, Eric W. Biederman <ebiederm@xmission.com> wrote:
> Dan Williams <dan.j.williams@intel.com> writes:
[..]
> The user controlled value condition of your patchset implies that you
> assume indirect branch predictor poisoning is handled in other ways.
>
> Which means that we can assume speculation will take some variation of
> the static call chain.
>
> Further you are worrying about array accesses.  Which means you
> are worried about attacks that are the equivalent of meltdown that
> can give you reading of all memory available to the kernel.
>
>
> The mpls code in question reads a pointer from memory.
>
>
> The only thing the code does with that pointer is verify it is not NULL
> and dereference it.
>
> That does not make it possible to extricate the pointer bits via a cache
> side-channel as a pointer is 64bits wide.
>
> There might maybe be a timing attack where it is timed how long the
> packet takes to deliver.  If you can find the base address of the array,
> at best such a timeing attack will tell you is if some arbitrary cache
> line is already cached in the kernel.  Which is not the class of attack
> your patchset is worried about.  Further there are more direct ways
> to probe the cache from a local process.
>
> So I submit to you that the mpls code is not vulnerable to the class of
> attack you are addressing.
>
> Further I would argue that anything that reads a pointer from memory is
> a very strong clue that it falls outside the class of code that you are
> addressing.
>
> Show me where I am wrong and I will consider patches.

No, the concern is a second dependent read (or write) within the
speculation window after this first bounds-checked dependent read.
I.e. this mpls code path appears to have the setup condition:

    if (x < max)
        val = array1[x];

...but it's not clear that there is an exploit condition later on in
the instruction stream:

        array2[val] = y;
        /* or */
        y = array2[val];

My personal paranoia says submit the patch and not worry about finding
that later exploit condition, if DaveM wants to drop the patch that's
his prerogative. In general, with the performance conscious version of
nospec_array_ptr() being the default, why worry about what is / is not
in the speculation window?
