From: Arnd Bergmann <arnd@arndb.de>
Subject: [PATCH v2 0/6] simplify rtc-generic driver
Date: Tue, 26 Apr 2016 23:52:25 +0200
Message-ID: <1461707551-1337971-1-git-send-email-arnd@arndb.de>
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mout.kundenserver.de ([212.227.17.24]:50320 "EHLO
	mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752483AbcDZVxO (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Tue, 26 Apr 2016 17:53:14 -0400
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Alexandre Belloni <alexandre.belloni@free-electrons.com>
Cc: geert@linux-m68k.org, deller@gmx.de, benh@kernel.crashing.org, mpe@ellerman.id.au, dalias@libc.org, dhowells@redhat.com, linux-alpha@vger.kernel.org, a.zummo@towertech.it, linux-kernel@vger.kernel.org, linux-parisc@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, linux-sh@vger.kernel.org, linux-m68k@lists.linux-m68k.org, rtc-linux@googlegroups.com, linux-arch@vger.kernel.org

This is a resend of an earlier series, to clean up the rtc-generic
driver by avoiding the dependency on the architecture specific
include/asm/rtc.h header that after this series is only used
for the deprecated "genrtc" driver. As I've shown in another
series, only three architectures (m68k, powerpc, parisc)
actually use the genrtc driver, and they all support rtc-generic
as a replacement as well.

The only missing piece appears to be the ioctl support for
the m68k q40 machine that I'm adding in patch 2 here.

	Arnd
