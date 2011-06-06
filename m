From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH v2] asm-generic: add another generic ext2 atomic bitops
Date: Mon, 6 Jun 2011 15:29:57 +0200
Message-ID: <201106061529.57417.arnd@arndb.de>
References: <1307201251-16805-1-git-send-email-akinobu.mita@gmail.com>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.126.171]:55933 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756365Ab1FFNag (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Mon, 6 Jun 2011 09:30:36 -0400
In-Reply-To: <1307201251-16805-1-git-send-email-akinobu.mita@gmail.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Akinobu Mita <akinobu.mita@gmail.com>
Cc: linux-kernel@vger.kernel.org, akpm@linux-foundation.org, Andreas Dilger <adilger@dilger.ca>, linux-arch@vger.kernel.org

On Saturday 04 June 2011, Akinobu Mita wrote:
> The majority of architectures implement ext2 atomic bitops as
> test_and_{set,clear}_bit() without spinlock.
> 
> This adds this type of generic implementation in ext2-atomic-setbit.h
> and use it wherever possible.
> 
> Suggested-by: Andreas Dilger <adilger@dilger.ca>
> Suggested-by: Arnd Bergmann <arnd@arndb.de>
> Signed-off-by: Akinobu Mita <akinobu.mita@gmail.com>
> Cc: linux-arch@vger.kernel.org

Looks good,

Acked-by: Arnd Bergmann <arnd@arndb.de>
