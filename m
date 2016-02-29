From: Lawrence Crowl <Lawrence@Crowl.org>
Subject: Re: [isocpp-parallel] Proposal for new memory_order_consume definition
Date: Mon, 29 Feb 2016 11:38:33 -0800
Message-ID: <CAA+UVZT9vK8CZdRr8P9=cDT6OhCz=zieHY81txnNdAAF4v_sPA@mail.gmail.com>
References: <20160218011033.GA1505@linux.vnet.ibm.com>
	<20160220021516.4898897.32908.5212@gmail.com>
	<20160220195318.GF3522@linux.vnet.ibm.com>
	<CAPUmR1bw=N4NkjAK1zn_X0+84KEaEAM6HZCHZJy_txqC9hMgSg@mail.gmail.com>
	<20160227170615.GU3522@linux.vnet.ibm.com>
	<CA+55aFyHmykKc=YybJMo9ZUO352MY5noJVB4-K1Lkjmw4UHXfA@mail.gmail.com>
	<20160227231033.GW3522@linux.vnet.ibm.com>
	<20160228082702.GA300@x4>
	<CA+55aFyauwKmUdxfrKcy5Q2kvdej5fWt6xL+amVyPFhzmHMcsg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mail-yk0-f180.google.com ([209.85.160.180]:32872 "EHLO
	mail-yk0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753109AbcB2Tie (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Mon, 29 Feb 2016 14:38:34 -0500
In-Reply-To: <CA+55aFyauwKmUdxfrKcy5Q2kvdej5fWt6xL+amVyPFhzmHMcsg@mail.gmail.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: parallel@lists.isocpp.org
Cc: Markus Trippelsdorf <markus@trippelsdorf.de>, "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>, "gcc@gcc.gnu.org" <gcc@gcc.gnu.org>, Jade Alglave <j.alglave@ucl.ac.uk>, llvm-dev@lists.llvm.org, Will Deacon <will.deacon@arm.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, David Howells <dhowells@redhat.com>, Peter Zijlstra <peterz@infradead.org>, Ramana Radhakrishnan <Ramana.Radhakrishnan@arm.com>, Luc Maranget <luc.maranget@inria.fr>, Andrew Morton <akpm@linux-foundation.org>, Ingo Molnar <mingo@kernel.org>

On 2/28/16, Linus Torvalds <torvalds@linux-foundation.org> wrote:
> The fact is, undefined compiler behavior is never a good idea. Not for
> serious projects.

Actually, undefined behavior is essential for serious projects, but
not for the reasons mentioned.

If the language has no undefined behavior, then from the compiler's view,
there is no such thing as a bad program.  All programs will compile and
enter functional debug (possibly after shipping to customer).  On the
other hand, a language with undefined behavior makes it possible for
compilers (and their run-time support) to identify a program as wrong.

The problem with the latest spate of compiler optimizations was not the
optimization, but the lack of warnings about exploiting undefined behavior.

-- 
Lawrence Crowl
