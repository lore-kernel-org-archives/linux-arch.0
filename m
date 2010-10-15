From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH 00/22] Introduce little endian bitops
Date: Fri, 15 Oct 2010 13:14:57 +0200
Message-ID: <201010151314.57428.arnd@arndb.de>
References: <1287135981-17604-1-git-send-email-akinobu.mita@gmail.com>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.126.187]:50796 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751323Ab0JOLOW (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Fri, 15 Oct 2010 07:14:22 -0400
In-Reply-To: <1287135981-17604-1-git-send-email-akinobu.mita@gmail.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Akinobu Mita <akinobu.mita@gmail.com>
Cc: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, Christoph Hellwig <hch@infradead.org>, Andrew Morton <akpm@linux-foundation.org>

On Friday 15 October 2010, Akinobu Mita wrote:
> 
> This patch series introduces little endian bit operations in asm/bitops.h
> for all architectures and converts ext2 non-atomic and minix bit operation
> to them. it enables to remove ext2 non-atomic and minix bit operations
> from asm/bitops.h. The reason they should be removed from asm/bitops.h
> is as follows:
> 
> For ext2 non-atomic bit operations, they are used for little endian byte order
> bitmap access by some filesystems and modules. But using ext2_*() functions on
> a module other than ext2 filesystem makes someone feel strange.
> 
> For minix bit operations, they are only used by minix filesystem and useless
> by other modules. Because byte order of inode and block bitmap is defferent
> on each architectures.

Very nice work! I already replied on two issues that I think could be improved,
everything else looks good.

	Arnd
