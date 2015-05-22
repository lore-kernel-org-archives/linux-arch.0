From: Ingo Molnar <mingo@kernel.org>
Subject: Re: Compilers and RCU readers: Once more unto the breach!
Date: Fri, 22 May 2015 08:43:44 +0200
Message-ID: <20150522064344.GA17518@gmail.com>
References: <CA+55aFy_8V-rbE9FQMHx6tXjj8HHKZuKSJvnRPVYvpk46EQA1g@mail.gmail.com>
 <CA+55aFxOtcB8AYCpLQBGSXK=8_Vh4uDs5HEpzGpPy+hgz542ag@mail.gmail.com>
 <20150520024148.GD6776@linux.vnet.ibm.com>
 <20150520114745.GC11498@arm.com>
 <20150520121522.GH6776@linux.vnet.ibm.com>
 <20150520154617.GE11498@arm.com>
 <20150520181606.GT6776@linux.vnet.ibm.com>
 <20150521192422.GC19204@arm.com>
 <20150521200212.GW6776@linux.vnet.ibm.com>
 <CA+55aFxse3wTkfLMdotb+FO+_6EN32sseC0gpBaSnJ2KmbNUhQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mail-wg0-f49.google.com ([74.125.82.49]:32909 "EHLO
	mail-wg0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750715AbbEVGnt (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Fri, 22 May 2015 02:43:49 -0400
Content-Disposition: inline
In-Reply-To: <CA+55aFxse3wTkfLMdotb+FO+_6EN32sseC0gpBaSnJ2KmbNUhQ@mail.gmail.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Paul McKenney <paulmck@linux.vnet.ibm.com>, Will Deacon <will.deacon@arm.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, "c++std-parallel@accu.org" <c++std-parallel@accu.org>, "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>, "gcc@gcc.gnu.org" <gcc@gcc.gnu.org>, p796231 <Peter.Sewell@cl.cam.ac.uk>, "mark.batty@cl.cam.ac.uk" <Mark.Batty@cl.cam.ac.uk>, Peter Zijlstra <peterz@infradead.org>, Ramana Radhakrishnan <Ramana.Radhakrishnan@arm.com>, David Howells <dhowells@redhat.com>, Andrew Morton <akpm@linux-foundation.org>, "michaelw@ca.ibm.com" <michaelw@ca.ibm.com>


* Linus Torvalds <torvalds@linux-foundation.org> wrote:

>  (a) the "official" rules are completely pointless, and make sense 
> only because the standard is written for some random "abstract 
> machine" that doesn't actually exist.

Presuming the intent of the abstract machine specification is to avoid 
being seen as biased towards any specific machine (politics), maybe 
write this as:

   (a) the "official" rules are written for a somewhat weird and 
       complex "union of all known and theoretically possible CPU 
       architectures that exist or which might exist in the future", 
       which machine does not actually exist in practice, but which 
       allows a single abstract set of rules to apply to all machines. 
       These rules are complex, but if applied to a specific machine 
       they become considerably simpler. Here's a few examples: ...

?

(Assuming it's a goal of this standard to be human parseable to more 
than a few dozen people on the planet.)

Thanks,

	Ingo
