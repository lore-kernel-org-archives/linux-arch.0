From: Guenter Roeck <linux@roeck-us.net>
Subject: Re: [PATCH 1/6] syscalls: use uaccess_kernel in addr_limit_user_check
Date: Fri, 17 Jul 2020 18:38:50 -0700
Message-ID: <20200718013849.GA157764@roeck-us.net>
References: <20200714105505.935079-1-hch@lst.de>
 <20200714105505.935079-2-hch@lst.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34316 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726710AbgGRBiw (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 17 Jul 2020 21:38:52 -0400
Content-Disposition: inline
In-Reply-To: <20200714105505.935079-2-hch@lst.de>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Christoph Hellwig <hch@lst.de>
Cc: Nick Hu <nickhu@andestech.com>, Greentime Hu <green.hu@gmail.com>, Vincent Chen <deanbo422@gmail.com>, Paul Walmsley <paul.walmsley@sifive.com>, Palmer Dabbelt <palmer@dabbelt.com>, Andrew Morton <akpm@linux-foundation.org>, Linus Torvalds <torvalds@linux-foundation.org>, linux-riscv@lists.infradead.org, linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org

Hi,

On Tue, Jul 14, 2020 at 12:55:00PM +0200, Christoph Hellwig wrote:
> Use the uaccess_kernel helper instead of duplicating it.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>

This patch causes a severe hiccup with my mps2-an385 boot test.

[    8.545195] ------------[ cut here ]------------
[    8.545294] WARNING: CPU: 0 PID: 1 at ./include/linux/syscalls.h:267 addr_limit_check_failed+0x11/0x24
[    8.545376] Invalid address limit on user-mode return
[    8.545487] CPU: 0 PID: 1 Comm: init Not tainted 5.8.0-rc5-next-20200717 #1
[    8.545603] Hardware name: MPS2 (Device Tree Support)
[    8.546053] [<2100af9d>] (unwind_backtrace) from [<2100a353>] (show_stack+0xb/0xc)
[    8.546240] [<2100a353>] (show_stack) from [<2100dadb>] (__warn+0x6f/0x80)
[    8.546311] [<2100dadb>] (__warn) from [<2100db1d>] (warn_slowpath_fmt+0x31/0x60)
[    8.546383] [<2100db1d>] (warn_slowpath_fmt) from [<2100a159>] (addr_limit_check_failed+0x11/0x24)
[    8.546464] [<2100a159>] (addr_limit_check_failed) from [<210080f3>] (ret_to_user_from_irq+0xf/0x18)
[    8.546567] Exception stack(0x21427fb0 to 0x21427ff8)
[    8.546649] 7fa0:                                     00000000 00000000 00000000 00000000
[    8.546729] 7fc0: 00000000 00000000 00000000 00000000 00000000 00000000 21744f80 00000000
[    8.546800] 7fe0: 00000000 21757fa8 00000000 21700b6c 01000000 00000000
[    8.546910] ---[ end trace f1b0cd10cc3456dc ]---

This keeps happening until qemu aborts.

Reverting the patch isn't possible since segment_eq() is gone in
next-20200717.

Guenter

---
# bad: [aab7ee9f8ff0110bfcd594b33dc33748dc1baf46] Add linux-next specific files for 20200717
# good: [11ba468877bb23f28956a35e896356252d63c983] Linux 5.8-rc5
git bisect start 'HEAD' 'v5.8-rc5'
# good: [4d55a7a1298d197755c1a0f4512f56917e938a83] Merge remote-tracking branch 'crypto/master'
git bisect good 4d55a7a1298d197755c1a0f4512f56917e938a83
# good: [e63bf5dcce255302e355cb2277a3a39c83752c92] Merge remote-tracking branch 'devicetree/for-next'
git bisect good e63bf5dcce255302e355cb2277a3a39c83752c92
# good: [94d932ec3afb923efd8c736974f8316413175a5b] Merge remote-tracking branch 'thunderbolt/next'
git bisect good 94d932ec3afb923efd8c736974f8316413175a5b
# good: [5ddd2e0dbe8fceb80b0b36bd38a32217be7a04a5] Merge remote-tracking branch 'livepatching/for-next'
git bisect good 5ddd2e0dbe8fceb80b0b36bd38a32217be7a04a5
# bad: [40346f79983caf46fb92f779b0353422d43580a9] ipc/shm.c: Remove the superfluous break
git bisect bad 40346f79983caf46fb92f779b0353422d43580a9
# good: [0b917599517f71ddef5f7274a8199a33cecd49b2] kasan: update required compiler versions in documentation
git bisect good 0b917599517f71ddef5f7274a8199a33cecd49b2
# good: [701571ae06641cc0632d113a6d25f54ce651e723] mm,hwpoison: rework soft offline for free pages
git bisect good 701571ae06641cc0632d113a6d25f54ce651e723
# bad: [1c21deffe923b068d2d297c248845ec93531d1bf] lib/test_bits.c: add tests of GENMASK
git bisect bad 1c21deffe923b068d2d297c248845ec93531d1bf
# bad: [9549375184b2cb4f63fa7917665acf9c44114499] uaccess: add force_uaccess_{begin,end} helpers
git bisect bad 9549375184b2cb4f63fa7917665acf9c44114499
# good: [233d009c15719e43c53b73296144664e0bd59a2e] mm/memory_hotplug: introduce default dummy memory_add_physaddr_to_nid()
git bisect good 233d009c15719e43c53b73296144664e0bd59a2e
# good: [42889ca325dd735ce964838cff81a444637d9d01] mm: drop duplicated words in <linux/mm.h>
git bisect good 42889ca325dd735ce964838cff81a444637d9d01
# bad: [3b17e98704eedeeff41672b2f64cef1bbefbb8b2] nds32: use uaccess_kernel in show_regs
git bisect bad 3b17e98704eedeeff41672b2f64cef1bbefbb8b2
# bad: [02dc30b876b111276fe7d83d492ddfc2b39b80e3] syscalls: use uaccess_kernel in addr_limit_user_check
git bisect bad 02dc30b876b111276fe7d83d492ddfc2b39b80e3
# first bad commit: [02dc30b876b111276fe7d83d492ddfc2b39b80e3] syscalls: use uaccess_kernel in addr_limit_user_check
