Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from palinux.external.hp.com ([192.25.206.14]:40853 "EHLO
	mail.parisc-linux.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751334AbXFYLro (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Mon, 25 Jun 2007 07:47:44 -0400
Date: Mon, 25 Jun 2007 05:47:42 -0600
From: Matthew Wilcox <matthew@wil.cx>
Subject: Re: Introduce fixed sys_sync_file_range2() syscall, implement on PowerPC and ARM
Message-ID: <20070625114742.GG22063@parisc-linux.org>
References: <1182761357.12109.14.camel@pmac.infradead.org> <20070625021145.b84ea186.akpm@linux-foundation.org> <20070625103535.GF22063@parisc-linux.org> <20070625110907.GA23438@flint.arm.linux.org.uk> <1182771454.12109.71.camel@pmac.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1182771454.12109.71.camel@pmac.infradead.org>
Sender: linux-arch-owner@vger.kernel.org
To: David Woodhouse <dwmw2@infradead.org>
Cc: Russell King <rmk@arm.linux.org.uk>, Andrew Morton <akpm@linux-foundation.org>, torvalds@linux-foundation.org, paulus@samba.org, linux-arch@vger.kernel.org, drepper@redhat.com
List-ID: <linux-arch.vger.kernel.org>

On Mon, Jun 25, 2007 at 12:37:34PM +0100, David Woodhouse wrote:
> - Some architectures must align 64-bit integers into an aligned
>   pair of registers. A slot may be wasted for padding.
> - S390 may not have a 64-bit integer in slots 5/6.

Uhm, doesn't sys_sync_file_range2 break that?

+asmlinkage long compat_sys_sync_file_range2(int fd, unsigned int flags,
+                                  unsigned offset_hi, unsigned offset_lo,
+                                  unsigned nbytes_hi, unsigned nbytes_lo)

How about:

asmlinkage long compat_sys_sync_file_range2(unsigned offset_hi,
		unsigned offset_lo, unsigned nbytes_hi, unsigned nbytes_lo, 
		int fd, unsigned int flags)

Also, you might want to put something in the syscall file about signed
vs unsigned arguments and how they behave with 32-on-64 systems.
