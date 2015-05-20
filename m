From: David Howells <dhowells@redhat.com>
Subject: Re: Compilers and RCU readers: Once more unto the breach!
Date: Wed, 20 May 2015 14:37:05 +0100
Message-ID: <31805.1432129025@warthog.procyon.org.uk>
References: <20150520133037.GK6776@linux.vnet.ibm.com> <20150520121522.GH6776@linux.vnet.ibm.com> <20150520005510.GA23559@linux.vnet.ibm.com> <CA+55aFy_8V-rbE9FQMHx6tXjj8HHKZuKSJvnRPVYvpk46EQA1g@mail.gmail.com> <CA+55aFxOtcB8AYCpLQBGSXK=8_Vh4uDs5HEpzGpPy+hgz542ag@mail.gmail.com> <20150520024148.GD6776@linux.vnet.ibm.com> <20150520114745.GC11498@arm.com> <31547.1432127917@warthog.procyon.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:34950 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751504AbbETNir (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Wed, 20 May 2015 09:38:47 -0400
In-Reply-To: <20150520133037.GK6776@linux.vnet.ibm.com>
Content-ID: <31804.1432129025.1@warthog.procyon.org.uk>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: paulmck@linux.vnet.ibm.com
Cc: dhowells@redhat.com, Will Deacon <will.deacon@arm.com>, Linus Torvalds <torvalds@linux-foundation.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, "c++std-parallel@accu.org" <c++std-parallel@accu.org>, "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>, "gcc@gcc.gnu.org" <gcc@gcc.gnu.org>, p796231 <Peter.Sewell@cl.cam.ac.uk>, "mark.batty@cl.cam.ac.uk" <Mark.Batty@cl.cam.ac.uk>, Peter Zijlstra <peterz@infradead.org>, Ramana Radhakrishnan <Ramana.Radhakrishnan@arm.com>, Andrew Morton <akpm@linux-foundation.org>, Ingo Molnar <mingo@kernel.org>, "michaelw@ca.ibm.com" <michaelw@ca.ibm.com>

Paul E. McKenney <paulmck@linux.vnet.ibm.com> wrote:

> I was thinking of "y" as a simple variable, but if it is something more
> complex, then the compiler could do this, right?
> 
> 	char *x;
> 
> 	y;
> 	x = z;

Yeah.  I presume it has to maintain the ordering, though.

David
