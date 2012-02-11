From: Al Viro <viro@ZenIV.linux.org.uk>
Subject: Re: [PATCH resend] asm/types.h: All architectures use int-ll64.h in
 kernelspace
Date: Sat, 11 Feb 2012 09:44:44 +0000
Message-ID: <20120211094444.GL23916@ZenIV.linux.org.uk>
References: <alpine.DEB.2.00.1108132152050.18053@ayla.of.borg>
 <1665974.2LGtkbyJmJ@wuerfel>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-doc-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1665974.2LGtkbyJmJ@wuerfel>
Sender: linux-doc-owner@vger.kernel.org
To: Arnd Bergmann <arnd@arndb.de>
Cc: Geert Uytterhoeven <geert@linux-m68k.org>, Linus Torvalds <torvalds@linux-foundation.org>, Andrew Morton <akpm@linux-foundation.org>, Randy Dunlap <rdunlap@xenotime.net>, linux-arch@vger.kernel.org, linux-doc@vger.kernel.org, Linux Kernel Development <linux-kernel@vger.kernel.org>
List-Id: linux-arch.vger.kernel.org

On Sat, Aug 13, 2011 at 11:25:59PM +0200, Arnd Bergmann wrote:
> On Saturday 13 August 2011 21:53:43 Geert Uytterhoeven wrote:
> > Now all 64-bit architectures have been converted to int-ll64.h, we can
> > deprecate int-l64.h in kernelspace:
> >   - Add a check to prevent new architectures from using int-l64.h in
> >     kernelspace,
> >   - Update documentation, as the casts to (unsigned) long long are no longer
> >     needed.
> > 
> > For backwards compatibility, alpha, ia64, mips, and powerpc still use
> > int-l64.h in userspace.
> > 
> > Signed-off-by: Geert Uytterhoeven <geert@linux-m68k.org>
> > For the documentation parts:
> > Acked-by: Randy Dunlap <rdunlap@xenotime.net>
> 
> I believe that Al Viro is working on a patch to unify all umode_t definitions
> so that it becomes unsigned short everywhere. Once that is done,
> asm-generic/int-ll64.h can become asm-generic/types.h and all architectures
> can use that.

Umm...  That has happened and yes, asm-generic/types.h is currently
equivalent to asm-generic/int-ll64.h.  What exactly are you planning
to do?  Just rename the latter to the former and do search-and-replace
over the tree?  We still have places that pull int-l64.h, albeit only
!__KERNEL__ ones (i.e. everything under #ifdef __KERNEL__ in there
seems to be killable)...

AFAICS, for quite a few of those guys we can simply add bitsperlong.h
and add types.h to generic-y; is that the plan?
