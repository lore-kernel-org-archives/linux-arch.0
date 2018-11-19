From: Rob Landley <rob@landley.net>
Subject: Re: [PATCH v3 0/3] sh: system call table generation support
Date: Sun, 18 Nov 2018 23:25:21 -0600
Message-ID: <0b9aaa2f-9eda-82f1-8d52-b537a8c0c190@landley.net>
References: <1542169930-24118-1-git-send-email-firoz.khan@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1542169930-24118-1-git-send-email-firoz.khan@linaro.org>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Firoz Khan <firoz.khan@linaro.org>, linux-sh@vger.kernel.org, Yoshinori Sato <ysato@users.sourceforge.jp>, Rich Felker <dalias@libc.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Philippe Ombredanne <pombredanne@nexb.com>, Thomas Gleixner <tglx@linutronix.de>, Kate Stewart <kstewart@linuxfoundation.org>
Cc: y2038@lists.linaro.org, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, arnd@arndb.de, deepa.kernel@gmail.com, marcin.juszkiewicz@linaro.org
List-Id: linux-arch.vger.kernel.org

On 11/13/18 10:32 PM, Firoz Khan wrote:
> The purpose of this patch series is, we can easily
> add/modify/delete system call table support by cha-
> nging entry in syscall.tbl file instead of manually
> changing many files. The other goal is to unify the 
> system call table generation support implementation 
> across all the architectures. 

I applied the patch in https://github.com/landley/mkroot and the result booted
under qemu-system-sh4, seems to work fine. Network's fine, it can read a block
device, etc.

Acked-and-or-tested-by: Rob Landley <rob@landley.net>

I assume that this is just git du jour and not your patch:

WARNING: CPU: 0 PID: 1 at mm/slub.c:2448 ___slab_alloc.constprop.34+0x196/0x288

CPU: 0 PID: 1 Comm: swapper Not tainted 4.20.0-rc3 #1
PC is at ___slab_alloc.constprop.34+0x196/0x288
PR is at __slab_alloc.constprop.33+0x2a/0x4c
PC  : 8c09d09a SP  : 8f829ea0 SR  : 400080f0
TEA : c0001240
R0  : 8c09cf04 R1  : 8c01cbec R2  : 00000000 R3  : 00000000
R4  : 8f8020a0 R5  : 006080c0 R6  : 8c01d74a R7  : 8fff5180
R8  : 8c011a40 R9  : 8fff5180 R10 : 8f8020a0 R11 : 00008000
R12 : 8c01d74a R13 : 006080c0 R14 : 8f80211c
MACH: 0000008e MACL: 0ae4849d GBR : 00000000 PR  : 8c09d1b6

Call trace:
 [<(ptrval)>] arch_local_irq_restore+0x0/0x24
 [<(ptrval)>] __slab_alloc.constprop.33+0x2a/0x4c
 [<(ptrval)>] arch_local_save_flags+0x0/0x8
 [<(ptrval)>] arch_local_irq_restore+0x0/0x24
 [<(ptrval)>] mm_init.isra.6+0xca/0x120
 [<(ptrval)>] kmem_cache_alloc+0x9a/0xf4
 [<(ptrval)>] mm_init.isra.6+0xca/0x120
 [<(ptrval)>] arch_local_irq_restore+0x0/0x24
 [<(ptrval)>] kmem_cache_alloc+0x9a/0xf4
 [<(ptrval)>] mm_alloc+0xe/0x48
 [<(ptrval)>] mm_init.isra.6+0xca/0x120
 [<(ptrval)>] memset+0x0/0x8c
 [<(ptrval)>] __do_execve_file+0x1de/0x574
 [<(ptrval)>] getname_kernel+0x1e/0xc8
 [<(ptrval)>] kmem_cache_alloc+0x0/0xf4
 [<(ptrval)>] do_execve+0x16/0x24
 [<(ptrval)>] arch_local_save_flags+0x0/0x8
 [<(ptrval)>] arch_local_irq_restore+0x0/0x24
 [<(ptrval)>] printk+0x0/0x24
 [<(ptrval)>] kernel_init+0x34/0xec
 [<(ptrval)>] ret_from_kernel_thread+0xc/0x14
 [<(ptrval)>] schedule_tail+0x0/0x58
 [<(ptrval)>] kernel_init+0x0/0xec

---[ end trace 6e84d1e05051e55d ]---
