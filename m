From: Ralf Baechle <ralf@linux-mips.org>
Subject: HAVE_CMPXCHG_LOCAL arch support.
Date: Wed, 10 Jun 2015 17:57:09 +0200
Message-ID: <20150610155709.GH2753@linux-mips.org>
References: <55759543.1010408@gmail.com>
 <20150610145804.GG2753@linux-mips.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-mips-bounce@linux-mips.org>
Content-Disposition: inline
In-Reply-To: <20150610145804.GG2753@linux-mips.org>
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
List-help: <mailto:ecartis@linux-mips.org?Subject=help>
List-unsubscribe: <mailto:ecartis@linux-mips.org?subject=unsubscribe%20linux-mips>
List-software: Ecartis version 1.0.0
List-subscribe: <mailto:ecartis@linux-mips.org?subject=subscribe%20linux-mips>
List-owner: <mailto:ralf@linux-mips.org>
List-post: <mailto:linux-mips@linux-mips.org>
List-archive: <http://www.linux-mips.org/archives/linux-mips/>
To: Xose Vazquez Perez <xose.vazquez@gmail.com>
Cc: linux-arch@vger.kernel.org, linux-mips@linux-mips.org, linux-kernel@vger.kernel.org, Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>
List-Id: linux-arch.vger.kernel.org

On Wed, Jun 10, 2015 at 04:58:04PM +0200, Ralf Baechle wrote:

> On Mon, Jun 08, 2015 at 03:14:43PM +0200, Xose Vazquez Perez wrote:
> 
> > If there is anything wrong, please report it in this thread:
> > https://marc.info/?t=143332955700003
> 
> 
> >    locking/ cmpxchg-local        : TODO |                  HAVE_CMPXCHG_LOCAL #  arch supports the this_cpu_cmpxchg() API
> 
> This one was easy - we have the functions in the code just no "select
> HAVE_CMPXCHG_LOCAL" Kconfig.

Something's wrong there.  The new file
Documentation/features/locking/cmpxchg-local/arch-support.txt in linux-next
claims correctly that only s390 and x86 define HAVE_CMPXCHG_LOCAL.  And a
git grep -w cmpxchg_local finds that in addition to these alpha, arm, arm64,
avr32, blackfin, c6x, frv, ia64, m32r, m68k, mips, parisc, powerpc, sparc,
unicore32 and xtensa define cmpxchg_local.

These architectures seem to not define cmpxchg_local in their arch/ dir:

  arc cris hexagon metag microblaze mn10300 nios2 openrisc score sh tile um

Microblaze and nios2 include <asm-generic/cmpxchg.h> into their arch
cmpxchg.h so they get a definition of these functions but don't define
HAVE_CMPXCHG_LOCAL.  Peter Zijlstra said it the local versions are ~ 20
cycles faster on x86 than the "global" version.  But I've found one user
of cmpxchg_local, mm/vmstat.c and one user of cmpxchg64_local,
drivers/iommu/intel-iommu.c.  Sure, fixing the issue was trivial for me
on MIPS but is having cmpxchg{,64}_local actually worth it?  

Cheers,

  Ralf
