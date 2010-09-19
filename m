From: Greg McGary <greg@mcgary.org>
Subject: Re: Proposal: (u)intptr_t replaces (unsigned) long as opaque type
Date: Sun, 19 Sep 2010 09:53:40 -0700
Message-ID: <4C964014.4090005@mcgary.org>
References: <4C95324B.2030707@mcgary.org> <20100918235436.GD25139@parisc-linux.org> <4C9578DE.4090602@mcgary.org> <20100919040635.GE25139@parisc-linux.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mpls-qmqp-02.inet.qwest.net ([63.231.195.113]:52804 "EHLO
	mpls-qmqp-02.inet.qwest.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753358Ab0ISQxt (ORCPT
	<rfc822;linux-arch@vger.kernel.org>);
	Sun, 19 Sep 2010 12:53:49 -0400
In-Reply-To: <20100919040635.GE25139@parisc-linux.org>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Matthew Wilcox <matthew@wil.cx>
Cc: linux-arch@vger.kernel.org

 On 09/18/10 21:06, Matthew Wilcox wrote:

> But it's only the beginnings of your problems.  There's so much userspace
> code that's written assuming ILP32 / LP64.  Even inside the kernel,
> people are going to constantly break your port by introducing new code
> that doesn't use uintptr_t.

Actually, the kernel is my final problem.  The userspace problem turned-out to
be quite manageable.  Within a year, working mostly alone, I have complete binutils,
GCC, uClibc, busybox and QEMU (Linux userland mode) ports running and I didn't even
come close to pulling-out my hair.  I have two-thirds of the SPEC2000 benchmarks
running correctly on QEMU, and I expect the remaining third to yield when I have
some time to debug them.  QEMU required the most surgery, and of the same kind as
Linux needs: s/target_long/target_intptr_t/ for vars that hold addresses.  uClibc
was also fast & loose in a few places regarding pointer/integer casts, but for the
most part, non-kernel code uses void* as the opaque type and char* or void* for
doing address arithmetic.  The kernel is the sloppiest of all regarding
pointer/integer casts.


I'm unconcerned about future breakage.  Over time, people will catch-on to the new
convention and breakage will diminish.  I'm much happier about fixing new problems
as they arise than about maintaining a port that is perpetually far from the mainline.


> Then there are other things we use unsigned long for, like interrupt
> status flags (spin_lock_irqsave and friends).  Should those be converted
> to some new type?

The only types that should be converted are for (a) opaque data that might hold
either a long or a pointer (e.g., ioctl arg, fcnt arg, generic callback function
args) and (b) data on which Linux does address arithmetic.  If an interrupt status
flag is not intended to hold an address, then there's no reason to change it.


> Essentially, you're asking us to take on a huge number of changes in
> order to make your new processor's performance not suck.  I don't think
> it likely you're going to find much sympathy here.

I propose this because (a) there is no impact on generated code for other ports,
and (b) it benefits code quality, flexibility, portability and self-documentation.
If the kernel is so ossified that avoiding changes has become the cardinal virtue,
then I guess I'm hosed.  8^)  As stated before, I'm prepared to submit changes
slowly over time in order to moderate the impact.

G
