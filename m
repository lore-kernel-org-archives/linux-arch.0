Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail-wm0-f52.google.com ([74.125.82.52]:35978 "EHLO
        mail-wm0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750812AbeAPIWz (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 16 Jan 2018 03:22:55 -0500
Reply-To: christian.koenig@amd.com
Subject: Re: consolidate swiotlb dma_map implementations
References: <20180110080932.14157-1-hch@lst.de>
 <20180116075338.GB12693@infradead.org>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>
Message-ID: <76e47666-3de1-68cc-07ad-003491d26ef9@gmail.com>
Date: Tue, 16 Jan 2018 09:22:52 +0100
MIME-Version: 1.0
In-Reply-To: <20180116075338.GB12693@infradead.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Konrad Rzeszutek Wilk <konrad@darnok.org>
Cc: Christoph Hellwig <hch@infradead.org>, Christoph Hellwig <hch@lst.de>, iommu@lists.linux-foundation.org, linux-arch@vger.kernel.org, linux-mips@linux-mips.org, Michal Simek <monstr@monstr.eu>, linux-ia64@vger.kernel.org, x86@kernel.org, linux-kernel@vger.kernel.org, Guan Xuetao <gxt@mprc.pku.edu.cn>, linuxppc-dev@lists.ozlabs.org, linux-arm-kernel@lists.infradead.org
Message-ID: <20180116082252.GRf8A2IwtEUOJ3ckuC8oV-MjMvFZ4sDoKje6XZghpyc@z>

Hi Konrad,

can you send the first patch to Linus for inclusion in 4.15 if you 
haven't already done so?

I'm still getting reports from people complaining about the error message.

Thanks,
Christian.

Am 16.01.2018 um 08:53 schrieb Christoph Hellwig:
> I've pulled this into the dma-mapping for-next tree, including the
> missing free_pages noted.  I'd be fine to rebase another day or two
> for additional reviews or important fixes.
