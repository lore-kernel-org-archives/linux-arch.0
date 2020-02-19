From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [RFC] regset ->get() API
Date: Wed, 19 Feb 2020 12:01:54 -0800
Message-ID: <CAHk-=wivKU1eP8ir4q5xEwOV0hsomFz7DMtiAot__X2zU-yGog@mail.gmail.com>
References: <20200217183340.GI23230@ZenIV.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mail-lj1-f193.google.com ([209.85.208.193]:39825 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726703AbgBSUCQ (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 19 Feb 2020 15:02:16 -0500
Received: by mail-lj1-f193.google.com with SMTP id o15so1695399ljg.6
        for <linux-arch@vger.kernel.org>; Wed, 19 Feb 2020 12:02:14 -0800 (PST)
Received: from mail-lf1-f47.google.com (mail-lf1-f47.google.com. [209.85.167.47])
        by smtp.gmail.com with ESMTPSA id b8sm359113lfb.13.2020.02.19.12.02.11
        for <linux-arch@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 19 Feb 2020 12:02:12 -0800 (PST)
Received: by mail-lf1-f47.google.com with SMTP id y19so1113128lfl.9
        for <linux-arch@vger.kernel.org>; Wed, 19 Feb 2020 12:02:11 -0800 (PST)
In-Reply-To: <20200217183340.GI23230@ZenIV.linux.org.uk>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Al Viro <viro@zeniv.linux.org.uk>
Cc: linux-arch <linux-arch@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Arnd Bergmann <arnd@arndb.de>

On Mon, Feb 17, 2020 at 10:33 AM Al Viro <viro@zeniv.linux.org.uk> wrote:
>
>         Looking at the regset guts, I really wonder if the interface
> is right.

No, it's not right, but it has a history. I think it comes from the
internal gdb model, and Roland - who was used to that model - then
modelled the kernel internals roughly similarly.

But part of it is that the user interfaces have evolved over time too,
with the original one being the "get one register using magical
PTRACE_{PEEK,POKE}USR", and then because that performs horribly badly,
there's now a PTRACE_GETREGSET.

And yes, because of the gdb history, some of the interfaces make no
sense for the kernel. Like

> For another, the calling conventions are too generic - the callers
> of ->get() always pass zero for pos, for example.

I think that comes from the historical PTRACE_{PEEK,POKE}USR case,
where gdb has a unifying interface for getting one register (using
PEEKUSR) vs getting the whole regset (using GETREGSET).

But in the kernel, we never actually got to the point where this was
generalized. Each architecture keeps its own PEEKUSR implementation,
and then there is that generic GETREGSET interface that is completely
separate.

End result: ->get is never actually used for individual registers.

So yes, you always have a zero position, because you always basically
get the whole thing. But the interface was written on the assumption
that some day the PEEKUSR thing would also be generalized.

Except absolutely nobody wants to touch that code, and it's hard to do
because it's so architecture-specific anyway, and you can't switch
over to a generic model for PEEKUSR until _all_ architectures have
done it, so it's never going to happen.

Anyway, that's the explanation for the bad interface.

That is not an excuse for _keeping_ the bad interface, though. It's
just that effectively the interface was done overr a decade ago, and
absolutely nobody has ever shown any interest in touching it since.
"It works, don't touch it".

> What I really wonder is whether it's actually worth bothering - the
> life would be much simpler if we *always* passed a kernel buffer to
> ->get() instances and did all copyout at once.

I don't mind it, but some of those buffers are big, and the generic
code generally doesn't know how big.

You'd probably have to have a whole page to pass in as the buffer -
certainly not some stack space.

Maybe even more. I'm not sure how big the FPU regset can get on x86...

But yes, I'd love to see somebody (you, apparently) carefully simplify
that interface. And I do not think anybody will object - the biggest
issue is that this touches code across all architectures, and some of
them are not having a lot of maintenance.

If you do it in small steps, it probably won't be a problem. Remove
the "offset" parameter in one patch, do the "only copy to kernel
space" in another, and hey, if it ends up breaking subtly on something
we don't have any testers for, well, they can report that a year from
now and it will get fixed up, but nobody will seriously care.

IOW, "go wild".

But at the same time, I wouldn't worry _too_ much about things like
the performance of copying one register at a time. The reason we do
that regset thing is not because it's truly high-performance, it's
just that it sucked dead baby donkeys through a straw to do a full
"ptrace(PEEKUSR)" for each register.

So "high performance" is relative. Doing the STAC/CLAC dance for each
register on x86 is a complete non-issue. It's not that
performance-critical.

So yes, "go wild", but do it for the right reasons: simplifying the interface.

Because if you only worry about current use of
"__get_user()/__put_user()" optimizations, don't. Just convert to
"get_user()/put_user()" and be done with it, it's not important. This
is another area where people used the double-underscore version not
because it mattered, but because it was available.

It's like Sir Edmund Hillary, except instead of climbing Mount
Everest, people write bad code using the wrong interfaces: "because
they're there".

               Linus
