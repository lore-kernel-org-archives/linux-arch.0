From: Matthew Wilcox <matthew@wil.cx>
Subject: u64-ull
Date: Mon, 28 Jul 2008 06:19:52 -0600
Message-ID: <20080728121952.GE18026@parisc-linux.org>
References: <1217214947.11188.156.camel@pasglop> <1217238791.6331.15.camel@twins> <1217239403.11188.189.camel@pasglop> <20080728035340.e8c931f5.akpm@linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from palinux.external.hp.com ([192.25.206.14]:37620 "EHLO
	mail.parisc-linux.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750744AbYG1MTx (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Mon, 28 Jul 2008 08:19:53 -0400
Content-Disposition: inline
In-Reply-To: <20080728035340.e8c931f5.akpm@linux-foundation.org>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: benh@kernel.crashing.org, Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@elte.hu>, "H. Peter Anvin" <hpa@zytor.com>, linux-arch@vger.kernel.org

On Mon, Jul 28, 2008 at 03:53:40AM -0700, Andrew Morton wrote:
> On Mon, 28 Jul 2008 20:03:23 +1000 Benjamin Herrenschmidt <benh@kernel.crashing.org> wrote:
> 
> > Andrew, what was your decision vs. changing once for all u64 and s64 on
> > all archs to be long long's ?
> 
> We should do it.  Matthew's initial patch was busted and I don't
> _really_ want to have to take on all the fallout.  It's a project for
> someone: get the core patch working then start fixing up fallout.  At
> least make it all compile, hopefully fix most of the warnings too.

Yeah, I just threw it out as a trial balloon without thinking about it
properly.  We need to test:

include/asm-alpha/types.h:#include <asm-generic/int-l64.h>
include/asm-ia64/types.h:#include <asm-generic/int-l64.h>
include/asm-mips/types.h:# include <asm-generic/int-l64.h>
include/asm-powerpc/types.h:# include <asm-generic/int-l64.h>
include/asm-s390/types.h:# include <asm-generic/int-l64.h>
include/asm-sparc/types.h:#include <asm-generic/int-l64.h>

I can take care of ia64 easily enough.  Ben is, I presume, willing to
take care of powerpc.  Just need to find suckers^W people willing to fix
up alpha, mips, s390 and sparc.

I don't think this needs to go in during the merge window, I'm happy to
wait until -rc2 or something.  Anyway, initial patch at
http://git.kernel.org/?p=linux/kernel/git/willy/misc.git;a=shortlog;h=u64-ull
so if anyone wants to get started early ...

-- 
Intel are signing my paycheques ... these opinions are still mine
"Bill, look, we understand that you're interested in selling us this
operating system, but compare it to ours.  We can't possibly take such
a retrograde step."
