Return-Path: <linux-arch-owner@vger.kernel.org>
Date: Fri, 11 Mar 2005 00:03:51 +0000
From: Ralf Baechle <ralf@linux-mips.org>
Subject: Re: ia64-specific-dev-mem-handlers.patch
Message-ID: <20050311000351.GA4820@linux-mips.org>
References: <20050310121618.1242b2d6.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050310121618.1242b2d6.akpm@osdl.org>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-arch@vger.kernel.org, Jes Sorensen <jes@trained-monkey.org>
List-ID: <linux-arch.vger.kernel.org>

On Thu, Mar 10, 2005 at 12:16:18PM -0800, Andrew Morton wrote:

> It is believed that this will be useful to other architectures which allow
> users to uncacheably map RAM.  Could interested parties please comment?

MIPS has a very similar problem to solve except that we would ideally
want not 1 but 3 bits in struct page that indicate the cache mode to be
used.  This would simplify the use of memory as framebuffer on UMA systems
where neither the normal cache mode of the kernel nor uncached is optimal.

  Ralf
