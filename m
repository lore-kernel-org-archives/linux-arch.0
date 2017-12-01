From: Tom Lendacky <thomas.lendacky@amd.com>
Subject: Re: 21729f81ce ("x86/mm: Provide general kernel support for memory
 encryption"): BUG: kernel reboot-without-warning in early-boot stage, last
 printk: early console in setup code
Date: Fri, 1 Dec 2017 16:31:08 -0600
Message-ID: <8cb0e1d1-3356-5d49-5feb-ac67313cf24d@amd.com>
References: <20171125135501.4wvyns7t36fuiqa4@wfg-t540p.sh.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mail-bn3nam01on0073.outbound.protection.outlook.com ([104.47.33.73]:45563
        "EHLO NAM01-BN3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751039AbdLAWbP (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Fri, 1 Dec 2017 17:31:15 -0500
In-Reply-To: <20171125135501.4wvyns7t36fuiqa4@wfg-t540p.sh.intel.com>
Content-Language: en-US
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Fengguang Wu <fengguang.wu@intel.com>
Cc: Ingo Molnar <mingo@kernel.org>, Thomas Gleixner <tglx@linutronix.de>, Borislav Petkov <bp@suse.de>, linux-kernel@vger.kernel.org, kasan-dev@googlegroups.com, linux-arch@vger.kernel.org, LKP <lkp@01.org>, wfg@linux.intel.com

On 11/25/2017 7:55 AM, Fengguang Wu wrote:
> Greetings,
> 
> 0day kernel testing robot got the below dmesg and the first bad commit is
> 
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
> 
> commit 21729f81ce8ae76a6995681d40e16f7ce8075db4
> Author:     Tom Lendacky <thomas.lendacky@amd.com>
> AuthorDate: Mon Jul 17 16:10:07 2017 -0500
> Commit:     Ingo Molnar <mingo@kernel.org>
> CommitDate: Tue Jul 18 11:38:00 2017 +0200
> 
>       x86/mm: Provide general kernel support for memory encryption

Sorry for the delay...

This is exposed because the config has KCOV and BRANCH_TRACER enabled
which causes issues with the early boot code in mm/mem_encrypt.c.  I
tested the commit level adding the two patches that correct these issues
and the kernel was able to boot.  If staying with this config, you might
have to start the bisect at or after:

67bb8e999e0a ("x86/mm: Disable various instrumentations of mm/mem_encrypt.c and mm/tlb.c")

Thanks,
Tom

>       
>       Changes to the existing page table macros will allow the SME support to
>       be enabled in a simple fashion with minimal changes to files that use these
>       macros.  Since the memory encryption mask will now be part of the regular
>       pagetable macros, we introduce two new macros (_PAGE_TABLE_NOENC and
>       _KERNPG_TABLE_NOENC) to allow for early pagetable creation/initialization
>       without the encryption mask before SME becomes active.  Two new pgprot()
>       macros are defined to allow setting or clearing the page encryption mask.
>       
>       The FIXMAP_PAGE_NOCACHE define is introduced for use with MMIO.  SME does
>       not support encryption for MMIO areas so this define removes the encryption
>       mask from the page attribute.
>       
>       Two new macros are introduced (__sme_pa() / __sme_pa_nodebug()) to allow
>       creating a physical address with the encryption mask.  These are used when
>       working with the cr3 register so that the PGD can be encrypted. The current
>       __va() macro is updated so that the virtual address is generated based off
>       of the physical address without the encryption mask thus allowing the same
>       virtual address to be generated regardless of whether encryption is enabled
>       for that physical location or not.
>       
>       Also, an early initialization function is added for SME.  If SME is active,
>       this function:
>       
>        - Updates the early_pmd_flags so that early page faults create mappings
>          with the encryption mask.
>       
>        - Updates the __supported_pte_mask to include the encryption mask.
>       
>        - Updates the protection_map entries to include the encryption mask so
>          that user-space allocations will automatically have the encryption mask
>          applied.
>       
>       Signed-off-by: Tom Lendacky <thomas.lendacky@amd.com>
>       Reviewed-by: Thomas Gleixner <tglx@linutronix.de>
>       Reviewed-by: Borislav Petkov <bp@suse.de>
>       Cc: Alexander Potapenko <glider@google.com>
>       Cc: Andrey Ryabinin <aryabinin@virtuozzo.com>
>       Cc: Andy Lutomirski <luto@kernel.org>
>       Cc: Arnd Bergmann <arnd@arndb.de>
>       Cc: Borislav Petkov <bp@alien8.de>
>       Cc: Brijesh Singh <brijesh.singh@amd.com>
>       Cc: Dave Young <dyoung@redhat.com>
>       Cc: Dmitry Vyukov <dvyukov@google.com>
>       Cc: Jonathan Corbet <corbet@lwn.net>
>       Cc: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
>       Cc: Larry Woodman <lwoodman@redhat.com>
>       Cc: Linus Torvalds <torvalds@linux-foundation.org>
>       Cc: Matt Fleming <matt@codeblueprint.co.uk>
>       Cc: Michael S. Tsirkin <mst@redhat.com>
>       Cc: Paolo Bonzini <pbonzini@redhat.com>
>       Cc: Peter Zijlstra <peterz@infradead.org>
>       Cc: Radim Krčmář <rkrcmar@redhat.com>
>       Cc: Rik van Riel <riel@redhat.com>
>       Cc: Toshimitsu Kani <toshi.kani@hpe.com>
>       Cc: kasan-dev@googlegroups.com
>       Cc: kvm@vger.kernel.org
>       Cc: linux-arch@vger.kernel.org
>       Cc: linux-doc@vger.kernel.org
>       Cc: linux-efi@vger.kernel.org
>       Cc: linux-mm@kvack.org
>       Link: http://lkml.kernel.org/r/b36e952c4c39767ae7f0a41cf5345adf27438480.1500319216.git.thomas.lendacky@amd.com
>       Signed-off-by: Ingo Molnar <mingo@kernel.org>
> 
> fd7e315988  x86/mm: Simplify p[g4um]d_page() macros
> 21729f81ce  x86/mm: Provide general kernel support for memory encryption
> 7753ea0964  Merge tag 'kvm-4.15-2' of git://git.kernel.org/pub/scm/virt/kvm/kvm
> 6fc478f80f  Add linux-next specific files for 20171124
> +-----------------------------------------------------------------------------------------------+------------+------------+------------+---------------+
> |                                                                                               | fd7e315988 | 21729f81ce | 7753ea0964 | next-20171124 |
> +-----------------------------------------------------------------------------------------------+------------+------------+------------+---------------+
> | boot_successes                                                                                | 14         | 0          | 0          | 21            |
> | boot_failures                                                                                 | 26         | 11         | 19         | 4             |
> | WARNING:at_drivers/pci/pci-sysfs.c:#pci_mmap_resource                                         | 17         | 0          | 0          | 4             |
> | RIP:pci_mmap_resource                                                                         | 17         | 0          | 0          | 4             |
> | BUG:KASAN:slab-out-of-bounds_in_c                                                             | 5          |            |            |               |
> | WARNING:bad_unlock_balance_detected                                                           | 7          |            |            |               |
> | is_trying_to_release_lock(rcu_preempt_state)at                                                | 7          |            |            |               |
> | calltrace:SyS_setpriority                                                                     | 7          |            |            |               |
> | BUG:kernel_reboot-without-warning_in_early-boot_stage,last_printk:early_console_in_setup_code | 0          | 11         | 19         |               |
> +-----------------------------------------------------------------------------------------------+------------+------------+------------+---------------+
> 
> early console in setup code
> BUG: kernel reboot-without-warning in early-boot stage, last printk: early console in setup code
> Linux version 4.13.0-rc1-00045-g21729f8 #3
> Command line: root=/dev/ram0 hung_task_panic=1 debug apic=debug sysrq_always_enabled rcupdate.rcu_cpu_stall_timeout=100 net.ifnames=0 printk.devkmsg=on panic=-1 softlockup_panic=1 nmi_watchdog=panic oops=panic load_ramdisk=2 prompt_ramdisk=0 drbd.minor_count=8 systemd.log_level=err ignore_loglevel console=tty0 earlyprintk=ttyS0,115200 console=ttyS0,115200 vga=normal rw link=/kbuild-tests/run-queue/yocto-intel12/x86_64-randconfig-s1-11211736/linux-devel:rebased-cc73fee0bae2d66594d1fa2df92bbd783aa98e04:21729f81ce8ae76a6995681d40e16f7ce8075db4:bisect-linux-49/.vmlinuz-21729f81ce8ae76a6995681d40e16f7ce8075db4-20171125131312-7:yocto-intel12-1 branch=linux-devel/rebased-cc73fee0bae2d66594d1fa2df92bbd783aa98e04 BOOT_IMAGE=/pkg/linux/x86_64-randconfig-s1-11211736/gcc-6/21729f81ce8ae76a6995681d40
 e16f7ce8075db4/vmlinuz-4.13.0-rc1-00045-g21729f8 drbd.minor_count=8
> 
> 
>                                                             # HH:MM RESULT GOOD BAD GOOD_BUT_DIRTY DIRTY_NOT_BAD
> git bisect start e7cdb60fd28b252f1c15a0e50f79a01906124915 v4.13 --
> git bisect  bad 2500e287bca1beb313aa298f2d36be1257cbb483  # 23:19  B      0     4   18   0  Merge git://git.kvack.org/~bcrl/aio-next
> git bisect  bad c0da4fa0d1a54495d6055c009ac46b76d1da2c86  # 00:43  B      0    10   24   0  Merge tag 'media/v4.14-1' of git://git.kernel.org/pub/scm/linux/kernel/git/mchehab/linux-media
> git bisect good b0c79f49c343cda8954b3322984c32f258ca4ccb  # 01:58  G     10     0    2   2  Merge branch 'x86-asm-for-linus' of git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip
> git bisect  bad c7f396f12fb3644ff325acb2384b64c8eea7a746  # 02:52  B      0     1   15   0  Merge tag 'dlm-4.14' of git://git.kernel.org/pub/scm/linux/kernel/git/teigland/linux-dlm
> git bisect  bad 9e85ae6af6e907975f68d82ff127073ec024cb05  # 03:53  B      0     4   18   0  Merge branch 'for-linus' of git://git.kernel.org/pub/scm/linux/kernel/git/s390/linux
> git bisect  bad b1b6f83ac938d176742c85757960dec2cf10e468  # 04:47  B      0     2   16   0  Merge branch 'x86-mm-for-linus' of git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip
> git bisect good f29139bf109d35967229b2caf4e6297c201cc690  # 06:02  G     11     0    6   6  Merge branch 'x86-debug-for-linus' of git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip
> git bisect good e0a195b5225e1285806622cc146dc5c3312fb392  # 06:57  G     11     0    6   6  Merge branch 'x86-spinlocks-for-linus' of git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip
> git bisect good 6c51e67b64d169419fb13318035bb442f9176612  # 07:47  G     11     0   10  10  Merge branch 'x86-syscall-for-linus' of git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip
> git bisect good 5f82e71a001d14824a7728ad9e49f6aea420f161  # 08:33  G     11     0    3   3  Merge branch 'locking-core-for-linus' of git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip
> git bisect  bad f655e6e6b992a2fb0d0334db2620607b98df39e7  # 09:12  B      0     4   18   0  x86/cpu/AMD: Make the microcode level available earlier in the boot
> git bisect good fd7e315988b784509ba3f1b42f539bd0b1fca9bb  # 10:01  G     11     0    8   8  x86/mm: Simplify p[g4um]d_page() macros
> git bisect  bad f99afd08a45fbbd9ce35a7624ffd1d850a1906c0  # 11:09  B      0    11   25   0  efi: Update efi_mem_type() to return an error rather than 0
> git bisect  bad 7f8b7e7f4ccbbd1fb8badddfabd28c955aea87b4  # 12:01  B      0    11   25   0  x86/mm: Add support for early encryption/decryption of memory
> git bisect  bad eef9c4abe77f55b1600f59d8ac5f1d953e2f5384  # 12:41  B      0     3   17   0  x86/mm: Add SME support for read_cr3_pa()
> git bisect  bad 21729f81ce8ae76a6995681d40e16f7ce8075db4  # 13:17  B      0     3   17   0  x86/mm: Provide general kernel support for memory encryption
> # first bad commit: [21729f81ce8ae76a6995681d40e16f7ce8075db4] x86/mm: Provide general kernel support for memory encryption
> git bisect good fd7e315988b784509ba3f1b42f539bd0b1fca9bb  # 14:34  G     32     0   18  26  x86/mm: Simplify p[g4um]d_page() macros
> # extra tests on HEAD of linux-devel/rebased-cc73fee0bae2d66594d1fa2df92bbd783aa98e04
> git bisect  bad c6633fb7bfbc4d02255fb1ab79dc84b2eda89620  # 14:35  B      0   444  458   0  ipc: msg: Make msg_queue timestamps y2038 safe
> # extra tests on tree/branch linus/master
> git bisect  bad 7753ea09640807104c8e353f6d5dc47ee55307cf  # 15:19  B      0     5   19   0  Merge tag 'kvm-4.15-2' of git://git.kernel.org/pub/scm/virt/kvm/kvm
> # extra tests on tree/branch linux-next/master
> git bisect good 6fc478f80f6809cc4b1a4230f47a62d3b7378dc0  # 16:20  G     11     0    4   4  Add linux-next specific files for 20171124
> 
> ---
> 0-DAY kernel test infrastructure                Open Source Technology Center
> https://lists.01.org/pipermail/lkp                          Intel Corporation
> 
