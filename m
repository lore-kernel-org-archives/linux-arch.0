From: Peter Zijlstra <peterz@infradead.org>
Subject: Re: HAVE_CMPXCHG_LOCAL arch support.
Date: Wed, 10 Jun 2015 18:00:00 +0200
Message-ID: <1433952000.1495.56.camel@twins>
References: <55759543.1010408@gmail.com>
	 <20150610145804.GG2753@linux-mips.org>
	 <20150610155709.GH2753@linux-mips.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from casper.infradead.org ([85.118.1.10]:60680 "EHLO
	casper.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752151AbbFJQAF convert rfc822-to-8bit (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Wed, 10 Jun 2015 12:00:05 -0400
In-Reply-To: <20150610155709.GH2753@linux-mips.org>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Ralf Baechle <ralf@linux-mips.org>
Cc: Xose Vazquez Perez <xose.vazquez@gmail.com>, linux-arch@vger.kernel.org, linux-mips@linux-mips.org, linux-kernel@vger.kernel.org, Ingo Molnar <mingo@redhat.com>

On Wed, 2015-06-10 at 17:57 +0200, Ralf Baechle wrote:
> On Wed, Jun 10, 2015 at 04:58:04PM +0200, Ralf Baechle wrote:
> 
> > On Mon, Jun 08, 2015 at 03:14:43PM +0200, Xose Vazquez Perez wrote:
> > 
> > > If there is anything wrong, please report it in this thread:
> > > https://marc.info/?t=143332955700003
> > 
> > 
> > >    locking/ cmpxchg-local        : TODO |                  HAVE_CMPXCHG_LOCAL #  arch supports the this_cpu_cmpxchg() API
> > 
> > This one was easy - we have the functions in the code just no "select
> > HAVE_CMPXCHG_LOCAL" Kconfig.
> 
> Something's wrong there.  The new file
> Documentation/features/locking/cmpxchg-local/arch-support.txt in linux-next
> claims correctly that only s390 and x86 define HAVE_CMPXCHG_LOCAL.  And a
> git grep -w cmpxchg_local finds that in addition to these alpha, arm, arm64,
> avr32, blackfin, c6x, frv, ia64, m32r, m68k, mips, parisc, powerpc, sparc,
> unicore32 and xtensa define cmpxchg_local.
> 
> These architectures seem to not define cmpxchg_local in their arch/ dir:
> 
>   arc cris hexagon metag microblaze mn10300 nios2 openrisc score sh tile um
> 
> Microblaze and nios2 include <asm-generic/cmpxchg.h> into their arch
> cmpxchg.h so they get a definition of these functions but don't define
> HAVE_CMPXCHG_LOCAL.  Peter Zijlstra said it the local versions are ~ 20
> cycles faster on x86 than the "global" version.  But I've found one user
> of cmpxchg_local, mm/vmstat.c and one user of cmpxchg64_local,
> drivers/iommu/intel-iommu.c.  Sure, fixing the issue was trivial for me
> on MIPS but is having cmpxchg{,64}_local actually worth it?  

If you traverse the obfuscation chain a little, you'll find that
local_cmpxchg() is implemented using cmpxchg_local(), and there are a
few more users of that.
