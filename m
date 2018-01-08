From: Dan Williams <dan.j.williams@intel.com>
Subject: Re: [PATCH 06/18] x86, barrier: stop speculation for failed access_ok
Date: Mon, 8 Jan 2018 15:53:17 -0800
Message-ID: <CAPcyv4iEun8Xa-Sg+7=B2iVv1Ue7L06BqOggPWC5a6wn3HXj1w@mail.gmail.com>
References: <151520099201.32271.4677179499894422956.stgit@dwillia2-desk3.amr.corp.intel.com>
 <151520102670.32271.8447983009852138826.stgit@dwillia2-desk3.amr.corp.intel.com>
 <CA+55aFzeCHgAtz4vCR9YaUxkuesCNEht56dKJmpytx2A-JmJkg@mail.gmail.com>
 <CA+55aFzJgyk7peXyuNO8wgm0ZfSY2K-52XA9z=R6JGKcD6hQYw@mail.gmail.com>
 <CAPcyv4gx+2Dh6HS8e+TKNKP00+rYUkzGnEwdpZ_P6hFiOHKHNg@mail.gmail.com>
 <CA+55aFwa+1HiQo3aX9SZb21s7zQRqc5B40wgMMdsrYG0MJLknQ@mail.gmail.com>
 <CAPcyv4hVX4h9j-Uf=Ja5_0p3+qiWOiPd4cUaxoJD9en5TiVGPw@mail.gmail.com> <CA+55aFwU4nxo7yMN9bUmCK_f-yp2f3KQ=ot_epW7yuKwwZ8uCQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mail-oi0-f67.google.com ([209.85.218.67]:33630 "EHLO
        mail-oi0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751491AbeAHXxS (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 8 Jan 2018 18:53:18 -0500
Received: by mail-oi0-f67.google.com with SMTP id y141so2801024oia.0
        for <linux-arch@vger.kernel.org>; Mon, 08 Jan 2018 15:53:18 -0800 (PST)
In-Reply-To: <CA+55aFwU4nxo7yMN9bUmCK_f-yp2f3KQ=ot_epW7yuKwwZ8uCQ@mail.gmail.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-arch@vger.kernel.org, Andi Kleen <ak@linux.intel.com>, Arnd Bergmann <arnd@arndb.de>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Peter Zijlstra <peterz@infradead.org>, Network Development <netdev@vger.kernel.org>, the arch/x86 maintainers <x86@kernel.org>, Ingo Molnar <mingo@redhat.com>, "H. Peter Anvin" <hpa@zytor.com>, Thomas Gleixner <tglx@linutronix.de>, Alan Cox <alan@linux.intel.com>

On Mon, Jan 8, 2018 at 3:44 PM, Linus Torvalds
<torvalds@linux-foundation.org> wrote:
> On Mon, Jan 8, 2018 at 1:09 PM, Dan Williams <dan.j.williams@intel.com> wrote:
>> On Sat, Jan 6, 2018 at 5:20 PM, Linus Torvalds
>> <torvalds@linux-foundation.org> wrote:
>>> On Sat, Jan 6, 2018 at 3:31 PM, Dan Williams <dan.j.williams@intel.com> wrote:
>>>>
>>>> I assume if we put this in uaccess_begin() we also need audit for
>>>> paths that use access_ok but don't do on to call uaccess_begin()? A
>>>> quick glance shows a few places where we are open coding the stac().
>>>> Perhaps land the lfence in stac() directly?
>>>
>>> Yeah, we should put it in uaccess_begin(), and in the actual user
>>> accessor helpers that do stac. Some of them probably should be changed
>>> to use uaccess_begin() instead while at it.
>>>
>>> One question for the CPU people: do we actually care and need to do
>>> this for things that might *write* to something? The speculative write
>>> obviously is killed, but does it perhaps bring in a cacheline even
>>> when killed?
>>
>> As far as I understand a write could trigger a request-for-ownership
>> read for the target cacheline.
>
> Oh, absolutely.
>
> I just wonder at what point that happens.
>
> Honestly, trying to get exclusive access to a cacheline can be _very_
> expensive (not just for the local thread), so I would actually expect
> that doing so for speculative writes is actually bad for performance.
>
> That's doubly true because - unlike reads - there is no critical
> latency issue, so trying to get the cache access started as early as
> possible simply isn't all that important.
>
> So I suspect that a write won't actually try to allocate the cacheline
> until the write has actually retired.
>
> End result: writes - unlike reads - *probably* will not speculatively
> perturb the cache with speculative write addresses.
>
>> Even though writes can trigger reads, as far as I can see the write
>> needs to be dependent on the first out-of-bounds read
>
> Yeah. A write on its own wouldn't matter, even if it were to perturb
> the cache state, because the address already comes from user space, so
> there's no new information in the cache perturbation for the attacker.
>
> But that all implies that we shouldn't need the lfence for the
> "put_user()" case, only for the get_user() (where the value we read
> would then perhaps be used to do another access).
>
> So we want to add the lfence (or "and") to get_user(), but not
> necessarily put_user().

Yes, perhaps __uaccess_begin_get() and __uaccess_begin_put() to keep
things separate?

> Agreed?

I've been thinking the "and" is only suitable for the array bounds
check, for get_user() we're trying to block speculation past
access_ok() at which point we can only do the lfence?
