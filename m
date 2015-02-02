From: Laura Abbott <lauraa@codeaurora.org>
Subject: Re: [RFC] change non-atomic bitops method
Date: Mon, 02 Feb 2015 10:53:16 -0800
Message-ID: <54CFC79C.2040005@codeaurora.org>
References: <35FD53F367049845BC99AC72306C23D1044A02027E0A@CNBJMBX05.corpusers.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from smtp.codeaurora.org ([198.145.11.231]:36593 "EHLO
	smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752822AbbBBSxS (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Mon, 2 Feb 2015 13:53:18 -0500
In-Reply-To: <35FD53F367049845BC99AC72306C23D1044A02027E0A@CNBJMBX05.corpusers.net>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: "Wang, Yalin" <Yalin.Wang@sonymobile.com>, "'arnd@arndb.de'" <arnd@arndb.de>, "'linux-arch@vger.kernel.org'" <linux-arch@vger.kernel.org>, "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>, "'linux@arm.linux.org.uk'" <linux@arm.linux.org.uk>, "'linux-arm-kernel@lists.infradead.org'" <linux-arm-kernel@lists.infradead.org>

On 2/1/2015 7:55 PM, Wang, Yalin wrote:
> This patch change non-atomic bitops,
> add a if() condition to test it, before set/clear the bit.
> so that we don't need dirty the cache line, if this bit
> have been set or clear. On SMP system, dirty cache line will
> need invalidate other processors cache line, this will have
> some impact on SMP systems.
>

Any actual numbers to give an idea of the impact?

Thanks,
Laura


-- 
Qualcomm Innovation Center, Inc.
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project
