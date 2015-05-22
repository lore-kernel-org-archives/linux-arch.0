From: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
Subject: Re: Compilers and RCU readers: Once more unto the breach!
Date: Fri, 22 May 2015 06:12:52 -0700
Message-ID: <20150522131252.GG6776@linux.vnet.ibm.com>
References: <CA+55aFxOtcB8AYCpLQBGSXK=8_Vh4uDs5HEpzGpPy+hgz542ag@mail.gmail.com>
 <20150520024148.GD6776@linux.vnet.ibm.com>
 <20150520114745.GC11498@arm.com>
 <20150520121522.GH6776@linux.vnet.ibm.com>
 <20150520154617.GE11498@arm.com>
 <20150520181606.GT6776@linux.vnet.ibm.com>
 <20150521192422.GC19204@arm.com>
 <20150521200212.GW6776@linux.vnet.ibm.com>
 <CA+55aFxse3wTkfLMdotb+FO+_6EN32sseC0gpBaSnJ2KmbNUhQ@mail.gmail.com>
 <20150522064344.GA17518@gmail.com>
Reply-To: paulmck@linux.vnet.ibm.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from e33.co.us.ibm.com ([32.97.110.151]:59003 "EHLO
	e33.co.us.ibm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756856AbbEVNNA (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Fri, 22 May 2015 09:13:00 -0400
Received: from /spool/local
	by e33.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
	for <linux-arch@vger.kernel.org> from <paulmck@linux.vnet.ibm.com>;
	Fri, 22 May 2015 07:13:00 -0600
Content-Disposition: inline
In-Reply-To: <20150522064344.GA17518@gmail.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Ingo Molnar <mingo@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Will Deacon <will.deacon@arm.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, "c++std-parallel@accu.org" <c++std-parallel@accu.org>, "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>, "gcc@gcc.gnu.org" <gcc@gcc.gnu.org>, p796231 <Peter.Sewell@cl.cam.ac.uk>, "mark.batty@cl.cam.ac.uk" <Mark.Batty@cl.cam.ac.uk>, Peter Zijlstra <peterz@infradead.org>, Ramana Radhakrishnan <Ramana.Radhakrishnan@arm.com>, David Howells <dhowells@redhat.com>, Andrew Morton <akpm@linux-foundation.org>, "michaelw@ca.ibm.com" <michaelw@ca.ibm.com>

On Fri, May 22, 2015 at 08:43:44AM +0200, Ingo Molnar wrote:
> 
> * Linus Torvalds <torvalds@linux-foundation.org> wrote:
> 
> >  (a) the "official" rules are completely pointless, and make sense 
> > only because the standard is written for some random "abstract 
> > machine" that doesn't actually exist.
> 
> Presuming the intent of the abstract machine specification is to avoid 
> being seen as biased towards any specific machine (politics), maybe 
> write this as:
> 
>    (a) the "official" rules are written for a somewhat weird and 
>        complex "union of all known and theoretically possible CPU 
>        architectures that exist or which might exist in the future", 
>        which machine does not actually exist in practice, but which 
>        allows a single abstract set of rules to apply to all machines. 
>        These rules are complex, but if applied to a specific machine 
>        they become considerably simpler. Here's a few examples: ...
> 
> ?
> 
> (Assuming it's a goal of this standard to be human parseable to more 
> than a few dozen people on the planet.)

Should something based on Section 7.9 go in, then I would need to add
a more developer-friendly explanation in Documentation/RCU, no two
ways about it!  ;-)

							Thanx, Paul
