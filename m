Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from moene.org ([80.101.130.238]:37220 "EHLO moene.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752320AbcB2Va0 (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Mon, 29 Feb 2016 16:30:26 -0500
Subject: Re: [isocpp-parallel] Proposal for new memory_order_consume
 definition
References: <20160218011033.GA1505@linux.vnet.ibm.com>
 <20160220021516.4898897.32908.5212@gmail.com>
 <20160220195318.GF3522@linux.vnet.ibm.com>
 <CAPUmR1bw=N4NkjAK1zn_X0+84KEaEAM6HZCHZJy_txqC9hMgSg@mail.gmail.com>
 <20160227170615.GU3522@linux.vnet.ibm.com>
 <CA+55aFyHmykKc=YybJMo9ZUO352MY5noJVB4-K1Lkjmw4UHXfA@mail.gmail.com>
 <20160227231033.GW3522@linux.vnet.ibm.com> <20160228082702.GA300@x4>
 <CA+55aFyauwKmUdxfrKcy5Q2kvdej5fWt6xL+amVyPFhzmHMcsg@mail.gmail.com>
From: Toon Moene <toon@moene.org>
Message-ID: <56D4ADE8.7090403@moene.org>
Date: Mon, 29 Feb 2016 21:45:28 +0100
MIME-Version: 1.0
In-Reply-To: <CA+55aFyauwKmUdxfrKcy5Q2kvdej5fWt6xL+amVyPFhzmHMcsg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>, Markus Trippelsdorf <markus@trippelsdorf.de>
Cc: Paul McKenney <paulmck@linux.vnet.ibm.com>, "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>, "gcc@gcc.gnu.org" <gcc@gcc.gnu.org>, parallel@lists.isocpp.org, llvm-dev@lists.llvm.org, Will Deacon <will.deacon@arm.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, David Howells <dhowells@redhat.com>, Peter Zijlstra <peterz@infradead.org>, Ramana Radhakrishnan <Ramana.Radhakrishnan@arm.com>, Luc Maranget <luc.maranget@inria.fr>, Andrew Morton <akpm@linux-foundation.org>, Jade Alglave <j.alglave@ucl.ac.uk>, Ingo Molnar <mingo@kernel.org>
Message-ID: <20160229204528.89t95kCzs-XPCAiqPIzF9_3YKUdVWDA6Bjow9VbweQA@z>

On 02/28/2016 05:13 PM, Linus Torvalds wrote:

> Yeah, let's just say that the original C designers were
> better at their job than a gaggle of standards people who were making
> bad crap up to make some Fortran-style programs go faster.

The original C designers were defining a language that would make it 
easy to write operating systems in (and not having to rely on assembler).

I misled the quote where they said they first tried Fortran (and 
concluded it didn't fit their purpose).

BTW, Fortran was designed around floating point arithmetic (and its 
non-relation to the mathematical concept of the field of the reals).

It used integers only for counting and indexing arrays, so it had no 
purpose for "signed integers that overflowed". Therefore, to the Fortran 
standard, this was "undefined". It was literally "undefined" - as it was 
not described by the standard's text.

-- 
Toon Moene - e-mail: toon@moene.org - phone: +31 346 214290
Saturnushof 14, 3738 XG  Maartensdijk, The Netherlands
At home: http://moene.org/~toon/; weather: http://moene.org/~hirlam/
Progress of GNU Fortran: http://gcc.gnu.org/wiki/GFortran#news
