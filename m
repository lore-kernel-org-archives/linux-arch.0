Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from hqemgate04.nvidia.com ([216.228.121.35]:12045 "EHLO
	hqemgate04.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750906Ab2CGHGY convert rfc822-to-8bit (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Wed, 7 Mar 2012 02:06:24 -0500
From: Krishna Reddy <vdumpa@nvidia.com>
Date: Tue, 6 Mar 2012 23:06:13 -0800
Subject: RE: [PATCHv7 9/9] ARM: dma-mapping: add support for IOMMU mapper
Message-ID: <401E54CE964CD94BAE1EB4A729C7087E37973BEA74@HQMAIL04.nvidia.com>
References: <000001ccfaea$00c16f70$02444e50$%szyprowski@samsung.com><401E54CE964CD94BAE1EB4A729C7087E37970113FE@HQMAIL04.nvidia.com><20120307.080952.2152478004740487196.hdoyu@nvidia.com>
 <20120307.083706.2087121294965856946.hdoyu@nvidia.com>
In-Reply-To: <20120307.083706.2087121294965856946.hdoyu@nvidia.com>
Content-Language: en-US
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Hiroshi Doyu <hdoyu@nvidia.com>
Cc: "m.szyprowski@samsung.com" <m.szyprowski@samsung.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "linaro-mm-sig@lists.linaro.org" <linaro-mm-sig@lists.linaro.org>, "linux-mm@kvack.org" <linux-mm@kvack.org>, "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>, "linux-samsung-soc@vger.kernel.org" <linux-samsung-soc@vger.kernel.org>, "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>, "shariq.hasnain@linaro.org" <shariq.hasnain@linaro.org>, "arnd@arndb.de" <arnd@arndb.de>, "benh@kernel.crashing.org" <benh@kernel.crashing.org>, "kyungmin.park@samsung.com" <kyungmin.park@samsung.com>, "andrzej.p@samsung.com" <andrzej.p@samsung.com>, "linux@arm.linux.org.uk" <linux@arm.linux.org.uk>, "pullip.cho@samsung.com" <pullip.cho@samsung.com>, "chunsang.jeong@linaro.org" <chunsang.jeong@linaro.org>
Message-ID: <20120307070613.TpJVBQDAlDMOlFgmyKu5nv6rADddX7fZ1AjN--zSo4U@z>

> > > It should be as follows.
> > > unsigned int count = 1 << get_order(size) - order;
> 
> To be precise, as below?
> 
>  unsigned int count = 1 << (get_order(size) - order);

Minus has more precedence than left shift.
"1 << get_order(size) - order;" is equivalent to 1 << (get_order(size) - order);

-KR
--nvpublic
