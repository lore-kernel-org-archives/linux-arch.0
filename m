Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from verein.lst.de ([213.95.11.211]:44035 "EHLO newverein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726565AbeLDOY2 (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Tue, 4 Dec 2018 09:24:28 -0500
Date: Tue, 4 Dec 2018 15:24:26 +0100
From: Christoph Hellwig <hch@lst.de>
Subject: Re: use generic DMA mapping code in powerpc V4
Message-ID: <20181204142426.GA2743@lst.de>
References: <87zhttfonk.fsf@concordia.ellerman.id.au> <4d4e3cdd-d1a9-affe-0f63-45b8c342bbd6@xenosoft.de> <20181129170351.GC27951@lst.de> <d0e04a85-f17d-414e-6fea-971414417430@xenosoft.de> <20181130105346.GB26765@lst.de> <8694431d-c669-b7b9-99fa-e99db5d45a7d@xenosoft.de> <20181130131056.GA5211@lst.de> <25999587-2d91-a63c-ed38-c3fb0075d9f1@xenosoft.de> <c5202d29-863d-1377-0e2d-762203b317e2@xenosoft.de> <58c61afb-290f-6196-c72c-ac7b61b84718@xenosoft.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <58c61afb-290f-6196-c72c-ac7b61b84718@xenosoft.de>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Christian Zigotzky <chzigotzky@xenosoft.de>
Cc: Christoph Hellwig <hch@lst.de>, linux-arch@vger.kernel.org, Darren Stevens <darren@stevens-zone.net>, linux-kernel@vger.kernel.org, Julian Margetson <runaway@candw.ms>, linux-mm@kvack.org, iommu@lists.linux-foundation.org, Paul Mackerras <paulus@samba.org>, Olof Johansson <olof@lixom.net>, linuxppc-dev@lists.ozlabs.org
Message-ID: <20181204142426.sM4rSELAR4NkHA-6SNnPlQvD83774ZjwpoDtrHZS5hY@z>

On Tue, Dec 04, 2018 at 10:53:39AM +0100, Christian Zigotzky wrote:
> I don't know why this kernel doesn't recognize the hard disks connected to 
> my physical P5020 board and why the onboard ethernet on my PASEMI board 
> doesn't work. (dma_direct_map_page: overflow)

Do you know if this actually works for the baseline before my patches?
E.g. with commit 721c01ba8b46ddb5355bd6e6b3bbfdabfdf01e97 ?
