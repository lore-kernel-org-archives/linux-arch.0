From: Ramana Radhakrishnan <ramana.radhakrishnan@arm.com>
Subject: Re: Compilers and RCU readers: Once more unto the breach!
Date: Wed, 20 May 2015 14:44:30 +0100
Message-ID: <555C8FBE.4020505@arm.com>
References: <20150520133037.GK6776@linux.vnet.ibm.com> <20150520121522.GH6776@linux.vnet.ibm.com> <20150520005510.GA23559@linux.vnet.ibm.com> <CA+55aFy_8V-rbE9FQMHx6tXjj8HHKZuKSJvnRPVYvpk46EQA1g@mail.gmail.com> <CA+55aFxOtcB8AYCpLQBGSXK=8_Vh4uDs5HEpzGpPy+hgz542ag@mail.gmail.com> <20150520024148.GD6776@linux.vnet.ibm.com> <20150520114745.GC11498@arm.com> <31547.1432127917@warthog.procyon.org.uk> <31805.1432129025@warthog.procyon.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from foss.arm.com ([217.140.101.70]:38325 "EHLO foss.arm.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753082AbbETNoc (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Wed, 20 May 2015 09:44:32 -0400
In-Reply-To: <31805.1432129025@warthog.procyon.org.uk>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: David Howells <dhowells@redhat.com>, "paulmck@linux.vnet.ibm.com" <paulmck@linux.vnet.ibm.com>
Cc: Will Deacon <Will.Deacon@arm.com>, Linus Torvalds <torvalds@linux-foundation.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, "c++std-parallel@accu.org" <c++std-parallel@accu.org>, "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>, "gcc@gcc.gnu.org" <gcc@gcc.gnu.org>, p796231 <Peter.Sewell@cl.cam.ac.uk>, "mark.batty@cl.cam.ac.uk" <Mark.Batty@cl.cam.ac.uk>, Peter Zijlstra <peterz@infradead.org>, Andrew Morton <akpm@linux-foundation.org>, Ingo Molnar <mingo@kernel.org>, "michaelw@ca.ibm.com" <michaelw@ca.ibm.com>



On 20/05/15 14:37, David Howells wrote:
> Paul E. McKenney <paulmck@linux.vnet.ibm.com> wrote:
>
>> I was thinking of "y" as a simple variable, but if it is something more
>> complex, then the compiler could do this, right?
>>
>> 	char *x;
>>
>> 	y;
>> 	x = z;
>
> Yeah.  I presume it has to maintain the ordering, though.

The scheduler for e.g. is free to reorder if it can prove there is no 
dependence (or indeed side-effects for y) between insns produced for y 
and `x = z'.

regards
Ramana

>
> David
>
