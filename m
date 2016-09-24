From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH] asm-generic: page.h: fix comment typo
Date: Sat, 24 Sep 2016 11:20:22 +0200
Message-ID: <1507748.SalXa23Hks@wuerfel>
References: <20160823073359.21690-1-lstoakes@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mout.kundenserver.de ([212.227.126.134]:58043 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1761714AbcIXJU0 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Sat, 24 Sep 2016 05:20:26 -0400
In-Reply-To: <20160823073359.21690-1-lstoakes@gmail.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Lorenzo Stoakes <lstoakes@gmail.com>
Cc: linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org

On Tuesday, August 23, 2016 8:33:59 AM CEST Lorenzo Stoakes wrote:
> This patch prefixes a '!' to a /* __ASSEMBLY__ */ comment following an #ifndef
> __ASSEMBLY__ block.
> 
> Signed-off-by: Lorenzo Stoakes <lstoakes@gmail.com>
> 

Applied to my asm-generic tree now, thanks and sorry for the
delay.

	Arnd
