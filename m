Return-Path: <linux-arch-owner+james.bottomley=40steeleye.com-S268260AbUJOSGr@vger.kernel.org>
Received: from [213.146.154.40] ([213.146.154.40]:60384 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S268236AbUJOSGr (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Fri, 15 Oct 2004 14:06:47 -0400
Subject: Re: 4level page tables architecture porting
From: David Woodhouse <dwmw2@infradead.org>
In-Reply-To: <20041015172112.73e884d9.ak@suse.de>
References: <20041015172112.73e884d9.ak@suse.de>
Content-Type: text/plain
Message-Id: <1097863604.13633.431.camel@hades.cambridge.redhat.com>
Mime-Version: 1.0
Date: Fri, 15 Oct 2004 19:06:44 +0100
Content-Transfer-Encoding: 7bit
To: Andi Kleen <ak@suse.de>
Cc: linux-arch@vger.kernel.org, akpm@digeo.com
List-ID: <linux-arch.vger.kernel.org>

On Fri, 2004-10-15 at 17:21 +0200, Andi Kleen wrote:
> ftp://ftp.suse.com/pub/people/ak/4level/4level-2.6.9rc4-2.gz
> 
> now compiles and boots on x86-64, i386, ia64. alpha, ppc64, ppc compile too,
> but missing hardware I'm still waiting for testers for that.

ppc64 fails thus. Sorry, I'd be more helpful but I'm a little busy
trying to work out why some ppc64 machines also die on startup because
some of the initrd pages seem to be marked PG_slab by the time they get
freed.

kernel BUG in free_one_pml4 at mm/memory.c:155!
cpu 0x0: Vector: 700 (Program Check) at [c0000000023074f0]
    pc: c0000000000994d8: .clear_page_range+0x90/0x264
    lr: c0000000000a0a78: .exit_mmap+0x11c/0x230
    sp: c000000002307770
   msr: 800000000002b032
  current = 0xc0000000023014e0
  paca    = 0xc0000000003c1c80
    pid   = 15, comm = hotplug
enter ? for help
0:mon> t
[c000000002307870] c0000000000a0a78 .exit_mmap+0x11c/0x230
[c000000002307920] c00000000005794c .mmput+0xb0/0x118
[c0000000023079b0] c0000000000c0b74 .flush_old_exec+0x684/0xb08
[c000000002307aa0] c00000000001b064 .load_elf_binary+0x494/0x182c
[c000000002307c30] c0000000000c1498 .search_binary_handler+0x180/0x4b8
[c000000002307ce0] c0000000000ec5b4 .compat_do_execve+0x20c/0x378
[c000000002307d90] c00000000001f1bc .sys32_execve+0x7c/0xfc
[c000000002307e30] c000000000010000 syscall_exit+0x0/0x18
--- Exception: c01 (System Call) at 000000001001a94c
SP (ffffec10) is in userspace
0:mon>


-- 
dwmw2
