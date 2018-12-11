From: Christian Zigotzky <chzigotzky@xenosoft.de>
Subject: Re: use generic DMA mapping code in powerpc V4
Date: Tue, 11 Dec 2018 19:17:05 +0100
Message-ID: <82879d3f-83de-6438-c1d6-49c571dcb671@xenosoft.de>
References: <20181129170351.GC27951@lst.de>
 <d0e04a85-f17d-414e-6fea-971414417430@xenosoft.de>
 <20181130105346.GB26765@lst.de>
 <8694431d-c669-b7b9-99fa-e99db5d45a7d@xenosoft.de>
 <20181130131056.GA5211@lst.de>
 <25999587-2d91-a63c-ed38-c3fb0075d9f1@xenosoft.de>
 <c5202d29-863d-1377-0e2d-762203b317e2@xenosoft.de>
 <58c61afb-290f-6196-c72c-ac7b61b84718@xenosoft.de>
 <20181204142426.GA2743@lst.de>
 <ef56d279-f75d-008e-71ba-7068c1b37c48@xenosoft.de>
 <20181205140550.GA27549@lst.de>
 <1948cf84-49ab-543c-472c-d18e27751903@xenosoft.de>
 <5a2ea855-b4b0-e48a-5c3e-c859a8451ca2@xenosoft.de>
 <7B6DDB28-8BF6-4589-84ED-F1D4D13BFED6@xenosoft.de>
 <8a2c4581-0c85-8065-f37e-984755eb31ab@xenosoft.de>
 <424bb228-c9e5-6593-1ab7-5950d9b2bd4e@xenosoft.de>
 <c86d76b4-b199-557e-bc64-4235729c1e72@xenosoft.de>
 <1ecb7692-f3fb-a246-91f9-2db1b9496305@xenosoft.de>
 <6c997c03-e072-97a9-8ae0-38a4363df919@xenosoft.de>
 <4cfb3f26-74e1-db01-b014-759f188bb5a6@xenosoft.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <4cfb3f26-74e1-db01-b014-759f188bb5a6@xenosoft.de>
Content-Language: de-DE
Sender: linux-kernel-owner@vger.kernel.org
To: Christoph Hellwig <hch@lst.de>
Cc: linux-arch@vger.kernel.org, Darren Stevens <darren@stevens-zone.net>, linux-kernel@vger.kernel.org, Julian Margetson <runaway@candw.ms>, linux-mm@kvack.org, iommu@lists.linux-foundation.org, Paul Mackerras <paulus@samba.org>, Olof Johansson <olof@lixom.net>, linuxppc-dev@lists.ozlabs.org
List-Id: linux-arch.vger.kernel.org

Next step: 7decbcfc656805603ab97206b3f816f26cd2cf7d (powerpc/dma: use 
generic direct and swiotlb ops)

git checkout 7decbcfc656805603ab97206b3f816f26cd2cf7d

We have the bad commit! :-) The PASEMI onboard ethernet doesn't work 
with this commit anymore.

Error messages:

[  367.627623] pci 0000:00:1a.0: dma_direct_map_page: overflow 
0x000000026bcb5002+110 of device mask ffffffff bus mask 0
[  367.627631] pci 0000:00:1a.0: dma_direct_map_page: overflow 
0x000000026bcb5002+110 of device mask ffffffff bus mask 0
[  367.627639] pci 0000:00:1a.0: dma_direct_map_page: overflow 
0x000000026bcb5002+110 of device mask ffffffff bus mask 0
[  367.627647] pci 0000:00:1a.0: dma_direct_map_page: overflow 
0x000000026bcb5002+110 of device mask ffffffff bus mask 0

pci 0000:00:1a.0 = 00:1a.0 DMA controller: PA Semi, Inc PWRficient DMA 
Controller (rev 12)

X5000 (P5020 board): U-Boot loads the kernel and the dtb file. Then the 
kernel starts but it doesn't find any hard disks (partitions). That 
means this is also the bad commit for the P5020 board.

Link to the bad commit: 
http://git.infradead.org/users/hch/misc.git/commit/7decbcfc656805603ab97206b3f816f26cd2cf7d

Link to the Git: 
http://git.infradead.org/users/hch/misc.git/shortlog/refs/heads/powerpc-dma.5

The commit before (977706f9755d2d697aa6f45b4f9f0e07516efeda - 
powerpc/dma: remove dma_nommu_mmap_coherent) works without any problems.

-- Christian
