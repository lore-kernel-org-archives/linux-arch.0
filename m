Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from bh-25.webhostbox.net ([208.91.199.152]:55391 "EHLO
	bh-25.webhostbox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751601AbbBWWQU (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Mon, 23 Feb 2015 17:16:20 -0500
Received: from mailnull by bh-25.webhostbox.net with sa-checked (Exim 4.82)
	(envelope-from <linux@roeck-us.net>)
	id 1YQ1Ia-000gVg-7P
	for linux-arch@vger.kernel.org; Mon, 23 Feb 2015 22:16:20 +0000
Date: Mon, 23 Feb 2015 14:15:38 -0800
From: Guenter Roeck <linux@roeck-us.net>
Subject: Re: fs: dax: do not build on ARC or SH
Message-ID: <20150223221538.GA25109@roeck-us.net>
References: <5778538.KJ98x3yxkB@wuerfel>
 <20150223184025.GD2780@wil.cx>
 <20150223215634.GA23928@roeck-us.net>
 <20150223215847.GA29052@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20150223215847.GA29052@infradead.org>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Christoph Hellwig <hch@infradead.org>
Cc: Matthew Wilcox <willy@linux.intel.com>, Arnd Bergmann <arnd@arndb.de>, Geert Uytterhoeven <geert@linux-m68k.org>, linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>, linux-sh@vger.kernel.org, Vineet Gupta <vgupta@synopsys.com>
Message-ID: <20150223221538.kAF4c96D_L8AYgqYCkdvcwYNyYJHUyFSE5qxBLPsl4Y@z>

On Mon, Feb 23, 2015 at 01:58:47PM -0800, Christoph Hellwig wrote:
> On Mon, Feb 23, 2015 at 01:56:34PM -0800, Guenter Roeck wrote:
> > Guess there a philosophical difference in opinion if the architecture code
> > should (have to) provide copy_user_page() or not outside the architecture
> > code itself. After all, fs/dax.c _is_ the only user of this function outside
> > the architecture code.
> 
> Given that copy_user_page just is an optimized version of copy_page
> all these architectures should just grab the trivial macro defintion
> from the asm-generic version so that we could avoid this discussion.
> 
I tried to do just that, for mips, with little success.

https://patchwork.linux-mips.org/patch/9175/

Presumably, if copy_page() followed by a conditional flush_data_cache_page()
does not work on mips, I would assume that copy_page() without flush does not
work either.

Guenter
