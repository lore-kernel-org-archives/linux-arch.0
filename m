From: Ingo Molnar <mingo@elte.hu>
Subject: Re: [PATCH] build fix for generic debug pagealloc
Date: Fri, 3 Apr 2009 18:44:50 +0200
Message-ID: <20090403164450.GC3047@elte.hu>
References: <a4423d670904020421k7395e11dwe70d4223cb817e0a@mail.gmail.com> <20090402163145.GA28728@localhost.localdomain> <20090402094522.b29004c8.akpm@linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S934928AbZDCQrG@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20090402094522.b29004c8.akpm@linux-foundation.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Andrew Morton <akpm@linux-foundation.org>, "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: Akinobu Mita <akinobu.mita@gmail.com>, Alexander Beregalov <a.beregalov@gmail.com>, "linux-next@vger.kernel.org" <linux-next@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, linux-arch@vger.kernel.org, "David S. Miller" <davem@davemloft.net>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Paul Mackerras <paulus@samba.org>, Martin Schwidefsky <schwidefsky@de.ibm.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, "H. Peter Anvin" <hpa@zytor.com>
List-Id: linux-arch.vger.kernel.org


* Andrew Morton <akpm@linux-foundation.org> wrote:

> > +config DEBUG_PAGEALLOC
> > +	bool "Debug page memory allocations"
> > +	depends on DEBUG_KERNEL && ARCH_SUPPORTS_DEBUG_PAGEALLOC
> > +	depends on !HIBERNATION || !PPC && !SPARC
> > +	---help---
> > +	  Unmap pages from the kernel linear mapping after free_pages().
> > +	  This results in a large slowdown, but helps to find certain types
> > +	  of memory corruptions.
> > +
> 
> I guess this is why it wasn't discovered in my compile testing.  
> It's quite regrettable that `make allmodconfig' didn't enable the 
> feature. That's what allmodconfig is for.

Hm, i _do_ remember some hibernation magic fix from Rafael, in the 
area of debugalloc. Many months ago.

Rafael, is it supposed to work? If yes, i think we should unblock 
it.

	Ingo
