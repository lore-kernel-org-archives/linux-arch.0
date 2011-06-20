From: KyongHo Cho <pullip.cho@samsung.com>
Subject: Re: [Linaro-mm-sig] [PATCH 7/8] common: dma-mapping: change
 alloc/free_coherent method to more generic alloc/free_attrs
Date: Tue, 21 Jun 2011 00:14:14 +0900
Message-ID: <BANLkTimJDpKR4Nm8Lz3V1Yov=07wadAmfQ@mail.gmail.com>
References: <1308556213-24970-1-git-send-email-m.szyprowski@samsung.com>
	<1308556213-24970-8-git-send-email-m.szyprowski@samsung.com>
	<BANLkTikFdrOuXsLCfvyA_V+p7S_fd72dyQ@mail.gmail.com>
	<20110620150610.GG26089@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mail-yw0-f46.google.com ([209.85.213.46]:51987 "EHLO
	mail-yw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751276Ab1FTPOP convert rfc822-to-8bit (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Mon, 20 Jun 2011 11:14:15 -0400
Received: by ywe9 with SMTP id 9so2112158ywe.19
        for <linux-arch@vger.kernel.org>; Mon, 20 Jun 2011 08:14:14 -0700 (PDT)
In-Reply-To: <20110620150610.GG26089@n2100.arm.linux.org.uk>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Russell King - ARM Linux <linux@arm.linux.org.uk>
Cc: linux-arch@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>, Joerg Roedel <joro@8bytes.org>, linaro-mm-sig@lists.linaro.org, linux-mm@kvack.org, Kyungmin Park <kyungmin.park@samsung.com>, linux-arm-kernel@lists.infradead.org

On Tue, Jun 21, 2011 at 12:06 AM, Russell King - ARM Linux
<linux@arm.linux.org.uk> wrote:
> Wrong - there is a difference. =A0For pre-ARMv6 CPUs, it returns memo=
ry
> with different attributes from DMA coherent memory.
>
> And we're not going to sweep away pre-ARMv6 CPUs any time soon. =A0So
> you can't ignore dma_alloc_writecombine() which must remain to sanely
> support framebuffers.
>
OK. Thanks.

Then, I think we can implement dma_alloc_writecombine() away from dma_m=
ap_ops.
IMHO, those devices that use dma_alloc_writecombine() are enough with
the default dma_map_ops.
Removing a member from dma_map_ops is too heavy work.
