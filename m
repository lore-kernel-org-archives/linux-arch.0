From: Mike Rapoport <rppt@kernel.org>
Subject: Re: [PATCH 03/12] mm: reorder includes after introduction of
 linux/pgtable.h
Date: Wed, 13 May 2020 08:21:33 +0300
Message-ID: <20200513052133.GN14260@kernel.org>
References: <20200512184422.12418-1-rppt@kernel.org>
 <20200512184422.12418-4-rppt@kernel.org>
 <20200512192013.GY16070@bombadil.infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-snps-arc-bounces+gla-linux-snps-arc=m.gmane-mx.org@lists.infradead.org>
Content-Disposition: inline
In-Reply-To: <20200512192013.GY16070@bombadil.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-snps-arc>,
 <mailto:linux-snps-arc-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-snps-arc/>
List-Post: <mailto:linux-snps-arc@lists.infradead.org>
List-Help: <mailto:linux-snps-arc-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-snps-arc>,
 <mailto:linux-snps-arc-request@lists.infradead.org?subject=subscribe>
Sender: "linux-snps-arc" <linux-snps-arc-bounces@lists.infradead.org>
Errors-To: linux-snps-arc-bounces+gla-linux-snps-arc=m.gmane-mx.org@lists.infradead.org
To: Matthew Wilcox <willy@infradead.org>
Cc: Rich Felker <dalias@libc.org>, linux-ia64@vger.kernel.org, linux-sh@vger.kernel.org, Catalin Marinas <catalin.marinas@arm.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, linux-mips@vger.kernel.org, Max Filippov <jcmvbkbc@gmail.com>, Guo Ren <guoren@kernel.org>, linux-csky@vger.kernel.org, sparclinux@vger.kernel.org, linux-hexagon@vger.kernel.org, linux-riscv@lists.infradead.org, Vincent Chen <deanbo422@gmail.com>, Will Deacon <will@kernel.org>, Greg Ungerer <gerg@linux-m68k.org>, linux-arch@vger.kernel.org, linux-s390@vger.kernel.org, linux-c6x-dev@linux-c6x.org, Brian Cain <bcain@codeaurora.org>, Michael Ellerman <mpe@ellerman.id.au>, Helge Deller <deller@gmx.de>, x86@kernel.org, Russell King <linux@armlinux.org.uk>, Ley Foon Tan <ley.foon.tan@intel.com>, Mike Rapoport <rppt@linux.ibm.com>, Ingo Molnar <mingo@redhat.com>, Geert Uytterhoeven <geert@linux-m68k.org>lin
List-Id: linux-arch.vger.kernel.org

On Tue, May 12, 2020 at 12:20:13PM -0700, Matthew Wilcox wrote:
> On Tue, May 12, 2020 at 09:44:13PM +0300, Mike Rapoport wrote:
> > diff --git a/arch/alpha/kernel/proto.h b/arch/alpha/kernel/proto.h
> > index a093cd45ec79..701a05090141 100644
> > --- a/arch/alpha/kernel/proto.h
> > +++ b/arch/alpha/kernel/proto.h
> > @@ -2,8 +2,6 @@
> >  #include <linux/interrupt.h>
> >  #include <linux/io.h>
> >  
> > -#include <linux/pgtable.h>
> > -
> >  /* Prototypes of functions used across modules here in this directory.  */
> >  
> >  #define vucp	volatile unsigned char  *
> 
> Looks like your script has a bug if linux/pgtable.h is the last include
> in the file?

Script indeed cannot handle all the corner case, but this is not one of
them.
I've started initially to look into removing asm/pgtable.h if it was not
needed, but I've run out of patience very soon. This file is what
sneaked in from that attempt.

-- 
Sincerely yours,
Mike.
