Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from zeniv.linux.org.uk ([195.92.253.2]:60734 "EHLO
        ZenIV.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727093AbeHKFS3 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Sat, 11 Aug 2018 01:18:29 -0400
Date: Sat, 11 Aug 2018 03:45:53 +0100
From: Al Viro <viro@ZenIV.linux.org.uk>
Subject: Re: [PATCH 3/6] alpha: Unify the not-implemented system call entry
 name
Message-ID: <20180811024553.GF6515@ZenIV.linux.org.uk>
References: <1531736638-15294-1-git-send-email-firoz.khan@linaro.org>
 <1531736638-15294-4-git-send-email-firoz.khan@linaro.org>
 <20180811000455.GC6515@ZenIV.linux.org.uk>
 <98937991-cefa-b7f3-11c3-12727b3159b1@twiddle.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <98937991-cefa-b7f3-11c3-12727b3159b1@twiddle.net>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Richard Henderson <rth@twiddle.net>
Cc: Firoz Khan <firoz.khan@linaro.org>, linux-alpha@vger.kernel.org, ink@jurassic.park.msu.ru, mattst88@gmail.com, y2038@lists.linaro.org, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, arnd@arndb.de, deepa.kernel@gmail.com
Message-ID: <20180811024553.5acOzirfish4JoC0I8nyO1RgMCpnRJduyKc_92DMlEQ@z>

On Fri, Aug 10, 2018 at 07:31:55PM -0700, Richard Henderson wrote:

> > +++ b/arch/alpha/kernel/entry.S
> > @@ -473,7 +473,7 @@ entSys:
> >  	bne     $3, strace
> >  	beq	$4, 1f
> >  	ldq	$27, 0($5)
> > -1:	jsr	$26, ($27), alpha_ni_syscall
> > +1:	jsr	$26, ($27), sys_ni_syscall
> >  	ldgp	$gp, 0($26)
> >  	blt	$0, $syscall_error	/* the call failed */
> >  	stq	$0, 0($sp)
> 
> Once upon a time I had a patch to make the hint
> be sys_gettimeofday, as the most common syscall.
> Dunno what happened to that.

Might as well... ptraced case has it, non-ptraced doesn't.

BTW, seeing that it's your code - why was unop used in
alpha_ni_syscall?  I don't remember the rules re pipeline
stalls; is it that some earlier variants prefer unop to
nop in such places?  It's not that microoptimizing that
one makes any difference, but just out of curiosity -
would something like
	lda     $0, -ENOSYS
	stq     $sp, 0($sp)	/* sp != 0 */
	ret
do just as well there?
