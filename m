Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.126.186]:55938 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758461Ab1IIIHZ (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Fri, 9 Sep 2011 04:07:25 -0400
From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [patch v3 08/36] Hexagon: Add delay functions
Date: Fri, 09 Sep 2011 10:07:05 +0200
Message-ID: <7440179.BsgeraFyS5@wuerfel>
In-Reply-To: <20110909010915.450346603@codeaurora.org>
References: <20110909010847.294039464@codeaurora.org> <20110909010915.450346603@codeaurora.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Richard Kuo <rkuo@codeaurora.org>
Cc: linux-arch@vger.kernel.org, linux-hexagon@vger.kernel.org, linux-kernel@vger.kernel.org
Message-ID: <20110909080705.Pe4MvUn6mUh5IprW-2RN94lom0IGSOcG5yhzlS7Yv4A@z>

On Thursday 08 September 2011 20:08:55 Richard Kuo wrote:
> Added read_current_timer elsewhere.
> 
> udelay is based off of __vmgettime() which returns processor ticks.
> 
> Removed __delay and CONFIG_GENERIC_CALIBRATE_DELAY.
> 
> Signed-off-by: Richard Kuo <rkuo@codeaurora.org>

Acked-by: Arnd Bergmann <arnd@arndb.de>
