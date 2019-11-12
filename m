Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mo4-p01-ob.smtp.rzone.de ([85.215.255.50]:13368 "EHLO
        mo4-p01-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726910AbfKLW6a (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 12 Nov 2019 17:58:30 -0500
Subject: Re: Bug 205201 - overflow of DMA mask and bus mask
References: <71A251A5-FA06-4019-B324-7AED32F7B714@xenosoft.de>
 <1b0c5c21-2761-d3a3-651b-3687bb6ae694@xenosoft.de>
 <3504ee70-02de-049e-6402-2d530bf55a84@xenosoft.de>
 <46025f1b-db20-ac23-7dcd-10bc43bbb6ee@xenosoft.de>
 <20191105162856.GA15402@lst.de>
 <2f3c81bd-d498-066a-12c0-0a7715cda18f@xenosoft.de>
 <d2c614ec-c56e-3ec2-12d0-7561cd30c643@xenosoft.de>
 <af32bfcc-5559-578d-e1f4-75e454c965bf@xenosoft.de>
 <0c5a8009-d28b-601f-3d1a-9de0e869911c@xenosoft.de>
 <a794864f-04ae-9b90-50e7-01b416c861fe@xenosoft.de>
 <20191112144109.GA11805@lst.de>
From: Christian Zigotzky <chzigotzky@xenosoft.de>
Message-ID: <288d3c11-725b-ecdd-2495-b4a69aafb693@xenosoft.de>
Date: Tue, 12 Nov 2019 23:58:22 +0100
MIME-Version: 1.0
In-Reply-To: <20191112144109.GA11805@lst.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: de-DE
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Christoph Hellwig <hch@lst.de>
Cc: linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org, linux-mm@kvack.org, iommu@lists.linux-foundation.org, Benjamin Herrenschmidt <benh@kernel.crashing.org>, paulus@samba.org, darren@stevens-zone.net, "contact@a-eon.com" <contact@a-eon.com>, rtd2@xtra.co.nz, mad skateman <madskateman@gmail.com>, Rob Herring <robh+dt@kernel.org>, linuxppc-dev <linuxppc-dev@lists.ozlabs.org>, nsaenzjulienne@suse.de
Message-ID: <20191112225822.MPCHl0nmpShQeZw_zLcJgpDeFVJnBsJELv3mj3JMpNg@z>

On 12 November 2019 at 3:41 pm, Christoph Hellwig wrote:
> On Mon, Nov 11, 2019 at 01:22:55PM +0100, Christian Zigotzky wrote:
>> Now, I can definitely say that this patch does not solve the issue.
>>
>> Do you have another patch for testing or shall I bisect?
> I'm still interested in the .config and dmesg.  Especially if the
> board is using arch/powerpc/sysdev/fsl_pci.c, which is the only
> place inside the powerpc arch code doing funny things with the
> bus_dma_mask, which Robin pointed out looks fishy.
>
Here you are:

.config: https://bugzilla.kernel.org/attachment.cgi?id=285815

dmesg: https://bugzilla.kernel.org/attachment.cgi?id=285813

Thanks
