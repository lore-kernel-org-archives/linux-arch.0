From: Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [patch] arch: remove __GFP_REPEAT for order-0 allocations
Date: Tue, 28 Sep 2010 15:53:26 -0700
Message-ID: <20100928155326.9ded5a92.akpm@linux-foundation.org>
References: <alpine.DEB.2.00.1009280344280.11433@chino.kir.corp.google.com>
	<20100928143655.4282a001.akpm@linux-foundation.org>
	<alpine.DEB.2.00.1009281536390.24817@chino.kir.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <owner-linux-mm@kvack.org>
In-Reply-To: <alpine.DEB.2.00.1009281536390.24817@chino.kir.corp.google.com>
Sender: owner-linux-mm@kvack.org
To: David Rientjes <rientjes@google.com>
Cc: Arnd Bergmann <arnd@arndb.de>, Richard Henderson <rth@twiddle.net>, Ivan Kokshaysky <ink@jurassic.park.msu.ru>, Matt Turner <mattst88@gmail.com>, Russell King <linux@arm.linux.org.uk>, Mikael Starvik <starvik@axis.com>, Jesper Nilsson <jesper.nilsson@axis.com>, David Howells <dhowells@redhat.com>, Geert Uytterhoeven <geert@linux-m68k.org>, Roman Zippel <zippel@linux-m68k.org>, Michal Simek <monstr@monstr.eu>, Koichi Yasutake <yasutake.koichi@jp.panasonic.com>, Kyle McMartin <kyle@mcmartin.ca>, Helge Deller <deller@gmx.de>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Paul Mackerras <paulus@samba.org>, Martin Schwidefsky <schwidefsky@de.ibm.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, Paul Mundt <lethal@linux-sh.org>, "David S. Miller" <dav>
List-Id: linux-arch.vger.kernel.org

On Tue, 28 Sep 2010 15:47:57 -0700 (PDT)
David Rientjes <rientjes@google.com> wrote:

> On Tue, 28 Sep 2010, Andrew Morton wrote:
> 
> > > Order-0 allocations, including quicklist_alloc(),  are always under 
> > > PAGE_ALLOC_COSTLY_ORDER, so they loop endlessly in the page allocator
> > > already without the need for __GFP_REPEAT.
> > 
> > That's only true for the current implementation of the page allocator.
> > 
> 
> Yes, but in this case it's irrelevant since we're talking about order-0 
> allocations.  The page allocator will never be changed so that order-0 
> allocations immediately fail if there's no available memory, otherwise 
> we'd only use direct reclaim and the oom killer for high-order allocs or 
> add __GFP_NOFAIL everywhere and that's quite pointless.

The crystal balls are large on this one.

> So we can definitely remove __GFP_REPEAT for any order-0 allocation and 
> it's based on its implementation -- poorly defined as it may be -- and the 
> inherit design of any sane page allocator that retries such an allocation 
> if it's going to use reclaim in the first place.

Why was __GFP_REPEAT used in those callsites?  What were people trying
to achieve?

We shouldn't just go and ignorantly rip it out without understanding
this, and ensuring that we're meeting that intent to the best extent
possible.

--
To unsubscribe, send a message with 'unsubscribe linux-mm' in
the body to majordomo@kvack.org.  For more info on Linux MM,
see: http://www.linux-mm.org/ .
Don't email: <a href=mailto:"dont@kvack.org"> email@kvack.org </a>
