From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [patch 2/4] spinlock: add macro to generate out-of-line variants
Date: Tue, 11 Aug 2009 15:25:26 +0200
Message-ID: <200908111525.26379.arnd@arndb.de>
References: <20090811124756.873490673@de.ibm.com> <20090811124912.494596235@de.ibm.com>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.126.186]:57634 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752986AbZHKNZh (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Tue, 11 Aug 2009 09:25:37 -0400
In-Reply-To: <20090811124912.494596235@de.ibm.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Heiko Carstens <heiko.carstens@de.ibm.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, Linus Torvalds <torvalds@linux-foundation.org>, Peter Zijlstra <a.p.zijlstra@chello.nl>, Ingo Molnar <mingo@elte.hu>, linux-arch@vger.kernel.org, Martin Schwidefsky <schwidefsky@de.ibm.com>

On Tuesday 11 August 2009, Heiko Carstens wrote:
> Since the bodies of the spinlock functions are in a header
> file most functions in spinlock.c look like this:
> 
> int __lockfunc _spin_trylock(spinlock_t *lock)
> {
>         return __spin_trylock(lock);
> }
> EXPORT_SYMBOL(_spin_trylock);
> 
> That's just a simple wrapper. Its the same for spin-,
> read- and write-lock. So add an extra macro and generate
> all versions automatically like it is already done for
> the preemption friendly locks.
> 
> Signed-off-by: Heiko Carstens <heiko.carstens@de.ibm.com>

If you generate function definitions from macros, you break
ctags support for following the call chain, which is rather
bad when someone tries to understand what the code does.

I would just leave out this patch, AFAICT there are no
dependencies between this and the following patches,
and the object code remains identical.

Alternatively, you could perhaps change scripts/tags.sh so
that the tags file points to the macro location for
each _spin_* function.

The other patches look good.

	Arnd <><
