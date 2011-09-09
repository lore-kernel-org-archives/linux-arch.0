From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [patch v3 05/36] Hexagon: Add syscalls
Date: Fri, 09 Sep 2011 10:05:50 +0200
Message-ID: <32094382.BHQ4jXpVFr@wuerfel>
References: <20110909010847.294039464@codeaurora.org> <20110909010915.173882729@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.126.187]:55900 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758118Ab1IIIGK (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Fri, 9 Sep 2011 04:06:10 -0400
In-Reply-To: <20110909010915.173882729@codeaurora.org>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Richard Kuo <rkuo@codeaurora.org>
Cc: linux-arch@vger.kernel.org, linux-hexagon@vger.kernel.org, linux-kernel@vger.kernel.org

On Thursday 08 September 2011 20:08:52 Richard Kuo wrote:
> Removed sys_mmap* and replaced with sys_mmap_pgoff()
> 
> 
> Signed-off-by: Richard Kuo <rkuo@codeaurora.org>

Acked-by: Arnd Bergmann <arnd@arndb.de>
