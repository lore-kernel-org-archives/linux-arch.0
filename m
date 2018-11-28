Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mo4-p01-ob.smtp.rzone.de ([81.169.146.165]:13287 "EHLO
        mo4-p01-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725994AbeK2HGM (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 29 Nov 2018 02:06:12 -0500
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (1.0)
Subject: Re: use generic DMA mapping code in powerpc V4
From: Christian Zigotzky <chzigotzky@xenosoft.de>
In-Reply-To: <535776df-dea3-eb26-6bf3-83f225e977df@xenosoft.de>
Date: Wed, 28 Nov 2018 21:02:51 +0100
Content-Transfer-Encoding: quoted-printable
Message-ID: <7B91760F-AFC3-4C8C-9B9F-FA0E9AD76B0C@xenosoft.de>
References: <20181114082314.8965-1-hch@lst.de> <20181127074253.GB30186@lst.de> <87zhttfonk.fsf@concordia.ellerman.id.au> <535776df-dea3-eb26-6bf3-83f225e977df@xenosoft.de>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Michael Ellerman <mpe@ellerman.id.au>, Christoph Hellwig <hch@lst.de>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Paul Mackerras <paulus@samba.org>
Cc: linux-arch@vger.kernel.org, linux-mm@kvack.org, iommu@lists.linux-foundation.org, linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Message-ID: <20181128200251.HLy_P77Q0JRbKc1weJ2gh0kF8pY33P_zTX0nB7K_2Xc@z>

I will compile and test the kernel from the following Git on my PowerPC mach=
ines.

http://git.infradead.org/users/hch/misc.git

On 28 November 2018 at 12:05PM, Michael Ellerman wrote:
Nothing specific yet.

I'm a bit worried it might break one of the many old obscure platforms
we have that aren't well tested.
