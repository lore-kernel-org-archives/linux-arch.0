From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH v2 1/1] asm-generic: add MMU variants of io.h functions
Date: Sat, 2 Jul 2011 21:44:38 +0200
Message-ID: <201107022144.38905.arnd@arndb.de>
References: <CAMjpGUeMqVzcAWKpAojZVbj9ywH+4HmW4Hx-8D1WQmTqPSNqQA@mail.gmail.com> <1309628168-3413-1-git-send-email-jonas@southpole.se>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.17.8]:52131 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753069Ab1GBTpO (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Sat, 2 Jul 2011 15:45:14 -0400
In-Reply-To: <1309628168-3413-1-git-send-email-jonas@southpole.se>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Jonas Bonn <jonas@southpole.se>
Cc: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, vapier@gentoo.org, liqin.chen@sunplusct.com, gxt@mprc.pku.edu.cn

On Saturday 02 July 2011 19:36:08 Jonas Bonn wrote:
> 
> Some of the implementations, in particular the ioremap variants, in
> asm-generic/io.h are for systems without an MMU.  In order to be able to
> use the generic header file for systems with an MMU, this patch wraps
> these implementations in checks for CONFIG_MMU.
> 
> Tested on OpenRISC.
> 
> Signed-off-by: Jonas Bonn <jonas@southpole.se>
> Cc: vapier@gentoo.org
> Cc: liqin.chen@sunplusct.com
> Cc: gxt@mprc.pku.edu.cn

Acked-by: Arnd Bergmann <arnd@arndb.de>
