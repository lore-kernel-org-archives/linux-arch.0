From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: 64-syscall args on 32-bit vs syscall()
Date: Tue, 16 Mar 2010 07:33:24 +1100
Message-ID: <1268685204.2335.36.camel@pasglop>
References: <1268628493.2355.2.camel@pasglop>
	 <20100315150401.GF15133@shareable.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from gate.crashing.org ([63.228.1.57]:39934 "EHLO gate.crashing.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752268Ab0COUeU (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Mon, 15 Mar 2010 16:34:20 -0400
In-Reply-To: <20100315150401.GF15133@shareable.org>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Jamie Lokier <jamie@shareable.org>
Cc: linux-arch@vger.kernel.org, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Mark Lord <kernel@teksavvy.com>, Ulrich Drepper <drepper@redhat.com>, Linus Torvalds <torvalds@linux-foundation.org>, Steven Munroe <munroesj@linux.vnet.ibm.com>

On Mon, 2010-03-15 at 15:04 +0000, Jamie Lokier wrote:
> There are several problems with syscall(), not just this - because a
> number of system calls in section 2 of the manual don't map directly
> to kernel syscalls with the same function prototype.
> 
> Even fork() has become something complicated in Glibc that doesn't use
> the fork syscall :-(
> 
> So anything using syscall() has to be careful on Linux already.
> Changing the 64-bit alignment won't fix the other differences. 

It won't fix -all- the problems with syscall(), but it will fix a wagon
of them without breaking existing code that already does the arch
specific breakup on the call site...

Cheers,
Ben.
