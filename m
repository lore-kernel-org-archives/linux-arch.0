From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH] asm-generic: Fix typo in asm-generic/unistd.h.
Date: Mon, 2 Nov 2009 09:39:14 +0100
Message-ID: <200911020939.15309.arnd@arndb.de>
References: <1256526569.7283.3.camel@ad3ser01>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.126.186]:53077 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751015AbZKBIjR (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Mon, 2 Nov 2009 03:39:17 -0500
In-Reply-To: <1256526569.7283.3.camel@ad3ser01>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Chen Liqin <liqin.chen@sunplusct.com>
Cc: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, liqin.gnu@gmail.com

On Monday 26 October 2009, Chen Liqin wrote:
> >From 9741f7928ef35416e49f329a64e623a109de5c2d Mon Sep 17 00:00:00 2001
> From: Chen Liqin <liqin.chen@sunplusct.com>
> Date: Mon, 26 Oct 2009 10:50:50 +0800
> Subject: [PATCH] asm-generic: Fix typo in asm-generic/unistd.h.
> 
> Fixed __NR_ftruncate and __NR_ftruncate64 define in asm-generic/unistd.h.
> 
> Signed-off-by: Chen Liqin <liqin.chen@sunplusct.com>

Applied, thanks!

I assume that means you are progressing with getting all bugs fixed that
were introduced in the conversion to the asm-generic headers. Do you
have a full glibc running again, and passing LTP?

	Arnd <><
