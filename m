From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH] Remove #ifdef CONFIG_64BIT from all asm-generic/fcntl.h
Date: Mon, 07 Sep 2015 15:16:37 +0200
Message-ID: <17166105.3lntxUsXFt@wuerfel>
References: <1441152610-22566-1-git-send-email-palmer@dabbelt.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mout.kundenserver.de ([212.227.126.131]:54418 "EHLO
	mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750873AbbIGNQj (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Mon, 7 Sep 2015 09:16:39 -0400
In-Reply-To: <1441152610-22566-1-git-send-email-palmer@dabbelt.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Palmer Dabbelt <palmer@dabbelt.com>
Cc: linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org

On Tuesday 01 September 2015 17:10:10 Palmer Dabbelt wrote:
> From: Palmer Dabbelt <palmer.dabbelt@eecs.berkeley.edu>
> 
> When working on the RISC-V port I noticed that F_SETLK64 was being
> defined on our 64-bit platform, despite our port being so new that
> we've only ever had the 64-bit file ops.  Since there's not compat
> layer for these, this causes fcntl to bail out.
> 
> It turns out that one of the ways in with F_SETLK64 was being defined
> (there's some more in glibc, but that's a whole different story... :))
> is the result of CONFIG_64BIT showing up in this user-visible header.
> <asm-generic/bitsperlong.h> confirms this isn't sane, so I replaced it
> with a __BITS_PER_LONG check.
> 
> I went ahead and grep'd for any more of these (with
> headers_install_all), and this was the only one I found.
> 
> Signed-off-by: Palmer Dabbelt <palmer.dabbelt@eecs.berkeley.edu>
> Reviewed-by: Andrew Waterman <waterman@eecs.berkeley.edu>
> Reviewed-by: Albert Ou <aou@eecs.berkeley.edu>

Looks good to me. Are you planning to submit the RISC-V port upstream
any time soon? If so, just keep the patch in your tree and add my

Acked-by: Arnd Bergmann <arnd@arndb.de>

However, I did see a lot of similar bugs now that you point me to it:

$  grep -r \\\<CONFIG obj-tmp/usr/include/
obj-tmp/usr/include/asm-generic/fcntl.h:#ifndef CONFIG_64BIT
obj-tmp/usr/include/asm-generic/mman-common.h:#ifdef CONFIG_MMAP_ALLOW_UNINITIALIZED
obj-tmp/usr/include/asm-generic/unistd.h:#ifdef CONFIG_MMU
obj-tmp/usr/include/asm-generic/unistd.h:#endif /* CONFIG_MMU */
obj-tmp/usr/include/linux/atmdev.h:#ifdef CONFIG_COMPAT
obj-tmp/usr/include/linux/elfcore.h:#ifdef CONFIG_BINFMT_ELF_FDPIC
obj-tmp/usr/include/linux/eventpoll.h:#ifdef CONFIG_PM_SLEEP
obj-tmp/usr/include/linux/fb.h:#ifdef CONFIG_FB_BACKLIGHT
obj-tmp/usr/include/linux/flat.h:#ifdef CONFIG_BINFMT_SHARED_FLAT
obj-tmp/usr/include/linux/hw_breakpoint.h:#ifdef CONFIG_HAVE_MIXED_BREAKPOINTS_REGS
obj-tmp/usr/include/linux/pktcdvd.h:#if defined(CONFIG_CDROM_PKTCDVD_WCACHE)
obj-tmp/usr/include/linux/raw.h:#define MAX_RAW_MINORS CONFIG_MAX_RAW_DEVS
obj-tmp/usr/include/asm/ptrace.h:#ifdef CONFIG_CPU_ENDIAN_BE8

These all have the same problem, and we should fix them, as well as
(probably) adding an automated check to scripts/headers_install.sh.

	Arnd
