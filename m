From: Ralf Baechle <ralf@linux-mips.org>
Subject: Re: sys_kcmp (was: Re: [PATCH 1/2] ARM: add finit_module syscall to
 ARM)
Date: Sat, 22 Sep 2012 15:38:47 +0200
Message-ID: <20120922133847.GC20003@linux-mips.org>
References: <CAMuHMdXVKvaCoJTRb4O+Z4GuifzTEopdcRfRHBahQmpuX+Xi0w@mail.gmail.com>
 <20120922114549.GA11610@moon>
 <20120922132046.GA4260@flint.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from eddie.linux-mips.org ([78.24.191.182]:60642 "EHLO
	cvs.linux-mips.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752167Ab2IVNjB (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Sat, 22 Sep 2012 09:39:01 -0400
Received: from localhost.localdomain ([127.0.0.1]:58692 "EHLO linux-mips.org"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S1903350Ab2IVNi7 (ORCPT <rfc822;linux-arch@vger.kernel.org>
        + 1 other); Sat, 22 Sep 2012 15:38:59 +0200
Content-Disposition: inline
In-Reply-To: <20120922132046.GA4260@flint.arm.linux.org.uk>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Cyrill Gorcunov <gorcunov@openvz.org>, Andrew Morton <akpm@linux-foundation.org>, Geert Uytterhoeven <geert@linux-m68k.org>, Kees Cook <keescook@chromium.org>, linux-kernel@vger.kernel.org, Linux-Arch <linux-arch@vger.kernel.org>, Heiko Carstens <heiko.carstens@de.ibm.com>

On Sat, Sep 22, 2012 at 02:20:46PM +0100, Russell King wrote:

> 2. There allegedly exists a patch to remove x86isms from sys_kcmp -
>    allegedly also in akpm's tree.  However, I've looked through the code in
>    mainline, and nothing stands out.  Ralf Beachle also said yesterday that
>    he has looked through from the MIPS PoV and also can't see any x86isms,
>    so we're both thinking that it should merely have the x86 dependency
>    removed.
> 
> 3. Until the x86 dependency is gone (that depends on what akpm proposes to
>    do with the patches he's allegedly sitting on), non-x86 arches can only
>    reserve the syscall, and add an IGNORE for it.

There is a weak definition provided in kernel/sys_ni.c so it actually can
be properly wired up in preparation for the day when the dependency in
Kconfig gets fixed.

> It would be good to at least get checksyscalls.sh fixed so arch maintainers
> get their warnings for new syscalls back.

Indeed.  That script has become just too important.

  Ralf
