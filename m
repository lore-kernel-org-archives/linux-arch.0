From: Guenter Roeck <linux@roeck-us.net>
Subject: Re: [PATCH 2/2] sh: generate uapi header and syscall table header
 files
Date: Thu, 10 Jan 2019 15:54:28 -0800
Message-ID: <20190110235428.GA10016@roeck-us.net>
References: <1546443445-21075-1-git-send-email-firoz.khan@linaro.org>
 <1546443445-21075-3-git-send-email-firoz.khan@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1546443445-21075-3-git-send-email-firoz.khan@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Firoz Khan <firoz.khan@linaro.org>
Cc: Yoshinori Sato <ysato@users.sourceforge.jp>, Rich Felker <dalias@libc.org>, Andrew Morton <akpm@linux-foundation.org>, Simon Horman <horms+renesas@verge.net.au>, Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>, linux-sh@vger.kernel.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Philippe Ombredanne <pombredanne@nexb.com>, Thomas Gleixner <tglx@linutronix.de>, Kate Stewart <kstewart@linuxfoundation.org>, y2038@lists.linaro.org, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, arnd@arndb.de, deepa.kernel@gmail.com, marcin.juszkiewicz@linaro.org
List-Id: linux-arch.vger.kernel.org

On Wed, Jan 02, 2019 at 09:07:25PM +0530, Firoz Khan wrote:
> Unified system call table generation script must be run to
> generate unistd_32.h and syscall_table.h files. This patch
> will have changes which will invokes the script.
> 
> This patch will generate unistd_32.h and syscall_table.h
> files by the syscall table generation script invoked by
> sh/Makefile and the generated files against the removed
> files must be identical.
> 
> The generated uapi header file will be included in uapi/-
> asm/unistd.h and generated system call table header file
> will be included by kernel/syscall_32.S file.
> 
> Signed-off-by: Firoz Khan <firoz.khan@linaro.org>

Have you tested this patch ?

Building sh:defconfig ... failed
--------------
Error log:
make[2]: *** No rule to make target
'/opt/buildbot/slave/next-next/build/scripts/syscalltbl.sh',
	needed by 'arch/sh/include/generated/asm/syscall_table.h'.  Stop.

This affects all 'sh' builds. Not surprisingly, reverting the patch fixes
the problem.

Guenter

---
# bad: [6cab33afc3dd17bd9922c99a828f5680b4667cd9] Add linux-next specific files for 20190110
# good: [bfeffd155283772bbe78c6a05dec7c0128ee500c] Linux 5.0-rc1
git bisect start 'HEAD' 'v5.0-rc1'
# good: [45daa05b201d684d42a186970731a9e39f75beb7] Merge remote-tracking branch 'mtd/mtd/next'
git bisect good 45daa05b201d684d42a186970731a9e39f75beb7
# good: [62d9bf7cbfd16d41f30de4439d7349c70d99923b] Merge remote-tracking branch 'tip/auto-latest'
git bisect good 62d9bf7cbfd16d41f30de4439d7349c70d99923b
# good: [cff8f6ab40ac1f5681ba37a663382d0c5d1b07d1] Merge remote-tracking branch 'vhost/linux-next'
git bisect good cff8f6ab40ac1f5681ba37a663382d0c5d1b07d1
# bad: [ed7209d69de4c01d589b030c34412d093aac3801] mm: initialize MAX_ORDER_NR_PAGES at a time instead of doing larger sections
git bisect bad ed7209d69de4c01d589b030c34412d093aac3801
# bad: [8fd9cdac0385dcec3534d79bf6ad29e33a6cfe1f] vmalloc: add test driver to analyse vmalloc allocator
git bisect bad 8fd9cdac0385dcec3534d79bf6ad29e33a6cfe1f
# good: [e804aa1e321d349514c121c3bff66dee1cff3dd5] sh: remove nargs from __SYSCALL
git bisect good e804aa1e321d349514c121c3bff66dee1cff3dd5
# bad: [7f3303ead0bd6fc02ca0d5a2e6a3ce8f653afbea] mm: reuse only-pte-mapped KSM page in do_wp_page()
git bisect bad 7f3303ead0bd6fc02ca0d5a2e6a3ce8f653afbea
# bad: [7dc035ee0653362ae11187152ac5942e230fb523] fs/file.c: initialize init_files.resize_wait
git bisect bad 7dc035ee0653362ae11187152ac5942e230fb523
# bad: [539eec285bc3a61570493f08fca6d84e09e77d3c] ocfs2: clear zero in unaligned direct IO
git bisect bad 539eec285bc3a61570493f08fca6d84e09e77d3c
# bad: [63ef58895f79a7dea083dff346a6504b87e1a7dc] lib/debugobjects.c: move printk out of db lock critical sections
git bisect bad 63ef58895f79a7dea083dff346a6504b87e1a7dc
# bad: [60a47bb1b736b2be71ff6f256693595af5c707e8] sh: generate uapi header and syscall table header files
git bisect bad 60a47bb1b736b2be71ff6f256693595af5c707e8
# first bad commit: [60a47bb1b736b2be71ff6f256693595af5c707e8] sh: generate uapi header and syscall table header files
