Return-Path: <rppt@kernel.org>
Date: Thu, 24 Oct 2019 11:51:24 +0300
From: Mike Rapoport <rppt@kernel.org>
Subject: Re: [PATCH 08/12] parisc: use pgtable-nopXd instead of 4level-fixup
Message-ID: <20191024085123.GB12281@rapoport-lnx>
References: <1571822941-29776-1-git-send-email-rppt@kernel.org>
 <1571822941-29776-9-git-send-email-rppt@kernel.org>
 <70339cfc547e2fa0f6b98fefb1b1a9fa@sf-tec.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <70339cfc547e2fa0f6b98fefb1b1a9fa@sf-tec.de>
To: Rolf Eike Beer <eike-kernel@sf-tec.de>
Cc: linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>, Anton Ivanov <anton.ivanov@cambridgegreys.com>, Arnd Bergmann <arnd@arndb.de>, "David S. Miller" <davem@davemloft.net>, Geert Uytterhoeven <geert@linux-m68k.org>, Greentime Hu <green.hu@gmail.com>, Greg Ungerer <gerg@linux-m68k.org>, Helge Deller <deller@gmx.de>, "James E.J. Bottomley" <James.Bottomley@hansenpartnership.com>, Jeff Dike <jdike@addtoit.com>, "Kirill A. Shutemov" <kirill@shutemov.name>, Linus Torvalds <torvalds@linux-foundation.org>, Mark Salter <msalter@redhat.com>, Matt Turner <mattst88@gmail.com>, Michal Simek <monstr@monstr.eu>, Richard Weinberger <richard@nod.at>, Russell King <linux@armlinux.org.uk>, Sam Creasey <sammy@sammy.net>, Vincent Chen <deanbo422@gmail.com>, Vineet Gupta <Vineet.Gupta1@synopsys.com>, linux-alpha@vger.kernel.org, linux-arch@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-c6x-dev@linux-c6x.org, linux-kernel@vger.kernel.org, linux-m68k@lists.linux-m68k.org, linux-parisc@vger.kernel.org, linux-um@lists.infradead.org, sparclinux@vger.kernel.org, Mike Rapoport <rppt@linux.ibm.com>, linux-parisc-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
Message-ID: <20191024085124.vC65okuEzEnYPay7cqkOWkM5scC7hASPGgIdHOmAnmc@z>

On Wed, Oct 23, 2019 at 12:20:29PM +0200, Rolf Eike Beer wrote:
> >diff --git a/arch/parisc/include/asm/page.h
> >b/arch/parisc/include/asm/page.h
> >index 93caf17..1d339ee 100644
> >--- a/arch/parisc/include/asm/page.h
> >+++ b/arch/parisc/include/asm/page.h
> >@@ -42,48 +42,54 @@ typedef struct { unsigned long pte; } pte_t; /*
> >either 32 or 64bit */
> >
> > /* NOTE: even on 64 bits, these entries are __u32 because we allocate
> >  * the pmd and pgd in ZONE_DMA (i.e. under 4GB) */
> >-typedef struct { __u32 pmd; } pmd_t;
> > typedef struct { __u32 pgd; } pgd_t;
> > typedef struct { unsigned long pgprot; } pgprot_t;
> >
> >-#define pte_val(x)	((x).pte)
> >-/* These do not work lvalues, so make sure we don't use them as such. */
> >+#if CONFIG_PGTABLE_LEVELS == 3
> >+typedef struct { __u32 pmd; } pmd_t;
> >+#define __pmd(x)	((pmd_t) { (x) } )
> >+/* pXd_val() do not work lvalues, so make sure we don't use them as such.
> >*/
> 
> For me it sounds like there is something missing, maybe an "as" before
> lvalues?

Right, "as lvalues" makes sense.

> And it was "These", so plural, and now it is singular, so do -> does?

There's also pgd_val() a few lines below, it's just not visible in the
patch.
 
> Eike

-- 
Sincerely yours,
Mike.
