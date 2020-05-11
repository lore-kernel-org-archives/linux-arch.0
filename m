From: Thomas Bogendoerfer <tsbogend@alpha.franken.de>
Subject: Re: [PATCH 03/31] MIPS: unexport __flush_icache_user_range
Date: Mon, 11 May 2020 18:01:35 +0200
Message-ID: <20200511160135.GA17079@alpha.franken.de>
References: <20200510075510.987823-1-hch@lst.de>
 <20200510075510.987823-4-hch@lst.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20200510075510.987823-4-hch@lst.de>
Sender: linux-kernel-owner@vger.kernel.org
To: Christoph Hellwig <hch@lst.de>
Cc: Andrew Morton <akpm@linux-foundation.org>, Arnd Bergmann <arnd@arndb.de>, Roman Zippel <zippel@linux-m68k.org>, Jessica Yu <jeyu@kernel.org>, Michal Simek <monstr@monstr.eu>, x86@kernel.org, linux-alpha@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-c6x-dev@linux-c6x.org, linux-hexagon@vger.kernel.org, linux-ia64@vger.kernel.org, linux-m68k@lists.linux-m68k.org, linux-mips@vger.kernel.org, openrisc@lists.librecores.org, linuxppc-dev@lists.ozlabs.org, linux-riscv@lists.infradead.org, linux-sh@vger.kernel.org, sparclinux@vger.kernel.org, linux-arch@vger.kernel.org, linux-mm@kvack.org, linux-um@lists.infradead.org, linux-xtensa@linux-xtensa.org, linux-fsdevel@vger.kernel.org
List-Id: linux-arch.vger.kernel.org

On Sun, May 10, 2020 at 09:54:42AM +0200, Christoph Hellwig wrote:
> __flush_icache_user_range is not used in modular code, so unexport it.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>  arch/mips/mm/cache.c | 1 -
>  1 file changed, 1 deletion(-)

applied to mips-next.

Thomas.

-- 
Crap can work. Given enough thrust pigs will fly, but it's not necessarily a
good idea.                                                [ RFC1925, 2.3 ]
