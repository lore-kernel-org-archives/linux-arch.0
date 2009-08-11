From: Heiko Carstens <heiko.carstens@de.ibm.com>
Subject: Re: [patch 2/4] spinlock: add macro to generate out-of-line
 variants
Date: Tue, 11 Aug 2009 18:56:11 +0200
Message-ID: <20090811165611.GA6425@osiris.boeblingen.de.ibm.com>
References: <20090811124756.873490673@de.ibm.com>
 <20090811124912.494596235@de.ibm.com>
 <200908111525.26379.arnd@arndb.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mtagate1.uk.ibm.com ([194.196.100.161]:33648 "EHLO
	mtagate1.uk.ibm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754668AbZHKQ4M (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Tue, 11 Aug 2009 12:56:12 -0400
Received: from d06nrmr1707.portsmouth.uk.ibm.com (d06nrmr1707.portsmouth.uk.ibm.com [9.149.39.225])
	by mtagate1.uk.ibm.com (8.13.1/8.13.1) with ESMTP id n7BGuDgo032071
	for <linux-arch@vger.kernel.org>; Tue, 11 Aug 2009 16:56:13 GMT
Received: from d06av03.portsmouth.uk.ibm.com (d06av03.portsmouth.uk.ibm.com [9.149.37.213])
	by d06nrmr1707.portsmouth.uk.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id n7BGuDkM1724426
	for <linux-arch@vger.kernel.org>; Tue, 11 Aug 2009 17:56:13 +0100
Received: from d06av03.portsmouth.uk.ibm.com (loopback [127.0.0.1])
	by d06av03.portsmouth.uk.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id n7BGuCF8023882
	for <linux-arch@vger.kernel.org>; Tue, 11 Aug 2009 17:56:13 +0100
Content-Disposition: inline
In-Reply-To: <200908111525.26379.arnd@arndb.de>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Arnd Bergmann <arnd@arndb.de>
Cc: Andrew Morton <akpm@linux-foundation.org>, Linus Torvalds <torvalds@linux-foundation.org>, Peter Zijlstra <a.p.zijlstra@chello.nl>, Ingo Molnar <mingo@elte.hu>, linux-arch@vger.kernel.org, Martin Schwidefsky <schwidefsky@de.ibm.com>

On Tue, Aug 11, 2009 at 03:25:26PM +0200, Arnd Bergmann wrote:
> On Tuesday 11 August 2009, Heiko Carstens wrote:
> > Since the bodies of the spinlock functions are in a header
> > file most functions in spinlock.c look like this:
> > 
> > int __lockfunc _spin_trylock(spinlock_t *lock)
> > {
> >         return __spin_trylock(lock);
> > }
> > EXPORT_SYMBOL(_spin_trylock);
> > 
> > That's just a simple wrapper. Its the same for spin-,
> > read- and write-lock. So add an extra macro and generate
> > all versions automatically like it is already done for
> > the preemption friendly locks.
> > 
> > Signed-off-by: Heiko Carstens <heiko.carstens@de.ibm.com>
> 
> If you generate function definitions from macros, you break
> ctags support for following the call chain, which is rather
> bad when someone tries to understand what the code does.
> 
> I would just leave out this patch, AFAICT there are no
> dependencies between this and the following patches,
> and the object code remains identical.

Ok, I just drop this patch. I wasn't aware this could cause problems,
since I don't use tags.

Thanks!
