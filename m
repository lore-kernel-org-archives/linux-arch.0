From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: sys_recvmmsg: wire up or not?
Date: Sat, 26 Dec 2009 11:39:27 +0100
Message-ID: <10f740e80912260239n17bbbd08w6c3065c12bde9c95@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mail-ew0-f219.google.com ([209.85.219.219]:47835 "EHLO
	mail-ew0-f219.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751754AbZLZKja (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Sat, 26 Dec 2009 05:39:30 -0500
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Arnaldo Carvalho de Melo <acme@redhat.com>, Arnd Bergmann <arnd@arndb.de>
Cc: linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org, Linux/m68k <linux-m68k@vger.kernel.org>

On m68k, I get:

<stdin>:1523:2: warning: #warning syscall recvmmsg not implemented

so I started to wire up sys_recvmmsg.
Then I noticed it's already accessible, through sys_socketcall, as m68k defines
__ARCH_WANT_SYS_SOCKETCALL. So I guess this is a false positive?

Surprisingly, several architectures have both defined __ARCH_WANT_SYS_SOCKETCALL
and wired up sys_recvmmsg. Is this intentional?

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds
