From: Boaz Harrosh <boaz@plexistor.com>
Subject: Re: [PATCH] fs: dax: do not build on ARC or SH
Date: Mon, 13 Jul 2015 14:57:10 +0300
Message-ID: <55A3A796.4050108@plexistor.com>
References: <1436781167-14446-1-git-send-email-geert+renesas@glider.be>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1436781167-14446-1-git-send-email-geert+renesas@glider.be>
Sender: linux-kernel-owner@vger.kernel.org
To: Geert Uytterhoeven <geert+renesas@glider.be>, Matthew Wilcox <willy@linux.intel.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, Paul Bolle <pebolle@tiscali.nl>, linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>
List-Id: linux-arch.vger.kernel.org

On 07/13/2015 12:52 PM, Geert Uytterhoeven wrote:
> From: Arnd Bergmann <arnd@arndb.de>
> 
> The DAX implementation relies on the architecture to provide a working
> copy_user_page() function, as reported by Michael Ellerman's kisskb
> build bot:
> 
> fs/dax.c: error: implicit declaration of function 'copy_user_page' [-Werror=implicit-function-declaration]:  => 266:2
> 

static int copy_user_bh(struct page *to, struct buffer_head *bh,
			unsigned blkbits, unsigned long vaddr)
{
	void *vfrom, *vto;
	if (dax_get_addr(bh, &vfrom, blkbits) < 0)
		return -EIO;
	vto = kmap_atomic(to);
	copy_user_page(vto, vfrom, vaddr, to);
	kunmap_atomic(vto);
	return 0;
}

I do not understand why we need to call copy_user_page here at all?
the destination is kmap_atomic() so it must be there right? also the
destination is the cow-to page so surly it is not yet mapped to user-space
mapping.

the from is pmem which is just there.

From what I understand copy_user_page means:
    On these ARCHs that each user-mapping has its own VM cache, please invalidate
    the other VM caches.
Like on arm64 (arch/arm64/mm/copypage.c):
	copy_page(kto, kfrom);
	__flush_dcache_area(kto, PAGE_SIZE);

So what I do not understand is why copy_user_page does not have a default
implementation for those ARCHs that don't override it.

But again I think the above copy_user_page use is not at all needed.

And of course what do I know?

Thanks
Boaz

> We already have a list of architectures that are known to be incompatible,
> but the list is missing ARC and SH at the moment. Further, blackfin and
> c6x also lack support for this function, but are already excluded because
> they do not support MMU-based kernels.
> 
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> Reported-by: Geert Uytterhoeven <geert@linux-m68k.org>
> [Geert: s/SH/SUPERH/, as reported by Paul Bolle <pebolle@tiscali.nl>]
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
> ---
>  fs/Kconfig | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/fs/Kconfig b/fs/Kconfig
> index 011f43365d7b1e53..53326a50a3ce3830 100644
> --- a/fs/Kconfig
> +++ b/fs/Kconfig
> @@ -37,7 +37,7 @@ source "fs/f2fs/Kconfig"
>  config FS_DAX
>  	bool "Direct Access (DAX) support"
>  	depends on MMU
> -	depends on !(ARM || MIPS || SPARC)
> +	depends on !(ARC || ARM || MIPS || SPARC || SUPERH)
>  	help
>  	  Direct Access (DAX) can be used on memory-backed block devices.
>  	  If the block device supports DAX and the filesystem supports DAX,
> 
