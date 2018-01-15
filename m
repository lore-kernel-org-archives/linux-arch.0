Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from verein.lst.de ([213.95.11.211]:39548 "EHLO newverein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932629AbeAOJKE (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Mon, 15 Jan 2018 04:10:04 -0500
Date: Mon, 15 Jan 2018 10:10:02 +0100
From: Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH 10/22] swiotlb: refactor coherent buffer allocation
Message-ID: <20180115091002.GA398@lst.de>
References: <20180110080932.14157-1-hch@lst.de> <20180110080932.14157-11-hch@lst.de> <cecc98cf-2e6a-a7bc-7390-d6dcced038c4@arm.com> <20180110154649.GA18529@lst.de> <03c25dda-30da-9169-a8a1-1720ec741b9d@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <03c25dda-30da-9169-a8a1-1720ec741b9d@arm.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Robin Murphy <robin.murphy@arm.com>
Cc: Christoph Hellwig <hch@lst.de>, linux-arch@vger.kernel.org, linux-mips@linux-mips.org, Michal Simek <monstr@monstr.eu>, linux-ia64@vger.kernel.org, Christian =?iso-8859-1?Q?K=F6nig?= <ckoenig.leichtzumerken@gmail.com>, x86@kernel.org, linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org, Konrad Rzeszutek Wilk <konrad@darnok.org>, Guan Xuetao <gxt@mprc.pku.edu.cn>, linuxppc-dev@lists.ozlabs.org, linux-arm-kernel@lists.infradead.org
Message-ID: <20180115091002.eTBf5PnQDspL0a9F0TA8upCQyCYDBSbdxES2gkueQL8@z>

On Wed, Jan 10, 2018 at 05:02:30PM +0000, Robin Murphy wrote:
>>>
>>> Aren't we leaking the pages here?
>>
>> Yes, that free_pages got lost somewhere in the rebases, I've added
>> it back.
>
> Cool.

FYI, here is the fixed version, I don't want to re-send the whole
series for this fix:

http://git.infradead.org/users/hch/misc.git/commitdiff/0176adb004065d6815a8e67946752df4cd947c5b
