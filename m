From: Andrew Haley <aph@redhat.com>
Subject: Re: Compilers and RCU readers: Once more unto the breach!
Date: Wed, 20 May 2015 16:54:51 +0100
Message-ID: <555CAE4B.4050202@redhat.com>
References: <20150520005510.GA23559@linux.vnet.ibm.com> <CA+55aFy_8V-rbE9FQMHx6tXjj8HHKZuKSJvnRPVYvpk46EQA1g@mail.gmail.com> <CA+55aFxOtcB8AYCpLQBGSXK=8_Vh4uDs5HEpzGpPy+hgz542ag@mail.gmail.com> <20150520024148.GD6776@linux.vnet.ibm.com> <20150520114745.GC11498@arm.com> <20150520121522.GH6776@linux.vnet.ibm.com> <20150520154617.GE11498@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:11188 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754070AbbETPzv (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Wed, 20 May 2015 11:55:51 -0400
In-Reply-To: <20150520154617.GE11498@arm.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Will Deacon <will.deacon@arm.com>, "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, "c++std-parallel@accu.org" <c++std-parallel@accu.org>, "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>, "gcc@gcc.gnu.org" <gcc@gcc.gnu.org>, p796231 <Peter.Sewell@cl.cam.ac.uk>, "mark.batty@cl.cam.ac.uk" <Mark.Batty@cl.cam.ac.uk>, Peter Zijlstra <peterz@infradead.org>, Ramana Radhakrishnan <Ramana.Radhakrishnan@arm.com>, David Howells <dhowells@redhat.com>, Andrew Morton <akpm@linux-foundation.org>, Ingo Molnar <mingo@kernel.org>, "michaelw@ca.ibm.com" <michaelw@ca.ibm.com>

On 05/20/2015 04:46 PM, Will Deacon wrote:
> I'm not sure... you'd require the compiler to perform static analysis of
> loops to determine the state of the machine when they exit (if they exit!)
> in order to show whether or not a dependency is carried to subsequent
> operations. If it can't prove otherwise, it would have to assume that a
> dependency *is* carried, and it's not clear to me how it would use this
> information to restrict any subsequent dependency removing optimisations.

It'd just convert consume to acquire.

Andrew.
