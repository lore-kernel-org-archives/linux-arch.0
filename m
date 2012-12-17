From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH 2/2] asm-generic/dma-mapping-broken.h: Provide dma_alloc_attrs()/dma_free_attrs()
Date: Mon, 17 Dec 2012 16:12:43 +0000
Message-ID: <201212171612.44126.arnd@arndb.de>
References: <1355679527-1207-1-git-send-email-geert@linux-m68k.org> <1355679527-1207-2-git-send-email-geert@linux-m68k.org>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.126.187]:54853 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752179Ab2LQQMz (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Mon, 17 Dec 2012 11:12:55 -0500
In-Reply-To: <1355679527-1207-2-git-send-email-geert@linux-m68k.org>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: linux-arch@vger.kernel.org, linux-m68k@lists.linux-m68k.org, linux-kernel@vger.kernel.org

On Sunday 16 December 2012, Geert Uytterhoeven wrote:
> 
> Since commit 0049fb2603b7afb1080776ee691dfa5a3d282357 ("OMAPFB: use
> dma_alloc_attrs to allocate memory") we have one non-arch user of
> dma_{alloc,free}_attrs().
> 
> Hence provide these functions, as wrappers around
> dma_{alloc,free}_coherent().
> 
> Note that most architectures do it the other way around. But as these are
> dummy functions, we don't care.
> 
> Signed-off-by: Geert Uytterhoeven <geert@linux-m68k.org>
> ---
>  include/asm-generic/dma-mapping-broken.h |   16 ++++++++++++++++
>  1 files changed, 16 insertions(+), 0 deletions(-)

Acked-by: Arnd Bergmann <arnd@arndb.de>

Maybe you can put this one in your m68k tree along with your other
patch.

	Arnd
