Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mo4-p01-ob.smtp.rzone.de ([85.215.255.53]:23561 "EHLO
        mo4-p01-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726002AbfBJMAa (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Sun, 10 Feb 2019 07:00:30 -0500
Subject: Re: use generic DMA mapping code in powerpc V4
References: <9632DCDF-B9D9-416C-95FC-006B6005E2EC@xenosoft.de>
 <594beaae-9681-03de-9f42-191cc7d2f8e3@xenosoft.de>
 <20190204075616.GA5408@lst.de>
 <ffbf56ae-c259-47b5-9deb-7fb21fead254@xenosoft.de>
 <20190204123852.GA10428@lst.de>
 <b1c0161f-4211-03af-022d-0db7237516e9@xenosoft.de>
 <20190206151505.GA31065@lst.de> <20190206151655.GA31172@lst.de>
 <61EC67B1-12EF-42B6-B69B-B59F9E4FC474@xenosoft.de>
 <7c1f208b-6909-3b0a-f9f9-38ff1ac3d617@xenosoft.de>
 <20190208091818.GA23491@lst.de>
From: Christian Zigotzky <chzigotzky@xenosoft.de>
Message-ID: <4e7137db-e600-0d20-6fb2-6d0f9739aca3@xenosoft.de>
Date: Sun, 10 Feb 2019 13:00:20 +0100
MIME-Version: 1.0
In-Reply-To: <20190208091818.GA23491@lst.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: de-DE
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Christoph Hellwig <hch@lst.de>
Cc: linux-arch@vger.kernel.org, Darren Stevens <darren@stevens-zone.net>, linux-kernel@vger.kernel.org, Julian Margetson <runaway@candw.ms>, linux-mm@kvack.org, iommu@lists.linux-foundation.org, Paul Mackerras <paulus@samba.org>, Olof Johansson <olof@lixom.net>, linuxppc-dev@lists.ozlabs.org
Message-ID: <20190210120020.jhnGQZD8jcUVCj07XbYO4cO6vekfgsWkCG-4zZXPMMU@z>

Hi Christoph,

On 08 February 2019 at 10:18AM, Christoph Hellwig wrote:
> On Fri, Feb 08, 2019 at 10:01:46AM +0100, Christian Zigotzky wrote:
>> Hi Christoph,
>>
>> Your new patch fixes the problems with the P.A. Semi Ethernet! :-)
> Thanks a lot once again for testing!
>
> Now can you test with this patch and the whole series?
>
> I've updated the powerpc-dma.6 branch to include this fix.
>
I tested the whole series today. The kernels boot and the P.A. Semi 
Ethernet works! :-) Thanks a lot!

I also tested it in a virtual e5500 QEMU machine today. Unfortunately 
the kernel crashes.

Log:

