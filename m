From: Nathan Chancellor <natechancellor@gmail.com>
Subject: Re: [PATCH 1/4] arm64: stop using <asm/compat.h> directly
Date: Thu, 30 Jul 2020 10:34:37 -0700
Message-ID: <20200730173437.GA1172439@ubuntu-n2-xlarge-x86>
References: <20200726160401.311569-1-hch@lst.de>
 <20200726160401.311569-2-hch@lst.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20200726160401.311569-2-hch@lst.de>
Sender: linux-kernel-owner@vger.kernel.org
To: Christoph Hellwig <hch@lst.de>
Cc: x86@kernel.org, Jan Kara <jack@suse.com>, linux-arm-kernel@lists.infradead.org, linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, linux-api@vger.kernel.org, linux-arch@vger.kernel.org
List-Id: linux-arch.vger.kernel.org

On Sun, Jul 26, 2020 at 06:03:58PM +0200, Christoph Hellwig wrote:
> Always use <linux/compat.h> so that we can move more declarations to
> common code.  In two of the three cases the asm include was in addition
> to an existing one for <linux/compat.h> anyway.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>  arch/arm64/include/asm/stat.h | 2 +-
>  arch/arm64/kernel/process.c   | 1 -
>  arch/arm64/kernel/ptrace.c    | 1 -
>  3 files changed, 1 insertion(+), 3 deletions(-)
> 
> diff --git a/arch/arm64/include/asm/stat.h b/arch/arm64/include/asm/stat.h
> index 3b4a62f5aeb0c3..1b5ac1ef5d04cc 100644
> --- a/arch/arm64/include/asm/stat.h
> +++ b/arch/arm64/include/asm/stat.h
> @@ -10,7 +10,7 @@
>  #ifdef CONFIG_COMPAT
>  
>  #include <linux/time.h>
> -#include <asm/compat.h>
> +#include <linux/compat.h>

This breaks arm64 defconfig:

$ make -skj"$(nproc)" ARCH=arm64 CROSS_COMPILE=aarch64-linux- distclean defconfig init/main.o
In file included from ./include/linux/compat.h:17,
                 from ./arch/arm64/include/asm/stat.h:13,
                 from ./include/linux/stat.h:6,
                 from ./include/linux/sysfs.h:22,
                 from ./include/linux/kobject.h:20,
                 from ./include/linux/of.h:17,
                 from ./include/linux/irqdomain.h:35,
                 from ./include/linux/acpi.h:13,
                 from ./include/acpi/apei.h:9,
                 from ./include/acpi/ghes.h:5,
                 from ./include/linux/arm_sdei.h:8,
                 from arch/arm64/kernel/asm-offsets.c:10:
./include/linux/fs.h: In function 'vfs_whiteout':
./include/linux/fs.h:1736:32: error: 'S_IFCHR' undeclared (first use in this function)
 1736 |  return vfs_mknod(dir, dentry, S_IFCHR | WHITEOUT_MODE, WHITEOUT_DEV);
      |                                ^~~~~~~
./include/linux/fs.h:1736:32: note: each undeclared identifier is reported only once for each function it appears in
./include/linux/fs.h: At top level:
./include/linux/fs.h:1886:46: warning: 'struct kstat' declared inside parameter list will not be visible outside of this definition or declaration
 1886 |  int (*getattr) (const struct path *, struct kstat *, u32, unsigned int);
      |                                              ^~~~~
./include/linux/fs.h: In function '__mandatory_lock':
./include/linux/fs.h:2372:25: error: 'S_ISGID' undeclared (first use in this function); did you mean 'SIGIO'?
 2372 |  return (ino->i_mode & (S_ISGID | S_IXGRP)) == S_ISGID;
      |                         ^~~~~~~
      |                         SIGIO
./include/linux/fs.h:2372:35: error: 'S_IXGRP' undeclared (first use in this function)
 2372 |  return (ino->i_mode & (S_ISGID | S_IXGRP)) == S_ISGID;
      |                                   ^~~~~~~
