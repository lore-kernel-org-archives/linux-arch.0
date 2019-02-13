From: Mike Rapoport <rppt@linux.ibm.com>
Subject: Re: [PATCH 7/8] initramfs: proide a generic free_initrd_mem
 implementation
Date: Wed, 13 Feb 2019 20:41:40 +0200
Message-ID: <20190213184139.GC15270@rapoport-lnx>
References: <20190213174621.29297-1-hch@lst.de>
 <20190213174621.29297-8-hch@lst.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
Content-Disposition: inline
In-Reply-To: <20190213174621.29297-8-hch@lst.de>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Christoph Hellwig <hch@lst.de>
Cc: linux-arch@vger.kernel.org, Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will.deacon@arm.com>, Russell King <linux@armlinux.org.uk>, linux-kernel@vger.kernel.org, linux-mm@kvack.org, Alexander Viro <viro@zeniv.linux.org.uk>, Andrew Morton <akpm@linux-foundation.org>, Guan Xuetao <gxt@pku.edu.cn>, linux-arm-kernel@lists.infradead.org
List-Id: linux-arch.vger.kernel.org

On Wed, Feb 13, 2019 at 06:46:20PM +0100, Christoph Hellwig wrote:
> For most architectures free_initrd_mem just expands to the same
> free_reserved_area call.  Provide that as a generic implementation
> marked __weak.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>  arch/alpha/mm/init.c      | 8 --------
>  arch/arc/mm/init.c        | 7 -------
>  arch/c6x/mm/init.c        | 7 -------

csky seems to open-code free_reserved_page with the only
difference that it's also increments totalram_pages for the freed pages,
which doesn't seem correct anyway...

That said, I suppose arch/csky can be also added to the party.

>  arch/h8300/mm/init.c      | 8 --------
>  arch/m68k/mm/init.c       | 7 -------
>  arch/microblaze/mm/init.c | 7 -------
>  arch/nds32/mm/init.c      | 7 -------
>  arch/nios2/mm/init.c      | 7 -------
>  arch/openrisc/mm/init.c   | 7 -------
>  arch/parisc/mm/init.c     | 7 -------
>  arch/powerpc/mm/mem.c     | 7 -------
>  arch/sh/mm/init.c         | 7 -------
>  arch/um/kernel/mem.c      | 7 -------
>  arch/unicore32/mm/init.c  | 7 -------
>  init/initramfs.c          | 5 +++++
>  15 files changed, 5 insertions(+), 100 deletions(-)
 
...

> diff --git a/init/initramfs.c b/init/initramfs.c
> index cf8bf014873f..f3aaa58ac63d 100644
> --- a/init/initramfs.c
> +++ b/init/initramfs.c
> @@ -527,6 +527,11 @@ extern unsigned long __initramfs_size;
>  #include <linux/initrd.h>
>  #include <linux/kexec.h>
> 
> +void __weak free_initrd_mem(unsigned long start, unsigned long end)
> +{
> +	free_reserved_area((void *)start, (void *)end, -1, "initrd");

Some architectures have pr_info("Freeing initrd memory..."), I'd add it for
the generic version as well.

Another thing that I was thinking of is that x86 has all those memory
protection calls in its free_initrd_mem, maybe it'd make sense to have them
in the generic version as well?

> +}
> +
>  #ifdef CONFIG_KEXEC_CORE
>  static bool kexec_free_initrd(void)
>  {
> -- 
> 2.20.1
> 

-- 
Sincerely yours,
Mike.
