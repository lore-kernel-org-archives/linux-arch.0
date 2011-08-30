Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from dalsmrelay2.nai.com ([205.227.136.216]:53330 "EHLO
	dalsmrelay2.nai.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753835Ab1HaACy (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Tue, 30 Aug 2011 20:02:54 -0400
Message-ID: <4E5D77CE.7080904@snapgear.com>
Date: Wed, 31 Aug 2011 09:52:46 +1000
From: Greg Ungerer <gerg@snapgear.com>
MIME-Version: 1.0
Subject: Re: [PATCH] bitops: Move find_next_bit.o from lib-y to obj-y
References: <alpine.DEB.2.00.1108301427170.10125@ayla.of.borg>
In-Reply-To: <alpine.DEB.2.00.1108301427170.10125@ayla.of.borg>
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Akinobu Mita <akinobu.mita@gmail.com>, Greg Ungerer <gerg@uclinux.org>, Andrew Morton <akpm@linux-foundation.org>, Linus Torvalds <torvalds@linux-foundation.org>, Linux Kernel Development <linux-kernel@vger.kernel.org>, linux-arch@vger.kernel.org, Linux/m68k <linux-m68k@lists.linux-m68k.org>
Message-ID: <20110830235246.u1CxZgaLwNsfj-EMcwV9tGASnfm_LcswxC-N8T8ciH4@z>

Hi Geert,

On 30/08/11 23:17, Geert Uytterhoeven wrote:
> If there are no builtin users of find_next_bit_le() and
> find_next_zero_bit_le(), these functions are not present in the kernel
> image, causing m68k allmodconfig to fail with:
>
> ERROR: "find_next_zero_bit_le" [fs/ufs/ufs.ko] undefined!
> ERROR: "find_next_bit_le" [fs/udf/udf.ko] undefined!
> ERROR: "find_next_zero_bit_le" [fs/reiserfs/reiserfs.ko] undefined!
> ERROR: "find_next_bit_le" [fs/ocfs2/ocfs2.ko] undefined!
> ERROR: "find_next_zero_bit_le" [fs/ocfs2/ocfs2.ko] undefined!
> ERROR: "find_next_zero_bit_le" [fs/nilfs2/nilfs2.ko] undefined!
> ERROR: "find_next_bit_le" [fs/ext4/ext4.ko] undefined!
> ERROR: "find_next_zero_bit_le" [fs/ext4/ext4.ko] undefined!
> ERROR: "find_next_zero_bit_le" [fs/ext3/ext3.ko] undefined!
> ERROR: "find_next_zero_bit_le" [fs/ext2/ext2.ko] undefined!
> ERROR: "find_next_zero_bit_le" [drivers/media/rc/ite-cir.ko] undefined!
> ERROR: "find_next_bit_le" [drivers/media/rc/ite-cir.ko] undefined!
> ERROR: "find_next_zero_bit_le" [drivers/md/dm-log.ko] undefined!
> ERROR: "find_next_bit_le" [drivers/block/drbd/drbd.ko] undefined!
> ERROR: "find_next_zero_bit_le" [drivers/block/drbd/drbd.ko] undefined!
>
> This started to happen after commit 171d809df1896c1022f9778cd2788be6c255a7dc
> ("m68k: merge mmu and non-mmu bitops.h"), as m68k had its own inline
> versions before.
>
> commit 63e424c84429903c92a0f1e9654c31ccaf6694d0 ("arch: remove
> CONFIG_GENERIC_FIND_{NEXT_BIT,BIT_LE,LAST_BIT}") added find_last_bit.o to
> obj-y (so it's always included), but find_next_bit.o to lib-y (so it gets
> removed by the linker if there are no builtin users).
>
> Signed-off-by: Geert Uytterhoeven<geert@linux-m68k.org>

Yep, looks good to me.

Acked-by: Greg Ungerer <gerg@uclinux.org>

Regards
Greg



> ---
> Sorry, I didn't notice it before, as m68k allmodconfig has been suffering
> from too many build breakages (for which patches are available) lately.
>
> Does it happen elsewhere, too?
>
>   lib/Makefile |    4 ++--
>   1 files changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/lib/Makefile b/lib/Makefile
> index d5d175c..3f5bc6d 100644
> --- a/lib/Makefile
> +++ b/lib/Makefile
> @@ -12,7 +12,7 @@ lib-y := ctype.o string.o vsprintf.o cmdline.o \
>   	 idr.o int_sqrt.o extable.o prio_tree.o \
>   	 sha1.o md5.o irq_regs.o reciprocal_div.o argv_split.o \
>   	 proportions.o prio_heap.o ratelimit.o show_mem.o \
> -	 is_single_threaded.o plist.o decompress.o find_next_bit.o
> +	 is_single_threaded.o plist.o decompress.o
>
>   lib-$(CONFIG_MMU) += ioremap.o
>   lib-$(CONFIG_SMP) += cpumask.o
> @@ -22,7 +22,7 @@ lib-y	+= kobject.o kref.o klist.o
>   obj-y += bcd.o div64.o sort.o parser.o halfmd4.o debug_locks.o random32.o \
>   	 bust_spinlocks.o hexdump.o kasprintf.o bitmap.o scatterlist.o \
>   	 string_helpers.o gcd.o lcm.o list_sort.o uuid.o flex_array.o \
> -	 bsearch.o find_last_bit.o
> +	 bsearch.o find_last_bit.o find_next_bit.o
>   obj-y += kstrtox.o
>   obj-$(CONFIG_TEST_KSTRTOX) += test-kstrtox.o
>


-- 
------------------------------------------------------------------------
Greg Ungerer  --  Principal Engineer        EMAIL:     gerg@snapgear.com
SnapGear Group, McAfee                      PHONE:       +61 7 3435 2888
8 Gardner Close                             FAX:         +61 7 3217 5323
Milton, QLD, 4064, Australia                WEB: http://www.SnapGear.com
