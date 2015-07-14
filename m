From: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
Subject: Re: Compilers and RCU readers: Once more unto the breach!
Date: Mon, 13 Jul 2015 17:44:59 -0700
Message-ID: <20150714004459.GA3090@linux.vnet.ibm.com>
References: <20150520005510.GA23559@linux.vnet.ibm.com>
Reply-To: paulmck@linux.vnet.ibm.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20150520005510.GA23559@linux.vnet.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org, c++std-parallel@accu.org, linux-arch@vger.kernel.org, gcc@gcc.gnu.org
Cc: Peter.Sewell@cl.cam.ac.uk, torvalds@linux-foundation.org, Mark.Batty@cl.cam.ac.uk, peterz@infradead.org, will.deacon@arm.com, Ramana.Radhakrishnan@arm.com, dhowells@redhat.com, akpm@linux-foundation.org, mingo@kernel.org, michaelw@ca.ibm.com
List-Id: linux-arch.vger.kernel.org

On Tue, May 19, 2015 at 05:55:10PM -0700, Paul E. McKenney wrote:
> Hello!
> 
> Following up on last year's discussion (https://lwn.net/Articles/586838/,
> https://lwn.net/Articles/588300/), I believe that we have a solution.  If
> I am wrong, I am sure you all will let me know, and in great detail.  ;-)
> 
> The key simplification is to "just say no" to RCU-protected array indexes:
> https://lkml.org/lkml/2015/5/12/827, as was suggested by several people.
> This simplification means that rcu_dereference (AKA memory_order_consume)
> need only return pointers.  This in ture avoids things like (x-x),
> (x*0), and (x%1) because if "x" is a pointer, these expressions either
> return non-pointers are compilation errors.  With a very few exceptions,
> dependency chains can lead -to- non-pointers, but cannot pass -through-
> them.
> 
> The result is that dependencies are carried only by operations for
> which the compiler cannot easily optimize the away those dependencies,
> these operations including simple assignment, integer offset (including
> indexing), dereferencing, casts, passing as a function argument, return
> values from functions and so on.  A complete list with commentary starts
> on page 28 of:
> 
> 	http://www.rdrop.com/users/paulmck/RCU/consume.2015.05.18a.pdf

And an update is available here:

	http://www.rdrop.com/users/paulmck/RCU/consume.2015.07.13a.pdf

Among other things, this update addresses the points about equality
comparisons introduced by the compiler, and outlines some of the
issues head-/tail-marked alternatives face with respect to abstraction.
The updated "Restricted Dependency Chains" section starts on page 28.

Thoughts?

							Thanx, Paul
