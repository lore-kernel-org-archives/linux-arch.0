From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH 12/16] h8300: clocksource
Date: Wed, 21 Jan 2015 09:49:01 +0100
Message-ID: <1490710.93luznfBoo@wuerfel>
References: <cover.1421813622.git.ysato@users.sourceforge.jp> <87iog0vjoj.wl-ysato@users.sourceforge.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mout.kundenserver.de ([212.227.126.187]:57465 "EHLO
	mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750823AbbAUItG (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Wed, 21 Jan 2015 03:49:06 -0500
In-Reply-To: <87iog0vjoj.wl-ysato@users.sourceforge.jp>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Yoshinori Sato <ysato@users.sourceforge.jp>
Cc: linux-arch@vger.kernel.org

On Wednesday 21 January 2015 13:31:24 Yoshinori Sato wrote:
> Signed-off-by: Yoshinori Sato <ysato@users.sourceforge.jp>
> 
>  create mode 100644 arch/h8300/kernel/timer/Makefile
>  create mode 100644 arch/h8300/kernel/timer/timer16.c
>  create mode 100644 arch/h8300/kernel/timer/timer8.c
>  create mode 100644 arch/h8300/kernel/timer/tpu.c

How about moving these to drivers/clocksource?

I think it will be fine either way, but most clocksource implementations
are there now.

	Arnd
