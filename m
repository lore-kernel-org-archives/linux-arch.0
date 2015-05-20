From: Jens Maurer <Jens.Maurer@gmx.net>
Subject: Re: [c++std-parallel-1614] Re: Compilers and RCU readers: Once more
 unto the breach!
Date: Wed, 20 May 2015 09:34:10 +0200
Message-ID: <555C38F2.7060402@gmx.net>
References: <20150520005510.GA23559@linux.vnet.ibm.com> <CA+55aFy_8V-rbE9FQMHx6tXjj8HHKZuKSJvnRPVYvpk46EQA1g@mail.gmail.com> <20150520023402.GC6776@linux.vnet.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mout.gmx.net ([212.227.15.15]:64582 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750800AbbETHfF (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Wed, 20 May 2015 03:35:05 -0400
In-Reply-To: <20150520023402.GC6776@linux.vnet.ibm.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: c++std-parallel@accu.org
Cc: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>, Linus Torvalds <torvalds@linux-foundation.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>, "gcc@gcc.gnu.org" <gcc@gcc.gnu.org>, p796231 <Peter.Sewell@cl.cam.ac.uk>, "mark.batty@cl.cam.ac.uk" <Mark.Batty@cl.cam.ac.uk>, Peter Zijlstra <peterz@infradead.org>, Will Deacon <will.deacon@arm.com>, Ramana Radhakrishnan <Ramana.Radhakrishnan@arm.com>, David Howells <dhowells@redhat.com>, Andrew Morton <akpm@linux-foundation.org>, Ingo Molnar <mingo@kernel.org>, michaelw@ca.ibm.com

On 05/20/2015 04:34 AM, Paul E. McKenney wrote:
> On Tue, May 19, 2015 at 06:57:02PM -0700, Linus Torvalds wrote:

>>  - the "you can add/subtract integral values" still opens you up to
>> language lawyers claiming "(char *)ptr - (intptr_t)ptr" preserving the
>> dependency, which it clearly doesn't. But language-lawyering it does,
>> since all those operations (cast to pointer, cast to integer,
>> subtracting an integer) claim to be dependency-preserving operations.

[...]

> There are some stranger examples, such as "(char *)ptr - ((intptr_t)ptr)/7",
> but in that case, if the resulting pointer happens by chance to reference 
> valid memory, I believe a dependency would still be carried.
[...]

From a language lawyer standpoint, pointer arithmetic is only valid
within an array.  These examples seem to go beyond the bounds of the
array and therefore have undefined behavior.

C++ standard section 5.7 paragraph 4
"If both the pointer operand and the result point to elements of the
same array object, or one past the last element of the array object,
the evaluation shall not produce an overflow; otherwise, the behavior
is undefined."

C99 and C11
identical phrasing in 6.5.6 paragraph 8

Jens
