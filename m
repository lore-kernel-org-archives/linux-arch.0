Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail-pa0-f42.google.com ([209.85.220.42]:33426 "EHLO
	mail-pa0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758344AbcB1QvI convert rfc822-to-8bit (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Sun, 28 Feb 2016 11:51:08 -0500
Received: by mail-pa0-f42.google.com with SMTP id fl4so78117298pad.0
        for <linux-arch@vger.kernel.org>; Sun, 28 Feb 2016 08:51:08 -0800 (PST)
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
Message-ID: <20160228165008.5468244.19084.78457@pathscale.com>
Date: Sun, 28 Feb 2016 23:50:08 +0700
Subject: Re: [llvm-dev] [isocpp-parallel] Proposal for new memory_order_consume definition
From: cbergstrom@pathscale.com
In-Reply-To: <CA+55aFyauwKmUdxfrKcy5Q2kvdej5fWt6xL+amVyPFhzmHMcsg@mail.gmail.com>
References: <20160218011033.GA1505@linux.vnet.ibm.com>
 <20160220021516.4898897.32908.5212@gmail.com>
 <20160220195318.GF3522@linux.vnet.ibm.com>
 <CAPUmR1bw=N4NkjAK1zn_X0+84KEaEAM6HZCHZJy_txqC9hMgSg@mail.gmail.com>
 <20160227170615.GU3522@linux.vnet.ibm.com>
 <CA+55aFyHmykKc=YybJMo9ZUO352MY5noJVB4-K1Lkjmw4UHXfA@mail.gmail.com>
 <20160227231033.GW3522@linux.vnet.ibm.com>
 <20160228082702.GA300@x4>
 <CA+55aFyauwKmUdxfrKcy5Q2kvdej5fWt6xL+amVyPFhzmHMcsg@mail.gmail.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Linus Torvalds via llvm-dev <torvalds@linux-foundation.org>, Markus Trippelsdorf <markus@trippelsdorf.de>
Cc: linux-arch@vger.kernel.org, gcc@gcc.gnu.org, Jade Alglave <j.alglave@ucl.ac.uk>, parallel@lists.isocpp.org, llvm-dev@lists.llvm.org, Will Deacon <will.deacon@arm.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, David Howells <dhowells@redhat.com>, Peter Zijlstra <peterz@infradead.org>, Ramana Radhakrishnan <Ramana.Radhakrishnan@arm.com>, Luc Maranget <luc.maranget@inria.fr>, Andrew Morton <akpm@linux-foundation.org>, Paul McKenney <paulmck@linux.vnet.ibm.com>, Ingo Molnar <mingo@kernel.org>
Message-ID: <20160228165008.RyE2XcGP16ftYBPInYYWZ0MpcJlw12ZVnzw1gkPSgog@z>

Sometimes Linus says some really flippant and funny things but gosh I couldn't agree more.. with one tiny nit..

Properly written Fortran and a good compiler is potentially as fast or faster than typical C version in HPC codes. (yes you may be able to get the c version faster, but it would take some effort.)

  Original Message  
From: Linus Torvalds via llvm-dev
Sent: Sunday, February 28, 2016 23:13
To: Markus Trippelsdorf
Reply To: Linus Torvalds
Cc: linux-arch@vger.kernel.org; gcc@gcc.gnu.org; Jade Alglave; parallel@lists.isocpp.org; llvm-dev@lists.llvm.org; Will Deacon; Linux Kernel Mailing List; David Howells; Peter Zijlstra; Ramana Radhakrishnan; Luc Maranget; Andrew Morton; Paul McKenney; Ingo Molnar
Subject: Re: [llvm-dev] [isocpp-parallel] Proposal for new memory_order_consume definition

On Sun, Feb 28, 2016 at 12:27 AM, Markus Trippelsdorf
<markus@trippelsdorf.de> wrote:
>> >
>> > -fno-strict-overflow
>>
>> -fno-strict-aliasing.
>
> Do not forget -fno-delete-null-pointer-checks.
>
> So the kernel obviously is already using its own C dialect, that is
> pretty far from standard C.
> All these options also have a negative impact on the performance of the
> generated code.

They really don't.

Have you ever seen code that cared about signed integer overflow?
Yeah, getting it right can make the compiler generate an extra ALU
instruction once in a blue moon, but trust me - you'll never notice.
You *will* notice when you suddenly have a crash or a security issue
due to bad code generation, though.

The idiotic C alias rules aren't even worth discussing. They were a
mistake. The kernel doesn't use some "C dialect pretty far from
standard C". Yeah, let's just say that the original C designers were
better at their job than a gaggle of standards people who were making
bad crap up to make some Fortran-style programs go faster.

They don't speed up normal code either, they just introduce undefined
behavior in a lot of code.

And deleting NULL pointer checks because somebody made a mistake, and
then turning that small mistake into a real and exploitable security
hole? Not so smart either.

The fact is, undefined compiler behavior is never a good idea. Not for
serious projects.

Performance doesn't come from occasional small and odd
micro-optimizations. I care about performance a lot, and I actually
look at generated code and do profiling etc. None of those three
options have *ever* shown up as issues. But the incorrect code they
generate? It has.

Linus
_______________________________________________
LLVM Developers mailing list
llvm-dev@lists.llvm.org
http://lists.llvm.org/cgi-bin/mailman/listinfo/llvm-dev
