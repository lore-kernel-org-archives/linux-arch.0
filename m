From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [git pull] uaccess-related bits of vfs.git
Date: Sat, 13 May 2017 10:18:22 -0700
Message-ID: <CA+55aFwD+qC7MqSJVt4q91YEJ7CSzAZazWAJ-NpSz=B1k95AuA@mail.gmail.com>
References: <CA+55aFww=ZG0wPad3ELg+ibScr0eWuSxvhGLFaF+PO9kfkSkdw@mail.gmail.com>
 <20170501034536.GX29622@ZenIV.linux.org.uk> <CA+55aFwJXjvYQ7WLmh3z62KQ08XCR89Qh-koC=UTYW+enK6OPQ@mail.gmail.com>
 <20170513065745.GV390@ZenIV.linux.org.uk> <CA+55aFzrcX=B-m5SN1ajEopKbTLj1WcpKZWgdDTwYqoOBPJwaQ@mail.gmail.com>
 <20170513170056.GX390@ZenIV.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mail-io0-f193.google.com ([209.85.223.193]:34868 "EHLO
        mail-io0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752320AbdEMRSX (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Sat, 13 May 2017 13:18:23 -0400
In-Reply-To: <20170513170056.GX390@ZenIV.linux.org.uk>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Al Viro <viro@zeniv.linux.org.uk>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>

On Sat, May 13, 2017 at 10:00 AM, Al Viro <viro@zeniv.linux.org.uk> wrote:
> On Sat, May 13, 2017 at 09:15:07AM -0700, Linus Torvalds wrote:
>> > IOW, we have
>> >         * most of users in arch/* (heavily dominated by signal-related code,
>> > both loads and stores).  Those need careful massage; maybe unsafe-based
>> > solution, maybe something else, but it's obviously per-architecture work
>> > and these paths are sensitive.
>>
>> Why are they sensitive?
>
> Because there we do have tons of back-to-back __get_user() (on sigreturn())
> or __put_user() (on signal setup).

It doesn't actually matter. Regular "put_user()" doesn't generate
noticeably worse code.

It's not a normal function call, it's still an inline asm - so it
basically generates the exact same code as __xyz_user(), except it's a
call to a fixed copy of the code.

So the only difference tends to be
 (a) the extra call/ret instructions, possibly frame pointers
 (b) fixed registers
 (c) the added addr_limit checks

but (a) is cheap, and (b) isn't a big deal since with "asm volatile"
you can't re-order those things against each other anyway. So (b) ends
up being approximately the cost of "one extra lea instruction" for the
address generation that would otherwise be in the load/store
instruction.

And (c) is actually a reason *for* doing it. We've had bugs due to
people not getting it right.

So there really is basically no performance downside.  Even with
consecutive uses.  The code that uses a function call might even be
smaller (ie the 1.7kB savings isn't necessarily all in the out-of-line
exception handling cases: the stac/clac instructions are six bytes for
each use, so it more than makes up for the call instruction).

> x86 actually tends to use get_user_ex/put_user_ex instead.

Yes. Because anybody who *really* cared about performance will have
converted already. The real cost has been stac/clac for a few years
now.

So we pretty much know that none of the remaining users are really all
that critical. Certainly not "five cycles" kind of critical.

>> Anybody who *relies* on not checking the address_limit is so broken as
>> to be not even funny.
>
> Except for open-coded probe_kernel_read() somewhere in arch/*; I have not
> read through those 700+ callers, so I don't know if there's any such.

.. and those need to be fixed.

But I'm not seeing the point in wasting valuable human time in reading
through thousands of cases, when we can just automate it and see if
anything breaks.

Because it will break in a *safe* direction. You'll get an error from
bad uses that shouldn't have worked to begin with.

And some of the existing cases are just disgusting. There's no excuse
for compat code or for ioctl to use the "__" versions. That seems to
be the bulk of those uses too.

                     Linus