[   54.624330] BUG: Unable to handle kernel data access at 
0xc06c008a0013014a
[   54.625640] Faulting instruction address: 0xc000000000027e7c
[   54.626140] Oops: Kernel access of bad area, sig: 11 [#1]
[   54.626456] BE SMP NR_CPUS=4 QEMU e500
[   54.626876] Modules linked in:
[   54.627284] CPU: 1 PID: 1876 Comm: systemd-journal Not tainted 
5.0.0-rc5-DMA_A1-X5000-54581-gda1d065-dirty #1
[   54.627819] NIP:  c000000000027e7c LR: c0000000000b5264 CTR: 
0000000000000000
[   54.628173] REGS: c00000007ffeb700 TRAP: 0300   Not tainted 
(5.0.0-rc5-DMA_A1-X5000-54581-gda1d065-dirty)
[   54.628607] MSR:  0000000080009000 <EE,ME>  CR: 44008486 XER: 00000000
[   54.629023] DEAR: c06c008a0013014a ESR: 0000000000800000 IRQMASK: 0
[   54.629023] GPR00: 0000000000005254 c00000007ffeb990 c0000000016b2000 
c06c008a0013014a
[   54.629023] GPR04: c00000007c54f8c0 0000000000000058 0000000000000006 
0000000000000000
[   54.629023] GPR08: 0000000000000000 000000007c54f8c0 006c008a0013014a 
c00000007c86c000
[   54.629023] GPR12: 0000000028002482 c00000003ffff8c0 0000000000000000 
c000000078dfaa70
[   54.629023] GPR16: c000000078366c00 0000000000000000 000000000000005e 
0000000000000000
[   54.629023] GPR20: 0000000000000000 c00000007c54f8c0 0000000000000007 
c000000078dfa000
[   54.629023] GPR24: 0000000000000000 0000000000000047 0000000000000000 
80000000003f6470
[   54.629023] GPR28: c00000007928d470 c000000078801dc0 000000000000005e 
c000000078dfa7c0
[   54.632572] NIP [c000000000027e7c] .memcpy+0x1fc/0x288
[   54.632886] LR [c0000000000b5264] .swiotlb_tbl_sync_single+0xb0/0xe4
[   54.633221] Call Trace:
[   54.633513] [c00000007ffeb990] [c00000007ffeba70] 0xc00000007ffeba70 
(unreliable)
[   54.633988] [c00000007ffeba00] [c0000000000b41e4] 
.dma_direct_sync_single_for_cpu+0x58/0x6c
[   54.634436] [c00000007ffeba70] [c000000000788da4] 
.e1000_clean_rx_irq+0x1bc/0x4c8
[   54.634857] [c00000007ffebb90] [c00000000078667c] 
.e1000_clean+0x714/0x8d4
[   54.635263] [c00000007ffebcc0] [c000000000a3f15c] 
.net_rx_action+0x11c/0x2a4
[   54.635712] [c00000007ffebdb0] [c000000000c48c20] 
.__do_softirq+0x150/0x2a8
[   54.636211] [c00000007ffebeb0] [c000000000064184] .irq_exit+0x6c/0xc4
[   54.636533] [c00000007ffebf20] [c000000000004124] .__do_irq+0x80/0x94
[   54.636985] [c00000007ffebf90] [c00000000000eca0] .call_do_irq+0x14/0x24
[   54.637371] [c00000007c86fd80] [c0000000000041c0] .do_IRQ+0x88/0xc4
[   54.637737] [c00000007c86fe20] [c000000000012920] 
exc_0x500_common+0xd8/0xdc
[   54.638104] Instruction dump:
[   54.638451] e861fff8 4e800020 7cd01120 7ca62850 38e00000 28a50010 
409f0010 88040000
[   54.638887] 98030000 38e70001 409e0010 7c07222e <7c071b2e> 38e70002 
409d000c 7c07202e
[   54.639594] ---[ end trace a4861de7e4c199f7 ]---
[   54.639873]
[   55.640484] Kernel panic - not syncing: Aiee, killing interrupt handler!
[   55.641556] Rebooting in 180 seconds..

-----

I tested with the following QEMU commands:

./qemu-system-ppc64 -M ppce500 -cpu e5500 -m 2048  -nographic -kernel 
/home/christian/Downloads/vmlinux-5.0-rc5-2-AmigaOne_X1000_X5000/X5000_and_QEMU_e5500/uImage-5.0 
-nic user,model=e1000 -drive 
format=raw,file=/home/christian/Downloads/MATE_PowerPC_Remix_2017_0.9.img,index=0,if=virtio 
-append "rw root=/dev/vda" -smp 4

./qemu-system-ppc64 -M ppce500 -cpu e5500 -m 2048 -kernel 
/home/christian/Downloads/vmlinux-5.0-rc5-2-AmigaOne_X1000_X5000/X5000_and_QEMU_e5500/uImage-5.0 
-drive 
format=raw,file=/home/christian/Downloads/MATE_PowerPC_Remix_2017_0.9.img,index=0,if=virtio 
-nic user,model=e1000 -append "rw root=/dev/vda" -device virtio-vga 
-device virtio-mouse-pci -device virtio-keyboard-pci -usb -soundhw 
es1370 -smp 4

The RC5 of kernel 5.0 boots without any problems in this virtual machine.

Cheers,
Christian
