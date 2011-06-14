From: KyongHo Cho <pullip.cho@samsung.com>
Subject: Re: [PATCH] dma-mapping: Undefine dma_map_single(), etc if
 CONFIG_HAVE_DMA_ATTRS is defined
Date: Tue, 14 Jun 2011 14:31:29 +0900
Message-ID: <BANLkTinqzPfg_S3eJoM=aBacDK9T+3L-FQ@mail.gmail.com>
References: <1308025989-877-1-git-send-email-pullip.cho@samsung.com>
	<005501cc2a52$c05df650$4119e2f0$%kim@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mail-gx0-f174.google.com ([209.85.161.174]:61689 "EHLO
	mail-gx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751081Ab1FNFba (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Tue, 14 Jun 2011 01:31:30 -0400
In-Reply-To: <005501cc2a52$c05df650$4119e2f0$%kim@samsung.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Kukjin Kim <kgene.kim@samsung.com>
Cc: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, arnd@arndb.de, fujita.tomonori@lab.ntt.co.jp, rmk@arm.linux.org.uk, joerg.roedel@amd.com

On Tue, Jun 14, 2011 at 2:20 PM, Kukjin Kim <kgene.kim@samsung.com> wrote:
>> Change-Id: Ib99ee2b355dbe679263ce2e4e27d6219148c8338
>
> Please don't use this here.
>
I forgot to remove that.
Thank you.
