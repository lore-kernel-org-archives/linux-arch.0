From: Christian Zigotzky <chzigotzky@xenosoft.de>
Subject: Re: use generic DMA mapping code in powerpc V4
Date: Wed, 9 Jan 2019 10:31:33 +0100
Message-ID: <3504ee70-02de-049e-6402-2d530bf55a84@xenosoft.de>
References: <2242B4B2-6311-492E-BFF9-6740E36EC6D4@xenosoft.de>
 <84558d7f-5a7f-5219-0c3a-045e6b4c494f@xenosoft.de>
 <20181213091021.GA2106@lst.de>
 <835bd119-081e-a5ea-1899-189d439c83d6@xenosoft.de>
 <76bc684a-b4d2-1d26-f18d-f5c9ba65978c@xenosoft.de>
 <20181213112511.GA4574@lst.de>
 <e109de27-f4af-147d-dc0e-067c8bafb29b@xenosoft.de>
 <ad5a5a8a-d232-d523-a6f7-e9377fc3857b@xenosoft.de>
 <e60d6ca3-860c-f01d-8860-c5e022ec7179@xenosoft.de>
 <008c981e-bdd2-21a7-f5f7-c57e4850ae9a@xenosoft.de>
 <20190103073622.GA24323@lst.de>
 <71A251A5-FA06-4019-B324-7AED32F7B714@xenosoft.de>
 <1b0c5c21-2761-d3a3-651b-3687bb6ae694@xenosoft.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1b0c5c21-2761-d3a3-651b-3687bb6ae694@xenosoft.de>
Content-Language: de-DE
Sender: linux-kernel-owner@vger.kernel.org
To: Christoph Hellwig <hch@lst.de>
Cc: linux-arch@vger.kernel.org, Darren Stevens <darren@stevens-zone.net>, linux-kernel@vger.kernel.org, Julian Margetson <runaway@candw.ms>, linux-mm@kvack.org, iommu@lists.linux-foundation.org, Paul Mackerras <paulus@samba.org>, Olof Johansson <olof@lixom.net>, linuxppc-dev@lists.ozlabs.org
List-Id: linux-arch.vger.kernel.org

Next step: a64e18ba191ba9102fb174f27d707485ffd9389c (powerpc/dma: remove 
dma_nommu_get_required_mask)

git clone git://git.infradead.org/users/hch/misc.git -b powerpc-dma.6 a

git checkout a64e18ba191ba9102fb174f27d707485ffd9389c

Link to the Git: 
http://git.infradead.org/users/hch/misc.git/shortlog/refs/heads/powerpc-dma.6

Results: PASEMI onboard ethernet works and the X5000 (P5020 board) 
boots. I also successfully tested sound, hardware 3D acceleration, 
Bluetooth, network, booting with a label etc. The uImages work also in a 
virtual e5500 quad-core QEMU machine.

-- Christian


On 05 January 2019 at 5:03PM, Christian Zigotzky wrote:
> Next step: c446404b041130fbd9d1772d184f24715cf2362f (powerpc/dma: 
> remove dma_nommu_mmap_coherent)
>
> git clone git://git.infradead.org/users/hch/misc.git -b powerpc-dma.6 a
>
> git checkout c446404b041130fbd9d1772d184f24715cf2362f
>
> Output:
>
> Note: checking out 'c446404b041130fbd9d1772d184f24715cf2362f'.
>
> You are in 'detached HEAD' state. You can look around, make experimental
> changes and commit them, and you can discard any commits you make in this
> state without impacting any branches by performing another checkout.
>
> If you want to create a new branch to retain commits you create, you may
> do so (now or later) by using -b with the checkout command again. 
> Example:
>
>   git checkout -b <new-branch-name>
>
> HEAD is now at c446404... powerpc/dma: remove dma_nommu_mmap_coherent
>
> -----
>
> Link to the Git: 
> http://git.infradead.org/users/hch/misc.git/shortlog/refs/heads/powerpc-dma.6
>
> Result: PASEMI onboard ethernet works and the X5000 (P5020 board) boots.
>
> -- Christian
>
