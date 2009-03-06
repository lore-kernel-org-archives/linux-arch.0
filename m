From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [PATCH] generic debug pagealloc
Date: Fri, 06 Mar 2009 20:14:20 +1100
Message-ID: <1236330860.7260.128.camel@pasglop>
References: <20090303160103.GB5812@localhost.localdomain>
	 <20090303133610.cb771fef.akpm@linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <owner-linux-mm@kvack.org>
In-Reply-To: <20090303133610.cb771fef.akpm@linux-foundation.org>
Sender: owner-linux-mm@kvack.org
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Akinobu Mita <akinobu.mita@gmail.com>, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, linux-mm@kvack.org
List-Id: linux-arch.vger.kernel.org

On Tue, 2009-03-03 at 13:36 -0800, Andrew Morton wrote:
> Alternatively, we could just not do the kmap_atomic() at all.  i386
> won't be using this code and IIRC the only other highmem architecture
> is powerpc32, and ppc32 appears to also have its own DEBUG_PAGEALLOC
> implementation.  So you could remove the kmap_atomic() stuff and put
> 
Actually, ppc32 DEBUG_PAGEALLOC is busted in several ways and probably
unfixable (though this is still being debated).

Cheers,
Ben.


--
To unsubscribe, send a message with 'unsubscribe linux-mm' in
the body to majordomo@kvack.org.  For more info on Linux MM,
see: http://www.linux-mm.org/ .
Don't email: <a href=mailto:"dont@kvack.org"> email@kvack.org </a>
