From: Al Viro <viro@ZenIV.linux.org.uk>
Subject: Re: [PATCH] ARM: prevent multiple syscall restarts
Date: Fri, 17 Sep 2010 16:44:25 +0100
Message-ID: <20100917154425.GY31363@ZenIV.linux.org.uk>
References: <20100917152158.GA20369@flint.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from zeniv.linux.org.uk ([195.92.253.2]:38869 "EHLO
	ZenIV.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754414Ab0IQPo0 (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Fri, 17 Sep 2010 11:44:26 -0400
Received: from viro by ZenIV.linux.org.uk with local (Exim 4.69 #1 (Red Hat Linux))
	id 1Owd6v-0006uw-ME
	for linux-arch@vger.kernel.org; Fri, 17 Sep 2010 15:44:25 +0000
Content-Disposition: inline
In-Reply-To: <20100917152158.GA20369@flint.arm.linux.org.uk>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: linux-arch@vger.kernel.org

On Fri, Sep 17, 2010 at 04:21:58PM +0100, Russell King wrote:
> Al Viro reports that calling "sys_sigsuspend(-ERESTARTNOHAND, 0, 0)"
> with two signals coming and being handled in kernel space results
> in the syscall restart being done twice.
> 
> Avoid this by clearing the 'why' flag when we call the signal handling
> code to prevent further syscall restarts after the first.

I'd like to add that while sigsuspend example is, certainly, cheating
(the first two arguments of sigsuspend(2) on arm are ignored for
historical reasons, and libc is not going to end up with that in
the first argument), the issue is real - existing code on arm relied
on the following assertion:

	no syscall called with -ERESTART... in the first argument will
ever return -ERESTART...

It happens to be true for most of the syscalls, since that value will lead
to -EBADF if the argument is a file descriptor and -EFAULT if it's a userland
pointer.  Ones that expect a syscall-specific enum will probably also just
fail with -EINVAL.  So most of the potential victims are actually OK.  However,
it's certainly better to have a straightforward prevention of that kind of
crap than keep relying on fairly subtle properties of code in core kernel
that has no idea about arch/arm relying on it - in undocumented way, at that.
