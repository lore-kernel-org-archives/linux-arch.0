Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.17.9]:65508 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758549Ab1IIIQl (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Fri, 9 Sep 2011 04:16:41 -0400
From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [patch v3 21/36] Hexagon: Add SMP support
Date: Fri, 09 Sep 2011 10:16:21 +0200
Message-ID: <15669045.OftK0xyS1C@wuerfel>
In-Reply-To: <20110909010916.709728186@codeaurora.org>
References: <20110909010847.294039464@codeaurora.org> <20110909010916.709728186@codeaurora.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Richard Kuo <rkuo@codeaurora.org>
Cc: linux-arch@vger.kernel.org, linux-hexagon@vger.kernel.org, linux-kernel@vger.kernel.org, Linas Vepstas <linas@codeaurora.org>
Message-ID: <20110909081621.R8_E4GtxHLx55-RKexl4a_ZQuyxQQwTyT-kZQmlB2Sc@z>

On Thursday 08 September 2011 20:09:08 Richard Kuo wrote:
> Changed smp.c to use generic IPI handler functions.
> 
> Signed-off-by: Richard Kuo <rkuo@codeaurora.org>
> Signed-off-by: Linas Vepstas <linas@codeaurora.org>

Acked-by: Arnd Bergmann <arnd@arndb.de>
