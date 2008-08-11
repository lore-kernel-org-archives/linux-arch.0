From: Arnd Bergmann <arnd@arndb.de>
Subject: RFC: killing ksyms.c
Date: Mon, 11 Aug 2008 16:06:43 +0200
Message-ID: <200808111606.44103.arnd@arndb.de>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.126.177]:64040 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754750AbYHKOjj (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Mon, 11 Aug 2008 10:39:39 -0400
Content-Disposition: inline
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: linux-kernel <linux-kernel@vger.kernel.org>
Cc: linux-arch@vger.kernel.org, Matthew Wilcox <matthew@wil.cx>, David Woodhouse <dwmw2@infradead.org>, Al Viro <viro@zeniv.linux.org.uk>, Rusty Russell <rusty@rustcorp.com.au>

I saw this conversation on IRC when I came back to my screen, and
managed to dig out an older patch of mine:

[19:03:13] <willy> at some point we really need to forbid that
[19:03:28] <willy> bit hard at this point with things like memcpy()
[19:04:36] <willy> could do it with a script of some kind and
           either a whitelist of filenames (arch/*/kernel/ksyms.c
           can export anything) or of functions (anywhere can
           EXPORT_SYMBOL(memcpy)).
[Sun Aug 10 2008] [19:07:35] <viro> I suspect that we really want
           to teach *.S how to do exports
[Sun Aug 10 2008] [19:07:58] <viro> and kill ksyms.c
[Sun Aug 10 2008] [19:12:47] <dwmw2_gone> if we do the -fwhole-program
           --combine thing we'll make it hard anyway

I compile-tested this on powerpc, 32 and 64 bit, and it should be usable as
an example for other architectures.
The idea is to provide an EXPORT_SYMBOL macro for assembly that
behaves in the same way as the C version, and then export every
symbol from the file that defines it.

I'm not sure if the macro I used is actually correct or portable across
all supported architectures, so I hope to get some insight about this
from linux-arch. It does not do genksyms versioned symbol generation
from assembly, but that should be fine since they tend to be really
stable.

	Arnd <><
