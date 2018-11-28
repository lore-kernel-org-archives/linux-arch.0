Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mo4-p01-ob.smtp.rzone.de ([85.215.255.50]:36615 "EHLO
        mo4-p01-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727979AbeK2DKB (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 28 Nov 2018 22:10:01 -0500
Subject: Re: use generic DMA mapping code in powerpc V4
References: <20181114082314.8965-1-hch@lst.de> <20181127074253.GB30186@lst.de>
 <87zhttfonk.fsf@concordia.ellerman.id.au>
From: Christian Zigotzky <chzigotzky@xenosoft.de>
Message-ID: <535776df-dea3-eb26-6bf3-83f225e977df@xenosoft.de>
Date: Wed, 28 Nov 2018 16:55:30 +0100
MIME-Version: 1.0
In-Reply-To: <87zhttfonk.fsf@concordia.ellerman.id.au>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: de-DE
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Michael Ellerman <mpe@ellerman.id.au>, Christoph Hellwig <hch@lst.de>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Paul Mackerras <paulus@samba.org>
Cc: linux-arch@vger.kernel.org, linux-mm@kvack.org, iommu@lists.linux-foundation.org, linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Message-ID: <20181128155530.Rb0vfB749rq0baJYHcj59Jo4em4YqY9OzNjI7tsj_yQ@z>

On 28 November 2018 at 12:05PM, Michael Ellerman wrote:
> Nothing specific yet.
>
> I'm a bit worried it might break one of the many old obscure platforms
> we have that aren't well tested.
>
Please don't apply the new DMA mapping code if you don't be sure if it 
works on all supported PowerPC machines. Is the new DMA mapping code 
really necessary? It's not really nice, to rewrote code if the old code 
works perfect. We must not forget, that we work for the end users. Does 
the end user have advantages with this new code? Is it faster? The old 
code works without any problems. I am also worried about this code. How 
can I test this new DMA mapping code?

Thanks
