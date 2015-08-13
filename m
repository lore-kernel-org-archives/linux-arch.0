Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from smtp.codeaurora.org ([198.145.29.96]:55166 "EHLO
	smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752162AbbHMMad (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Thu, 13 Aug 2015 08:30:33 -0400
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [2/3] brcmfmac: dhd_sdio.c: use existing atomic_or primitive
From: Kalle Valo <kvalo@codeaurora.org>
In-Reply-To: <1436429599-10762-3-git-send-email-vgupta@synopsys.com>
Message-ID: <20150813123032.7D664140538@smtp.codeaurora.org>
Date: Thu, 13 Aug 2015 12:30:32 +0000 (UTC)
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Vineet Gupta <Vineet.Gupta1@synopsys.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@kernel.org>, Arnd Bergmann <arnd@arndb.de>, linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org, Brett Rudley <brudley@broadcom.com>, Arend van Spriel <arend@broadcom.com>, "Franky (Zhenhui) Lin" <frankyl@broadcom.com>, Hante Meuleman <meuleman@broadcom.com>, Pieter-Paul Giesberts <pieterpg@broadcom.com>, Daniel Kim <dekim@broadcom.com>, linux-wireless@vger.kernel.org, brcm80211-dev-list@broadcom.com, netdev@vger.kernel.org
Message-ID: <20150813123032.CeXoV3Pqj93z5Z1sBkMZKZRmGiGtjRKcCrSbaV958xA@z>


> There's already a generic implementation so use that instead.

Thanks, applied to wireless-drivers-next.git.

Kalle Valo
