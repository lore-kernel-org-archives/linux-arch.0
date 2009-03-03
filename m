From: Russell King <rmk+lkml@arm.linux.org.uk>
Subject: Re: [PATCH] generic debug pagealloc
Date: Tue, 3 Mar 2009 22:07:14 +0000
Message-ID: <20090303220713.GC31911@flint.arm.linux.org.uk>
References: <20090303160103.GB5812@localhost.localdomain> <20090303133610.cb771fef.akpm@linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <owner-linux-mm@kvack.org>
Content-Disposition: inline
In-Reply-To: <20090303133610.cb771fef.akpm@linux-foundation.org>
Sender: owner-linux-mm@kvack.org
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Akinobu Mita <akinobu.mita@gmail.com>, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, linux-mm@kvack.org
List-Id: linux-arch.vger.kernel.org

On Tue, Mar 03, 2009 at 01:36:10PM -0800, Andrew Morton wrote:
> Alternatively, we could just not do the kmap_atomic() at all.  i386
> won't be using this code and IIRC the only other highmem architecture
> is powerpc32, and ppc32 appears to also have its own DEBUG_PAGEALLOC
> implementation.  So you could remove the kmap_atomic() stuff and put

ARM will also be joining the highmem club in due course, maybe during
the next merge window depending on how things pan out.

The biggest issue we have is with kmaps interacting with ARM's DMA API
code.  Nicolas Pitre currently has a work-around for it, but I believe
it can be better handled by extending the generic kmap infrastructure
to be able to grab a reference on an already kmapped page.  I've asked
Nicolas to discuss this aspect of his patch set on lkml.

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:

--
To unsubscribe, send a message with 'unsubscribe linux-mm' in
the body to majordomo@kvack.org.  For more info on Linux MM,
see: http://www.linux-mm.org/ .
Don't email: <a href=mailto:"dont@kvack.org"> email@kvack.org </a>
