Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from verein.lst.de ([213.95.11.211]:34231 "EHLO newverein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726223AbeLLOP6 (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Wed, 12 Dec 2018 09:15:58 -0500
Date: Wed, 12 Dec 2018 15:15:56 +0100
From: Christoph Hellwig <hch@lst.de>
Subject: Re: use generic DMA mapping code in powerpc V4
Message-ID: <20181212141556.GA4801@lst.de>
References: <1948cf84-49ab-543c-472c-d18e27751903@xenosoft.de> <5a2ea855-b4b0-e48a-5c3e-c859a8451ca2@xenosoft.de> <7B6DDB28-8BF6-4589-84ED-F1D4D13BFED6@xenosoft.de> <8a2c4581-0c85-8065-f37e-984755eb31ab@xenosoft.de> <424bb228-c9e5-6593-1ab7-5950d9b2bd4e@xenosoft.de> <c86d76b4-b199-557e-bc64-4235729c1e72@xenosoft.de> <1ecb7692-f3fb-a246-91f9-2db1b9496305@xenosoft.de> <6c997c03-e072-97a9-8ae0-38a4363df919@xenosoft.de> <4cfb3f26-74e1-db01-b014-759f188bb5a6@xenosoft.de> <82879d3f-83de-6438-c1d6-49c571dcb671@xenosoft.de>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="Qxx1br4bt0+wmkIi"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <82879d3f-83de-6438-c1d6-49c571dcb671@xenosoft.de>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Christian Zigotzky <chzigotzky@xenosoft.de>
Cc: Christoph Hellwig <hch@lst.de>, linux-arch@vger.kernel.org, Darren Stevens <darren@stevens-zone.net>, linux-kernel@vger.kernel.org, Julian Margetson <runaway@candw.ms>, linux-mm@kvack.org, iommu@lists.linux-foundation.org, Paul Mackerras <paulus@samba.org>, Olof Johansson <olof@lixom.net>, linuxppc-dev@lists.ozlabs.org
Message-ID: <20181212141556.KAfI-GMk957SRXOkWEgAPOHq19kT8wtPvCndYdTvjQs@z>


--Qxx1br4bt0+wmkIi
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit

Thanks for bisecting.  I've spent some time going over the conversion
but can't really pinpoint it.  I have three little patches that switch
parts of the code to the generic version.  This is on top of the
last good commmit (977706f9755d2d697aa6f45b4f9f0e07516efeda).

Can you check with whіch one things stop working?



--Qxx1br4bt0+wmkIi
Content-Type: text/x-patch; charset=us-ascii
Content-Disposition: attachment; filename="0001-get_required_mask.patch"


--Qxx1br4bt0+wmkIi--
