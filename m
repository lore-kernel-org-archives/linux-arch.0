From: Jamie Lokier <jamie@shareable.org>
Subject: Re: 64-syscall args on 32-bit vs syscall()
Date: Mon, 15 Mar 2010 15:04:01 +0000
Message-ID: <20100315150401.GF15133@shareable.org>
References: <1268628493.2355.2.camel@pasglop>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mail2.shareable.org ([80.68.89.115]:51091 "EHLO
	mail2.shareable.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965065Ab0COPEM (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Mon, 15 Mar 2010 11:04:12 -0400
Content-Disposition: inline
In-Reply-To: <1268628493.2355.2.camel@pasglop>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: linux-arch@vger.kernel.org, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Mark Lord <kernel@teksavvy.com>, Ulrich Drepper <drepper@redhat.com>, Linus Torvalds <torvalds@linux-foundation.org>, Steven Munroe <munroesj@linux.vnet.ibm.com>

Benjamin Herrenschmidt wrote:
> err = syscall(SYS_fallocate, fd, mode, offset, len);
> 
> With "offset" being a 64-bit argument.
> 
> This will break because the first argument to syscall now shifts
> everything by one register, which breaks the register pair alignment
> (and I suppose archs with stack based calling convention can have
> similar alignment issues even if x86 doesn't).
> 
> Ulrich, Steven, shouldn't we have glibc's syscall() take a long long as
> it's first argument to correct that ? Either that or making it some kind
> of macro wrapper around a __syscall(int dummy, int sysno, ...) ?
> 
> As it is, any 32-bit app using syscall() on any of the syscalls that
> takes 64-bit arguments will be broken, unless the app itself breaks up
> the argument, but the the order of the hi and lo part is different
> between BE and LE architectures ;-)
> 
> So is there a more "correct" solution than another here ? Should powerpc
> glibc be fixed at least so that syscall() keeps the alignment ?

There are several problems with syscall(), not just this - because a
number of system calls in section 2 of the manual don't map directly
to kernel syscalls with the same function prototype.

Even fork() has become something complicated in Glibc that doesn't use
the fork syscall :-(

So anything using syscall() has to be careful on Linux already.
Changing the 64-bit alignment won't fix the other differences.

-- Jamie
