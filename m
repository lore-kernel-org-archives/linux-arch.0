Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.126.187]:52410 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757534Ab1IIIUI (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Fri, 9 Sep 2011 04:20:08 -0400
From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [patch v3 28/36] Hexagon: Add ioremap support
Date: Fri, 09 Sep 2011 10:19:45 +0200
Message-ID: <1341897.KOyUviEHQX@wuerfel>
In-Reply-To: <20110909010917.374485496@codeaurora.org>
References: <20110909010847.294039464@codeaurora.org> <20110909010917.374485496@codeaurora.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Richard Kuo <rkuo@codeaurora.org>
Cc: linux-arch@vger.kernel.org, linux-hexagon@vger.kernel.org, linux-kernel@vger.kernel.org
Message-ID: <20110909081945.dMebV5Q2jcvM5D68MnOMEonFk6u-GKMmi7Q34WH38S0@z>

On Thursday 08 September 2011 20:09:15 Richard Kuo wrote:
> Removed redundant flush_cache_vmap.
> 
> Signed-off-by: Richard Kuo <rkuo@codeaurora.org>

Acked-by: Arnd Bergmann <arnd@arndb.de>
