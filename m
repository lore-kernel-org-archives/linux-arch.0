From: Michal Marek <mmarek@suse.cz>
Subject: Re: [PATCH 5/5] vmlinux.lds.h: replace config_enabled() with
 IS_ENABLED()
Date: Mon, 20 Jun 2016 22:45:49 +0200
Message-ID: <576855FD.6020202@suse.cz>
References: <1465883938-25194-1-git-send-email-yamada.masahiro@socionext.com>
 <1465883938-25194-5-git-send-email-yamada.masahiro@socionext.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:45472 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752058AbcFTUp5 (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Mon, 20 Jun 2016 16:45:57 -0400
In-Reply-To: <1465883938-25194-5-git-send-email-yamada.masahiro@socionext.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Masahiro Yamada <yamada.masahiro@socionext.com>, linux-kernel@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>
Cc: Rusty Russell <rusty@rustcorp.com.au>, Michal Simek <michal.simek@xilinx.com>, Linus Torvalds <torvalds@linux-foundation.org>, Arnd Bergmann <arnd@arndb.de>, Nicolas Pitre <nicolas.pitre@linaro.org>, linux-arch@vger.kernel.org

Dne 14.6.2016 v 07:58 Masahiro Yamada napsal(a):
> The use of config_enabled() against config options is ambiguous.
> 
> Now, IS_ENABLED() is implemented purely with macro expansion, so
> let's replace config_enabled() with IS_ENABLED().
> 
> Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>

I applied the whole series to kbuild.git#kbuild.

Michal
