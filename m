From: Mike Rapoport <rppt@kernel.org>
Subject: Re: [PATCH v2 01/13] alpha: use pgtable-nop4d instead of 4level-fixup
Date: Fri, 1 Nov 2019 22:59:11 +0100
Message-ID: <20191101215905.GB20065@rapoport-lnx>
References: <1572597584-6390-1-git-send-email-rppt@kernel.org>
 <1572597584-6390-2-git-send-email-rppt@kernel.org>
 <20191101091157.q4cesn6vsiy5qj2j@box>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20191101091157.q4cesn6vsiy5qj2j@box>
Sender: linux-kernel-owner@vger.kernel.org
To: "Kirill A. Shutemov" <kirill@shutemov.name>
Cc: linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>, Anton Ivanov <anton.ivanov@cambridgegreys.com>, Arnd Bergmann <arnd@arndb.de>, "David S. Miller" <davem@davemloft.net>, Geert Uytterhoeven <geert@linux-m68k.org>, Greentime Hu <green.hu@gmail.com>, Greg Ungerer <gerg@linux-m68k.org>, Helge Deller <deller@gmx.de>, "James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>, Jeff Dike <jdike@addtoit.com>, Linus Torvalds <torvalds@linux-foundation.org>, Mark Salter <msalter@redhat.com>, Matt Turner <mattst88@gmail.com>, Michal Simek <monstr@monstr.eu>, Peter Rosin <peda@axentia.se>, Richard Weinberger <richard@nod.at>, Rolf Eike Beer <eike-kernel@sf-tec.de>, Russell King <linux@armlinux.org.uk>, Sam Creasey <sammy@sammy.net>, Vinc
List-Id: linux-arch.vger.kernel.org

On Fri, Nov 01, 2019 at 12:11:57PM +0300, Kirill A. Shutemov wrote:
> On Fri, Nov 01, 2019 at 10:39:32AM +0200, Mike Rapoport wrote:
> > From: Mike Rapoport <rppt@linux.ibm.com>
> > 
> > It is not likely alpha will have 5-level page tables.
> > 
> > Replace usage of include/asm-generic/4level-fixup.h and implied
> > __ARCH_HAS_4LEVEL_HACK with include/asm-generic/pgtable-nop4d.h and adjust
> > page table manipulation macros and functions accordingly.
> 
> Not pgtable-nop4d.h, but pgtable-nopud.h. Also in subject.

Ouch, of course.
 
> -- 
>  Kirill A. Shutemov

-- 
Sincerely yours,
Mike.
