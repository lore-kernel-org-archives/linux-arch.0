From: Christian Zigotzky <chzigotzky@xenosoft.de>
Subject: Re: use generic DMA mapping code in powerpc V4
Date: Tue, 15 Jan 2019 14:56:34 +0100
Message-ID: <685f0c06-af1b-0bec-ac03-f9bf1f7a2b35@xenosoft.de>
References: <008c981e-bdd2-21a7-f5f7-c57e4850ae9a@xenosoft.de>
 <20190103073622.GA24323@lst.de>
 <71A251A5-FA06-4019-B324-7AED32F7B714@xenosoft.de>
 <1b0c5c21-2761-d3a3-651b-3687bb6ae694@xenosoft.de>
 <3504ee70-02de-049e-6402-2d530bf55a84@xenosoft.de>
 <23284859-bf0a-9cd5-a480-2a7fd7802056@xenosoft.de>
 <075f70e3-7a4a-732f-b501-05a1a8e3c853@xenosoft.de>
 <b04d08ea-61f9-3212-b9a3-ad79e3b8bd05@xenosoft.de>
 <21f72a6a-9095-7034-f169-95e876228b2a@xenosoft.de>
 <27148ac2-2a92-5536-d886-2c0971ab43d9@xenosoft.de>
 <20190115133558.GA29225@lst.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190115133558.GA29225@lst.de>
Content-Language: de-DE
Sender: linux-kernel-owner@vger.kernel.org
To: Christoph Hellwig <hch@lst.de>
Cc: linux-arch@vger.kernel.org, Darren Stevens <darren@stevens-zone.net>, linux-kernel@vger.kernel.org, Julian Margetson <runaway@candw.ms>, linux-mm@kvack.org, iommu@lists.linux-foundation.org, Paul Mackerras <paulus@samba.org>, Olof Johansson <olof@lixom.net>, linuxppc-dev@lists.ozlabs.org
List-Id: linux-arch.vger.kernel.org

On 15 January 2019 at 2:35PM, Christoph Hellwig wrote:
> On Tue, Jan 15, 2019 at 11:55:25AM +0100, Christian Zigotzky wrote:
>> Next step: 21074ef03c0816ae158721a78cabe9035938dddd (powerpc/dma: use the
>> generic direct mapping bypass)
>>
>> git clone git://git.infradead.org/users/hch/misc.git -b powerpc-dma.6 a
>>
>> git checkout 21074ef03c0816ae158721a78cabe9035938dddd
>>
>> I was able to compile the kernel for the AmigaOne X1000 (Nemo board with PA
>> Semi PA6T-1682M SoC). It boots but the PA Semi onboard ethernet doesn't
>> work.
> Thanks.  But we are exactly missing the steps that are relevant.  I've
> pushed a fixed up powerpc-dma.6 tree, which will only change starting from
> the first commit that didn't link.
>
> The first commit that changed from the old one is this one:
>
> http://git.infradead.org/users/hch/misc.git/commitdiff/257002094bc5935dd63207a380d9698ab81f0775
>
> which was that one that your compile failed on first.
>
> Thanks again for all your work!
>
Thank you! I tried the commit 240d7ecd7f6fa62e074e8a835e620047954f0b28 
(powerpc/dma: use the dma-direct allocator for coherent platforms) again.

git clone git://git.infradead.org/users/hch/misc.git -b powerpc-dma.6 a

git checkout 240d7ecd7f6fa62e074e8a835e620047954f0b28

I modified the 'dma.c' patch because of the undefined references to 
'__dma_nommu_free_coherent' and '__dma_nommu_alloc_coherent':

---

@@ -163,8 +99,13 @@ static inline void dma_nommu_sync_single(struct 
device *dev,
  #endif

  const struct dma_map_ops dma_nommu_ops = {
+       .alloc                          = dma_direct_alloc,
+       .free                           = dma_direct_free,
         .map_sg                         = dma_nommu_map_sg,
         .unmap_sg                       = dma_nommu_unmap_sg,
         .dma_supported                  = dma_direct_supported,

---

The X1000 boots and the PASEMI onboard ethernet works! X5000 (P5020 
board): U-Boot loads the kernel and the dtb file. Then the kernel starts 
but it doesn't find any hard disks (partitions).

-- Christian
