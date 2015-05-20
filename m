From: David Howells <dhowells@redhat.com>
Subject: Re: Compilers and RCU readers: Once more unto the breach!
Date: Wed, 20 May 2015 14:18:37 +0100
Message-ID: <31547.1432127917@warthog.procyon.org.uk>
References: <20150520121522.GH6776@linux.vnet.ibm.com> <20150520005510.GA23559@linux.vnet.ibm.com> <CA+55aFy_8V-rbE9FQMHx6tXjj8HHKZuKSJvnRPVYvpk46EQA1g@mail.gmail.com> <CA+55aFxOtcB8AYCpLQBGSXK=8_Vh4uDs5HEpzGpPy+hgz542ag@mail.gmail.com> <20150520024148.GD6776@linux.vnet.ibm.com> <20150520114745.GC11498@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20150520121522.GH6776@linux.vnet.ibm.com>
Content-ID: <31546.1432127917.1@warthog.procyon.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
To: paulmck@linux.vnet.ibm.com
Cc: dhowells@redhat.com, Will Deacon <will.deacon@arm.com>, Linus Torvalds <torvalds@linux-foundation.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, "c++std-parallel@accu.org" <c++std-parallel@accu.org>, "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>, "gcc@gcc.gnu.org" <gcc@gcc.gnu.org>, p796231 <Peter.Sewell@cl.cam.ac.uk>, "mark.batty@cl.cam.ac.uk" <Mark.Batty@cl.cam.ac.uk>, Peter Zijlstra <peterz@infradead.org>, Ramana Radhakrishnan <Ramana.Radhakrishnan@arm.com>, Andrew Morton <akpm@linux-foundation.org>, Ingo Molnar <mingo@kernel.org>, "michaelw@ca.ibm.com" <michaelw@ca.ibm.com>
List-Id: linux-arch.vger.kernel.org

Paul E. McKenney <paulmck@linux.vnet.ibm.com> wrote:

> > Additionally, what about the following code?
> > 
> >   char *x = y ? z : z;
> > 
> > Does that extend a dependency chain from z to x? If so, I can imagine a
> > CPU breaking that in practice.
> 
> I am not seeing this.  I would expect the compiler to optimize to
> something like this:
> 
> 	char *x = z;

Why?  What if y has a potential side-effect (say it makes a function call)?

David
