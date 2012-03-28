From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [PATCHv2 04/14] PowerPC: adapt for dma_map_ops changes
Date: Wed, 28 Mar 2012 14:56:40 +1100
Message-ID: <1332907000.2882.74.camel@pasglop>
References: <1332855768-32583-1-git-send-email-m.szyprowski@samsung.com>
	 <1332855768-32583-5-git-send-email-m.szyprowski@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <owner-linux-mm@kvack.org>
In-Reply-To: <1332855768-32583-5-git-send-email-m.szyprowski@samsung.com>
Sender: owner-linux-mm@kvack.org
To: Marek Szyprowski <m.szyprowski@samsung.com>
Cc: linux-kernel@vger.kernel.org, linux-mips@linux-mips.org, Kevin Cernekee <cernekee@gmail.com>, linux-ia64@vger.kernel.org, linux-sh@vger.kernel.org, linux-mm@kvack.org, sparclinux@vger.kernel.org, Guan Xuetao <gxt@mprc.pku.edu.cn>, linux-arch@vger.kernel.org, Stephen Rothwell <sfr@canb.auug.org.au>, Jonathan Corbet <corbet@lwn.net>, x86@kernel.org, Matt Turner <mattst88@gmail.com>, Dezhong Diao <dediao@cisco.com>, Fenghua Yu <fenghua.yu@intel.com>, Arnd Bergmann <arnd@arndb.de>, microblaze-uclinux@itee.uq.edu.au, linaro-mm-sig@lists.linaro.org, Ivan Kokshaysky <ink@jurassic.park.msu.ru>, Andrzej Pietrasiewicz <andrzej.p@samsung.com>, Thomas Gleixner <tglx@linutronix.de>, linux-arm-kernel@lists.infradead.org, Richard Henderson <rth@twiddle.net>, discuss@x86-64.org, Mich
List-Id: linux-arch.vger.kernel.org

On Tue, 2012-03-27 at 15:42 +0200, Marek Szyprowski wrote:
> From: Andrzej Pietrasiewicz <andrzej.p@samsung.com>
> 
> Adapt core PowerPC architecture code for dma_map_ops changes: replace
> alloc/free_coherent with generic alloc/free methods.
> 
> Signed-off-by: Andrzej Pietrasiewicz <andrzej.p@samsung.com>
> [added missing changes to arch/powerpc/kernel/vio.c]
> Signed-off-by: Kyungmin Park <kyungmin.park@samsung.com>
> Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
> Reviewed-by: David Gibson <david@gibson.dropbear.id.au>
> Reviewed-by: Arnd Bergmann <arnd@arndb.de>
> ---

FYI. David and Arnd reviews are good enough for me ppc-side.

Cheers,
Ben.


--
To unsubscribe, send a message with 'unsubscribe linux-mm' in
the body to majordomo@kvack.org.  For more info on Linux MM,
see: http://www.linux-mm.org/ .
Fight unfair telecom internet charges in Canada: sign http://stopthemeter.ca/
Don't email: <a href=mailto:"dont@kvack.org"> email@kvack.org </a>
