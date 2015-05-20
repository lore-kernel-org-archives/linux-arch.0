From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: Compilers and RCU readers: Once more unto the breach!
Date: Tue, 19 May 2015 19:10:12 -0700
Message-ID: <CA+55aFxOtcB8AYCpLQBGSXK=8_Vh4uDs5HEpzGpPy+hgz542ag@mail.gmail.com>
References: <20150520005510.GA23559@linux.vnet.ibm.com>
	<CA+55aFy_8V-rbE9FQMHx6tXjj8HHKZuKSJvnRPVYvpk46EQA1g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mail-ie0-f175.google.com ([209.85.223.175]:35456 "EHLO
	mail-ie0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751619AbbETCKN (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Tue, 19 May 2015 22:10:13 -0400
In-Reply-To: <CA+55aFy_8V-rbE9FQMHx6tXjj8HHKZuKSJvnRPVYvpk46EQA1g@mail.gmail.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Paul McKenney <paulmck@linux.vnet.ibm.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, c++std-parallel@accu.org, "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>, "gcc@gcc.gnu.org" <gcc@gcc.gnu.org>, p796231 <Peter.Sewell@cl.cam.ac.uk>, "mark.batty@cl.cam.ac.uk" <Mark.Batty@cl.cam.ac.uk>, Peter Zijlstra <peterz@infradead.org>, Will Deacon <will.deacon@arm.com>, Ramana Radhakrishnan <Ramana.Radhakrishnan@arm.com>, David Howells <dhowells@redhat.com>, Andrew Morton <akpm@linux-foundation.org>, Ingo Molnar <mingo@kernel.org>, michaelw@ca.ibm.com

On Tue, May 19, 2015 at 6:57 PM, Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
>  - the "you can add/subtract integral values" still opens you up to
> language lawyers claiming "(char *)ptr - (intptr_t)ptr" preserving the
> dependency, which it clearly doesn't. But language-lawyering it does,
> since all those operations (cast to pointer, cast to integer,
> subtracting an integer) claim to be dependency-preserving operations.
>
> So I think you want to limit the logical operators to things that
> don't mask off too many bits, and you should probably limit the
> add/subtract operations some way (maybe specify that the integer value
> you add/subtract cannot be related to the pointer).

Actually, "not related" doesn't work. For some buddy allocator thing,
you very much might want some of the bits to be related.

So I think you're better off just saying that operations designed to
drop significant bits break the dependency chain, and give things like
"& 1" and "(char *)ptr-(uintptr_t)ptr" as examples of such.

Making that just an extension of your existing "& 0" language would
seem to be natural.

Humans will understand, and compiler writers won't care. They will
either depend on hardware semantics anyway (and argue that your
language is tight enough that they don't need to do anything special)
or they will turn the consume into an acquire (on platforms that have
too weak hardware).

                     Linus
