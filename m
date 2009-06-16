From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH] asm-generic: add EMAXERRNO
Date: Tue, 16 Jun 2009 16:13:07 +0200
Message-ID: <200906161613.07979.arnd@arndb.de>
References: <OFD9F2472F.5C67128A-ON482575D7.000F7E83-482575D7.0011466D@sunplusct.com>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="gb2312"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.126.187]:56527 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751505AbZFPONj (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Tue, 16 Jun 2009 10:13:39 -0400
In-Reply-To: <OFD9F2472F.5C67128A-ON482575D7.000F7E83-482575D7.0011466D@sunplusct.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: liqin.chen@sunplusct.com, linux-kernel@vger.kernel.org
Cc: Andrew Morton <akpm@linux-foundation.org>, linux-arch@vger.kernel.org, Matthew Wilcox <matthew@wil.cx>, torvalds@linux-foundation.org

On Tuesday 16 June 2009, liqin.chen@sunplusct.com wrote:
> But I think move MAX_ERRNO define from include/linux/err.h to 
> include/asm-generic/errno.h will be more clear. And no harm to
> include/linux/err.h file.

Don't know. I think err.h makes more sense because that is
for kernel-internal users like the much more common IS_ERR(),
while include/asm-generic/errno.h is strictly for kernel/user
interfaces.

	Arnd <><
