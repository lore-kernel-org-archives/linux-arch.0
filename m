From: Guenter Roeck <linux@roeck-us.net>
Subject: Re: fs: dax: do not build on ARC or SH
Date: Mon, 23 Feb 2015 14:15:38 -0800
Message-ID: <20150223221538.GA25109@roeck-us.net>
References: <5778538.KJ98x3yxkB@wuerfel>
 <20150223184025.GD2780@wil.cx>
 <20150223215634.GA23928@roeck-us.net>
 <20150223215847.GA29052@infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-fsdevel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20150223215847.GA29052@infradead.org>
Sender: linux-fsdevel-owner@vger.kernel.org
To: Christoph Hellwig <hch@infradead.org>
Cc: Matthew Wilcox <willy@linux.intel.com>, Arnd Bergmann <arnd@arndb.de>, Geert Uytterhoeven <geert@linux-m68k.org>, linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>, linux-sh@vger.kernel.org, Vineet Gupta <vgupta@synopsys.com>
List-Id: linux-arch.vger.kernel.org

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
