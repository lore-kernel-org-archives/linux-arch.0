From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: 64-syscall args on 32-bit vs syscall()
Date: Mon, 15 Mar 2010 16:18:33 +1100
Message-ID: <1268630313.2335.2.camel@pasglop>
References: <1268628493.2355.2.camel@pasglop>
	 <20100314.220646.190065794.davem@davemloft.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from gate.crashing.org ([63.228.1.57]:46719 "EHLO gate.crashing.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932186Ab0COFS7 (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Mon, 15 Mar 2010 01:18:59 -0400
In-Reply-To: <20100314.220646.190065794.davem@davemloft.net>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: David Miller <davem@davemloft.net>
Cc: linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org, kernel@teksavvy.com, drepper@redhat.com, torvalds@linux-foundation.org, munroesj@linux.vnet.ibm.com

On Sun, 2010-03-14 at 22:06 -0700, David Miller wrote:
> From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
> Date: Mon, 15 Mar 2010 15:48:13 +1100
> 
> > As it is, any 32-bit app using syscall() on any of the syscalls that
> > takes 64-bit arguments will be broken, unless the app itself breaks up
> > the argument, but the the order of the hi and lo part is different
> > between BE and LE architectures ;-)
> 
> I think it is even different on the same endian architectures,
> f.e. mips I think.
> 
> There is no way to do this without some arch specific code
> to handle things properly, really.

Right, but to what extent ? IE. do we always need the callers using
syscall() directly to know it all, or can we to some extent handle some
of it inside glibc ?

For example, if powerpc glibc is fixed so that syscall() takes a 64-bit
first argument (or calls via some macro to add a dummy 32-bit argument),
the register alignment will be preserved, and things will work just
fine.

IE. It may not fix all problems with all archs, but in this case, it
will fix the common cases for powerpc at least :-) And any other arch
that has the exact same alignment problem.

Or is there any good reason -not- to do that in glibc ?

Cheers,
Ben.
