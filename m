Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.126.186]:61651 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758539Ab1IIIPn (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Fri, 9 Sep 2011 04:15:43 -0400
From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [patch v3 19/36] Hexagon: Add ptrace support
Date: Fri, 09 Sep 2011 10:15:22 +0200
Message-ID: <6788879.2Pf4OtZvAN@wuerfel>
In-Reply-To: <20110909010916.525482401@codeaurora.org>
References: <20110909010847.294039464@codeaurora.org> <20110909010916.525482401@codeaurora.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Richard Kuo <rkuo@codeaurora.org>
Cc: linux-arch@vger.kernel.org, linux-hexagon@vger.kernel.org, linux-kernel@vger.kernel.org, Linas Vepstas <linas@codeaurora.org>
Message-ID: <20110909081522.THnW_XuuJAyDyiQVYeNc8O0x5SzVrzhJM93Vmlyb7a4@z>

On Thursday 08 September 2011 20:09:06 Richard Kuo wrote:
> Will look at the more generic ptrace support in the future.
> 
> Signed-off-by: Richard Kuo <rkuo@codeaurora.org>
> Signed-off-by: Linas Vepstas <linas@codeaurora.org>

Note that this absolutely has to be completed before the code is merged upstream,
because it is relevant to the ABI.

	Arnd
