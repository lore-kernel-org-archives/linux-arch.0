Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail-oi0-f47.google.com ([209.85.218.47]:35913 "EHLO
	mail-oi0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751346AbcB2VMr (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Mon, 29 Feb 2016 16:12:47 -0500
Received: by mail-oi0-f47.google.com with SMTP id k67so57598645oia.3
        for <linux-arch@vger.kernel.org>; Mon, 29 Feb 2016 13:12:42 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <CAA+UVZT9vK8CZdRr8P9=cDT6OhCz=zieHY81txnNdAAF4v_sPA@mail.gmail.com>
References: <20160218011033.GA1505@linux.vnet.ibm.com>
	<20160220021516.4898897.32908.5212@gmail.com>
	<20160220195318.GF3522@linux.vnet.ibm.com>
	<CAPUmR1bw=N4NkjAK1zn_X0+84KEaEAM6HZCHZJy_txqC9hMgSg@mail.gmail.com>
	<20160227170615.GU3522@linux.vnet.ibm.com>
	<CA+55aFyHmykKc=YybJMo9ZUO352MY5noJVB4-K1Lkjmw4UHXfA@mail.gmail.com>
	<20160227231033.GW3522@linux.vnet.ibm.com>
	<20160228082702.GA300@x4>
	<CA+55aFyauwKmUdxfrKcy5Q2kvdej5fWt6xL+amVyPFhzmHMcsg@mail.gmail.com>
	<CAA+UVZT9vK8CZdRr8P9=cDT6OhCz=zieHY81txnNdAAF4v_sPA@mail.gmail.com>
Date: Mon, 29 Feb 2016 16:12:41 -0500
Message-ID: <CAA2zVHrqioevDtXZjcxXWCVxyr9sjrATVsV6a6Ne0nX1krykVw@mail.gmail.com>
Subject: Re: [llvm-dev] [isocpp-parallel] Proposal for new memory_order_consume
 definition
From: James Y Knight <jyknight@google.com>
Content-Type: text/plain; charset=UTF-8
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Lawrence Crowl <Lawrence@crowl.org>
Cc: parallel@lists.isocpp.org, "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>, "gcc@gcc.gnu.org" <gcc@gcc.gnu.org>, llvm-dev <llvm-dev@lists.llvm.org>, Will Deacon <will.deacon@arm.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, David Howells <dhowells@redhat.com>, Peter Zijlstra <peterz@infradead.org>, Ramana Radhakrishnan <Ramana.Radhakrishnan@arm.com>, Luc Maranget <luc.maranget@inria.fr>, Andrew Morton <akpm@linux-foundation.org>, Jade Alglave <j.alglave@ucl.ac.uk>, Ingo Molnar <mingo@kernel.org>, Markus Trippelsdorf <markus@trippelsdorf.de>
Message-ID: <20160229211241.SMJvE9oYu9cGMgZb2pVW9IXUEmHxXu-aFfsY5-wrokc@z>

No, you really don't need undefined behavior in the standard in order
to enable bug-finding.

The standard could've (and still could...) make signed integer
overflow "implementation-defined" rather than "undefined". Compilers
would thus be required to have *some documented meaning* for it (e.g.
wrap 2's-complement, wrap 1's-complement, saturate to min/max, trap,
or whatever...), but must not have the current "Anything goes! I can
set your cat on fire if the optimizer feels like it today!" behavior.

Such a change to the standard would not reduce any ability to do error
checking, as compilers that want to be helpful could perfectly-well
define it to trap at runtime when given certain compiler flags, and
perfectly well warn you of your dependence upon unportable
implementation-defined behavior (or, that your program is going to
trap), at build-time.

[Sending again as a plain-text email, since a bunch of mailing lists
apparently hate on multipart messages that even contain a text/html
part...]

On Mon, Feb 29, 2016 at 2:38 PM, Lawrence Crowl via llvm-dev
<llvm-dev@lists.llvm.org> wrote:
> On 2/28/16, Linus Torvalds <torvalds@linux-foundation.org> wrote:
>> The fact is, undefined compiler behavior is never a good idea. Not for
>> serious projects.
>
> Actually, undefined behavior is essential for serious projects, but
> not for the reasons mentioned.
>
> If the language has no undefined behavior, then from the compiler's view,
> there is no such thing as a bad program.  All programs will compile and
> enter functional debug (possibly after shipping to customer).  On the
> other hand, a language with undefined behavior makes it possible for
> compilers (and their run-time support) to identify a program as wrong.
>
> The problem with the latest spate of compiler optimizations was not the
> optimization, but the lack of warnings about exploiting undefined behavior.
>
> --
> Lawrence Crowl
> _______________________________________________
> LLVM Developers mailing list
> llvm-dev@lists.llvm.org
> http://lists.llvm.org/cgi-bin/mailman/listinfo/llvm-dev
