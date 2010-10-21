From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH v2 01/22] bitops: merge little and big endian definisions in asm-generic/bitops/le.h
Date: Thu, 21 Oct 2010 17:06:14 +0200
Message-ID: <201010211706.15042.arnd@arndb.de>
References: <1287672077-5797-1-git-send-email-akinobu.mita@gmail.com> <1287672077-5797-2-git-send-email-akinobu.mita@gmail.com>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.17.10]:64147 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751388Ab0JUPFj (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Thu, 21 Oct 2010 11:05:39 -0400
In-Reply-To: <1287672077-5797-2-git-send-email-akinobu.mita@gmail.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Akinobu Mita <akinobu.mita@gmail.com>
Cc: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, Christoph Hellwig <hch@infradead.org>, Andrew Morton <akpm@linux-foundation.org>

On Thursday 21 October 2010, Akinobu Mita wrote:
> In order to make the forthcoming changes smaller, this merges
> macro definisions in asm-generic/bitops/le.h for big-endian and
> little-endian as much as possible.
> 
> This also removes unused BITOP_WORD macro.
> 
> Signed-off-by: Akinobu Mita <akinobu.mita@gmail.com>

Acked-by: Arnd Bergmann <arnd@arndb.de>