...

$ git bisect log
# bad: [7b287a5c6ac518c415a258f2aa7b1ebb25c263d2] Add linux-next specific files for 20200730
# good: [d3590ebf6f91350192737dd1d1b219c05277f067] Merge tag 'audit-pr-20200729' of git://git.kernel.org/pub/scm/linux/kernel/git/pcmoore/audit
git bisect start '7b287a5c6ac518c415a258f2aa7b1ebb25c263d2' 'd3590ebf6f91350192737dd1d1b219c05277f067'
# bad: [1f1ed12be70e9eb4e05ac206c6ad6a5a31f5b921] Merge remote-tracking branch 'crypto/master'
git bisect bad 1f1ed12be70e9eb4e05ac206c6ad6a5a31f5b921
# bad: [07fad673c2f1a02440c879c34f8182b12786a735] Merge remote-tracking branch 'hid/for-next'
git bisect bad 07fad673c2f1a02440c879c34f8182b12786a735
# good: [7a77c92312546a74d3507484b256ae17bfb2cfe2] Merge remote-tracking branch 'm68knommu/for-next'
git bisect good 7a77c92312546a74d3507484b256ae17bfb2cfe2
# good: [40dd62f180e38317e744d7f82c98af31a24fd2c9] Merge remote-tracking branch 'f2fs/dev'
git bisect good 40dd62f180e38317e744d7f82c98af31a24fd2c9
# bad: [52138dfdd2192bcfc7d3bc2e79475966ee4b20c4] Merge remote-tracking branch 'printk/for-next'
git bisect bad 52138dfdd2192bcfc7d3bc2e79475966ee4b20c4
# good: [a37c3e37fa3fa1381e03d918d708f82927ddd160] Merge remote-tracking branch 'xfs/for-next'
git bisect good a37c3e37fa3fa1381e03d918d708f82927ddd160
# good: [4e523547e2bf755d40cb10e85795c2f9620ff3fb] nvme-pci: add a blank line after declarations
git bisect good 4e523547e2bf755d40cb10e85795c2f9620ff3fb
# bad: [5066741180729f7bad9401de34efda3766c3274a] Merge branches 'fixes' and 'work.quota-compat' into for-next
git bisect bad 5066741180729f7bad9401de34efda3766c3274a
# good: [4ff8a356daafaafbf90141ee7a3b8fdc18e560a8] ia64: switch to ->regset_get()
git bisect good 4ff8a356daafaafbf90141ee7a3b8fdc18e560a8
# good: [ce327e1c54119179066d6f3573a28001febc9265] regset: kill user_regset_copyout{,_zero}()
git bisect good ce327e1c54119179066d6f3573a28001febc9265
# good: [1697a322e28ba96d35953c5d824540d172546d36] [elf-fdpic] switch coredump to regsets
git bisect good 1697a322e28ba96d35953c5d824540d172546d36
# good: [259bf01c1bd1f049958496a089c4f334fe0c8a48] Merge branches 'work.misc', 'work.regset' and 'work.fdpic' into for-next
git bisect good 259bf01c1bd1f049958496a089c4f334fe0c8a48
# bad: [0a3a4497a1de8e68e809a693b549c7ec2f195301] compat: lift compat_s64 and compat_u64 to <linux/compat.h>
git bisect bad 0a3a4497a1de8e68e809a693b549c7ec2f195301
# bad: [b902bfb3f0e9d07ec9f48256e57e5c5de6108f8c] arm64: stop using <asm/compat.h> directly
git bisect bad b902bfb3f0e9d07ec9f48256e57e5c5de6108f8c
# first bad commit: [b902bfb3f0e9d07ec9f48256e57e5c5de6108f8c] arm64: stop using <asm/compat.h> directly

I assume the stat header order should be messed around with but I am not
sure what exactly that would entail to make sure that nothing else
breaks, hence just the report.

Cheers,
Nathan
