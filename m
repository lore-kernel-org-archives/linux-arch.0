Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from verein.lst.de ([213.95.11.211]:59129 "EHLO newverein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725939AbeLFTgH (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Thu, 6 Dec 2018 14:36:07 -0500
Date: Thu, 6 Dec 2018 20:36:05 +0100
From: Christoph Hellwig <hch@lst.de>
Subject: Re: use generic DMA mapping code in powerpc V4
Message-ID: <20181206193605.GA31255@lst.de>
References: <8694431d-c669-b7b9-99fa-e99db5d45a7d@xenosoft.de> <20181130131056.GA5211@lst.de> <25999587-2d91-a63c-ed38-c3fb0075d9f1@xenosoft.de> <c5202d29-863d-1377-0e2d-762203b317e2@xenosoft.de> <58c61afb-290f-6196-c72c-ac7b61b84718@xenosoft.de> <20181204142426.GA2743@lst.de> <ef56d279-f75d-008e-71ba-7068c1b37c48@xenosoft.de> <20181205140550.GA27549@lst.de> <1948cf84-49ab-543c-472c-d18e27751903@xenosoft.de> <9ECD27D6-B039-4253-9FB9-749B41DE4CC6@xenosoft.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <9ECD27D6-B039-4253-9FB9-749B41DE4CC6@xenosoft.de>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Christian Zigotzky <chzigotzky@xenosoft.de>
Cc: Christoph Hellwig <hch@lst.de>, linux-arch@vger.kernel.org, Darren Stevens <darren@stevens-zone.net>, linux-kernel@vger.kernel.org, Julian Margetson <runaway@candw.ms>, linux-mm@kvack.org, iommu@lists.linux-foundation.org, Paul Mackerras <paulus@samba.org>, Olof Johansson <olof@lixom.net>, linuxppc-dev@lists.ozlabs.org
Message-ID: <20181206193605.-EHNAvSi1_lwwp9TStcipZ8x66Xl6-eUdlmXI5u9cxg@z>

On Thu, Dec 06, 2018 at 06:10:54PM +0100, Christian Zigotzky wrote:
> Please don’t merge this code. We are still testing and trying to figure out where the problems are in the code.

The ones I sent pings for were either tested successfully by you
(the zone change) or are trivial cleanups that don't affect your setup.
