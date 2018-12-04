From: Christian Zigotzky <chzigotzky@xenosoft.de>
Subject: Re: use generic DMA mapping code in powerpc V4
Date: Tue, 4 Dec 2018 10:53:39 +0100
Message-ID: <58c61afb-290f-6196-c72c-ac7b61b84718@xenosoft.de>
References: <20181114082314.8965-1-hch@lst.de> <20181127074253.GB30186@lst.de>
 <87zhttfonk.fsf@concordia.ellerman.id.au>
 <4d4e3cdd-d1a9-affe-0f63-45b8c342bbd6@xenosoft.de>
 <20181129170351.GC27951@lst.de>
 <d0e04a85-f17d-414e-6fea-971414417430@xenosoft.de>
 <20181130105346.GB26765@lst.de>
 <8694431d-c669-b7b9-99fa-e99db5d45a7d@xenosoft.de>
 <20181130131056.GA5211@lst.de>
 <25999587-2d91-a63c-ed38-c3fb0075d9f1@xenosoft.de>
 <c5202d29-863d-1377-0e2d-762203b317e2@xenosoft.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <c5202d29-863d-1377-0e2d-762203b317e2@xenosoft.de>
Content-Language: de-DE
Sender: linux-kernel-owner@vger.kernel.org
To: Christoph Hellwig <hch@lst.de>
Cc: linux-arch@vger.kernel.org, Darren Stevens <darren@stevens-zone.net>, linux-kernel@vger.kernel.org, Julian Margetson <runaway@candw.ms>, linux-mm@kvack.org, iommu@lists.linux-foundation.org, Paul Mackerras <paulus@samba.org>, Olof Johansson <olof@lixom.net>, linuxppc-dev@lists.ozlabs.org
List-Id: linux-arch.vger.kernel.org

On 04 December 2018 at 08:31AM, Christian Zigotzky wrote:
> Hi All,
>
> Could you please test Christoph's kernel on your PASEMI and NXP 
> boards? Download:
>
> 'git clone git://git.infradead.org/users/hch/misc.git -b powerpc-dma.5 a'
>
> Thanks,
> Christian
>
I successfully tested this kernel on a virtual e5500 QEMU machine today.

Command: ./qemu-system-ppc64 -M ppce500 -cpu e5500 -m 2048 -kernel 
uImage-dma -drive 
format=raw,file=MATE_PowerPC_Remix_2017_0.9.img,index=0,if=virtio -nic 
user,model=e1000 -append "rw root=/dev/vda" -device virtio-vga -device 
virtio-mouse-pci -device virtio-keyboard-pci -usb -soundhw es1370 -smp 4

QEMU version 3.1.0.

I don't know why this kernel doesn't recognize the hard disks connected 
to my physical P5020 board and why the onboard ethernet on my PASEMI 
board doesn't work. (dma_direct_map_page: overflow)

-- Christian
