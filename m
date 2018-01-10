From: Dan Williams <dan.j.williams@intel.com>
Subject: Re: [PATCH 16/18] net: mpls: prevent bounds-check bypass via
 speculative execution
Date: Tue, 9 Jan 2018 17:31:09 -0800
Message-ID: <CAPcyv4heZ2pGQMzdMNO4DqLX=0g-KdV5xropXSEAdq9aC=eVbg@mail.gmail.com>
References: <151520099201.32271.4677179499894422956.stgit@dwillia2-desk3.amr.corp.intel.com>
 <151520108080.32271.16420298348259030860.stgit@dwillia2-desk3.amr.corp.intel.com>
 <87lgh7n2tf.fsf@xmission.com> <CAPcyv4iErvcOOSkaQbMa=9OJCmxNO7sDqi3qzg2ODvKqCApULQ@mail.gmail.com>
 <87373fj9bv.fsf@xmission.com> <CAPcyv4jQ=2s25keWbk-6bHK=xqeKbvbd0wX5319Csgg+iM+b2w@mail.gmail.com>
 <87bmi2edod.fsf@xmission.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mail-ot0-f177.google.com ([74.125.82.177]:37103 "EHLO
        mail-ot0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752980AbeAJBbK (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 9 Jan 2018 20:31:10 -0500
Received: by mail-ot0-f177.google.com with SMTP id p31so13012804ota.4
        for <linux-arch@vger.kernel.org>; Tue, 09 Jan 2018 17:31:10 -0800 (PST)
In-Reply-To: <87bmi2edod.fsf@xmission.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: "Eric W. Biederman" <ebiederm@xmission.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-arch@vger.kernel.org, Peter Zijlstra <peterz@infradead.org>, Netdev <netdev@vger.kernel.org>, Greg KH <gregkh@linuxfoundation.org>, Thomas Gleixner <tglx@linutronix.de>, Linus Torvalds <torvalds@linux-foundation.org>, "David S. Miller" <davem@davemloft.net>, Elena Reshetova <elena.reshetova@intel.com>, Alan Cox <alan@linux.intel.com>

On Tue, Jan 9, 2018 at 4:54 PM, Eric W. Biederman <ebiederm@xmission.com> wrote:
> Dan Williams <dan.j.williams@intel.com> writes:
[..]
> Sigh.
> I am not worrying about what is in the speculation window.  My
> assumption is that the speculation window could be infinite, as we don't
> know the limitations of all possible processors.
>
> I am saying there is not a way to get the data out of the speculation
> window.
>
> I was saying that when you have:
>         if (x < max)
>                 val = array1[x];
>
> When val is a pointer not an integer.
> Then
>         array2[val] = y;
>         /* or */
>         y = array2[va];
>
> Won't happen.
>
>         val->field;
>
> Will happen.
>
> Which looks similar.  However the address space of pointers is too
> large.  Making it impossible for an attack to know where to look in the
> cache to see if "val->field" happened.  At least on the assumption that
> val is an arbitrary value.
>
> Further mpls_forward is small enough the entire scope of "rt" the value
> read possibly past the bound check is auditable without too much
> trouble.  I have looked and I don't see anything that could possibly
> allow the value of "rt" to be exfitrated.  The problem continuing to be
> that it is a pointer and the only operation on the pointer besides
> derferencing it is testing if it is NULL.
>
> Other types of timing attacks are very hard if not impossible because
> any packet presenting with a value outside the bounds check will be
> dropped.  So it will hard if not impossible to find something to time to
> see how long it took to drop the packet.
>
> So no this code path does not present with the classic signature of
> variant 1: bounds check bypass CVE-2017-5753
>
> Show me where I am wrong and I will gladly take patches.  As it is the
> mpls fast path does not appear vulnerable to the issue you are
> addressing.  So the best thing we can do for performance is nothing at
> all.

That's completely valid. Let's drop this one.

> All I am after is a plausible scenario.  I just want to see it spelled
> out which combinations of things could possibly be a problem.

In fact, I'm not here to spell out the speculative execution problem
in this path beyond the initial user controlled speculative read. As
noted in the cover letter thread, this and the other patches are
simply reports that are fully expected to be resolved as false
positives by sub-system owners in some cases. I'm otherwise more
focused in landing common infrastructure that could be used in the
future as data-flow-analysis tooling improves to find these locations
with higher accuracy. In other words, the goal at the end of this
exercise is to identify a default nospec_array_ptr() implementation
that all sub-systems could accept for when the problem report turns
out to be real, and your pushback has already resulted in good
discussion of alternate nospec_array_ptr() implementations.

Thanks for your patience to keep the conversation going.
