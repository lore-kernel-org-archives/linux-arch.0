From: Peter Zijlstra <a.p.zijlstra@chello.nl>
Subject: Re: [patch 2/4] spinlock: add macro to generate out-of-line
 variants
Date: Tue, 11 Aug 2009 15:35:28 +0200
Message-ID: <1249997728.10001.9.camel@twins>
References: <20090811124756.873490673@de.ibm.com>
	 <20090811124912.494596235@de.ibm.com>  <200908111525.26379.arnd@arndb.de>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from viefep14-int.chello.at ([62.179.121.34]:47399 "EHLO
	viefep14-int.chello.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753318AbZHKNfy (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Tue, 11 Aug 2009 09:35:54 -0400
In-Reply-To: <200908111525.26379.arnd@arndb.de>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Arnd Bergmann <arnd@arndb.de>
Cc: Heiko Carstens <heiko.carstens@de.ibm.com>, Andrew Morton <akpm@linux-foundation.org>, Linus Torvalds <torvalds@linux-foundation.org>, Ingo Molnar <mingo@elte.hu>, linux-arch@vger.kernel.org, Martin Schwidefsky <schwidefsky@de.ibm.com>

On Tue, 2009-08-11 at 15:25 +0200, Arnd Bergmann wrote:
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
> 
> Alternatively, you could perhaps change scripts/tags.sh so
> that the tags file points to the macro location for
> each _spin_* function.
> 
> The other patches look good.

Ah, good point, I wish someone would teach that ctags script about the
paravirt crap, but I'm afraid paravirt is too inconsistent to begin
with.

/me itches again to send a patch removing it all-together ;-)
