From: Matthew Wilcox <matthew@wil.cx>
Subject: Re: [PATCH -v2] Move list types from <linux/list.h> to
	<linux/types.h>.
Date: Sun, 4 Jul 2010 10:56:38 -0600
Message-ID: <20100704165638.GE5842@parisc-linux.org>
References: <201007041242.o64CggfV012188@farm-0002.internal.tilera.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from palinux.external.hp.com ([192.25.206.14]:33881 "EHLO
	mail.parisc-linux.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757851Ab0GDQ4k (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Sun, 4 Jul 2010 12:56:40 -0400
Content-Disposition: inline
In-Reply-To: <201007041242.o64CggfV012188@farm-0002.internal.tilera.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Chris Metcalf <cmetcalf@tilera.com>
Cc: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, Linus Torvalds <torvalds@linux-foundation.org>, Christoph Hellwig <hch@infradead.org>, Alexey Dobriyan <adobriyan@gmail.com>, Arnd Bergmann <arnd@arndb.de>

On Fri, Jul 02, 2010 at 01:41:14PM -0400, Chris Metcalf wrote:
> This allows a list_head (or hlist_head, etc.) to be used from places
> that used to be impractical, in particular <asm/processor.h>, which
> used to cause include file recursion: <linux/list.h> includes
> <linux/prefetch.h>, which always includes <asm/processor.h> for the
> prefetch macros, as well as <asm/system.h>, which often includes
> <asm/processor.h> directly or indirectly.
> 
> This avoids a lot of painful workaround hackery on the tile
> architecture, where we use a list_head in the thread_struct to chain
> together tasks that are activated on a particular hardwall.
> 
> Signed-off-by: Chris Metcalf <cmetcalf@tilera.com>

Reviewed-by: Matthew Wilcox <willy@linux.intel.com>

-- 
Matthew Wilcox				Intel Open Source Technology Centre
"Bill, look, we understand that you're interested in selling us this
operating system, but compare it to ours.  We can't possibly take such
a retrograde step."
