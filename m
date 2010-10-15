From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH 10/22] asm-generic: use little endian bitops
Date: Fri, 15 Oct 2010 13:06:13 +0200
Message-ID: <201010151306.14366.arnd@arndb.de>
References: <1287135981-17604-1-git-send-email-akinobu.mita@gmail.com> <1287135981-17604-11-git-send-email-akinobu.mita@gmail.com>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.17.10]:62186 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754768Ab0JOLFm (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Fri, 15 Oct 2010 07:05:42 -0400
In-Reply-To: <1287135981-17604-11-git-send-email-akinobu.mita@gmail.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Akinobu Mita <akinobu.mita@gmail.com>
Cc: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, Christoph Hellwig <hch@infradead.org>, Andrew Morton <akpm@linux-foundation.org>

On Friday 15 October 2010, Akinobu Mita wrote:
> As a preparation for removing ext2 non-atomic bit operations from
> asm/bitops.h. This converts ext2 non-atomic bit operations to
> little endian bit operations.
> 
> Signed-off-by: Akinobu Mita <akinobu.mita@gmail.com>

Acked-by: Arnd Bergmann <arnd@arndb.de>
