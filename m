From: Yanfei Wang <backyes@gmail.com>
Subject: =?UTF-8?Q?Re=3A_=E3=80=90Question=E3=80=91Whether_it=27s_legal_to_enable_same_?=
	=?UTF-8?Q?physical_DMA_memory_mapped_for_different_NIC_device=3F?=
Date: Thu, 5 Jan 2012 20:40:47 +0800
Message-ID: <CAJULoniAdLbyNUyrCYWbxOWAdB-Re-BxSNb0xfuFD8w6pDETWA@mail.gmail.com>
References: <CAJULonj9rFDKNCzpEXj2r3XjkYojy-CGYpVQ1RF8SxwLVrXqAA@mail.gmail.com>
	<20120103203357.GD17472@phenom.dumpdata.com>
	<CAJULongKix3QXmcoUcraQxCyLN0wz6oe6p5Efg2A7S_r3nO6Fg@mail.gmail.com>
	<1325692766.2758.22.camel@dabdike.int.hansenpartnership.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mail-vw0-f46.google.com ([209.85.212.46]:33066 "EHLO
	mail-vw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751277Ab2AEMks convert rfc822-to-8bit (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Thu, 5 Jan 2012 07:40:48 -0500
In-Reply-To: <1325692766.2758.22.camel@dabdike.int.hansenpartnership.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: James Bottomley <James.Bottomley@hansenpartnership.com>
Cc: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>, linux-pci@vger.kernel.org, linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org

On Wed, Jan 4, 2012 at 11:59 PM, James Bottomley
<James.Bottomley@hansenpartnership.com> wrote:
> On Wed, 2012-01-04 at 10:44 +0800, Yanfei Wang wrote:
>> On Wed, Jan 4, 2012 at 4:33 AM, Konrad Rzeszutek Wilk
>> <konrad.wilk@oracle.com> wrote:
>> > On Wed, Dec 07, 2011 at 10:16:40PM +0800, ustc.mail wrote:
>> >> Dear all,
>> >>
>> >> In NIC driver, to eliminate the =A0overhead of dma_map_single() f=
or DMA
>> >> packet data, =A0we have statically allocated huge DMA memory buff=
er ring
>> >> at once instead of calling dma_map_single() per packet. =A0Consid=
ering
>> >> to further reduce the copy overhead between different NIC(port) r=
ing
>> >> while forwarding, one packet from a input NIC(port) will be
>> >> transferred to output NIC(port) with no any copy action.
>> >>
>> >> To satisfy this requirement, the packet memory should be mapped i=
nto
>> >> input port and unmapped when leaving input port, then mapped into
>> >> output port and unmapped later.
>> >>
>> >> Whether it's legal to map the same DMA memory into input and outp=
ut
>> >> port simultaneously? If it's not, then the zero-copy for packet
>> >> forwarding is not feasible?
>> >>
>> >
>> > Did you ever a get a response about this?
>> No.
>
> This is probably because no-one really understands what you're asking=
=2E
> As far as mapping memory to PCI devices goes, it's the job of the bri=
dge
> (or the iommu which may or may not be part of the bridge). =A0A stand=
ard
> iommu tends not to care about devices and functions, so a range once
> mapped is available to everything behind the bridge. =A0A more secure
> virtualisation based iommu (like the on in VT-D) does, and tends to m=
ap
> ranges per device. =A0I know of none that map per device and function=
, but
> maybe there are.
>
> Your question reads like you have a range of memory mapped to a PCI
> device that you want to use for two different purposes, can you do th=
is?
> to which the answer is that a standard PCI bridge really doesn't care
> and it all depends on the mechanics of the actual device. =A0The only
> wrinkle might be if the two different purposes are on two separate PC=
I
> functions of the device and the iommu does care.
>
>> >
>> > Is the output/input port on a seperate device function? Or is it
>> > just a specific MMIO BAR in your PCI device?
>> >
>> Platform: x86, intel nehalem 8Core NUMA, linux 2.6.39, 10G
>> 82599NIC(two ports per NIC card);
>> Function: Forwarding packets between different ports.
>> Targets: Forwarding packets with Zero-Overhead, despite other obstac=
les.
Besides hardware and OS presented above, more detailed descriptions as =
follows,

When IXGBE driver do initialization, DMA Descriptors Ring Buffers are
allocated statically and mapped as cache coherent. Instead of
dynamically allocating skb buffers for packet data, to reduce the huge
overhead from skb memory allocation, huge Packet data buffers are
pre-allocated and mapped  when driver is loaded. The same strategy  is
done for RX end and TX end.
=46or simple packet forwarding application, one packet from RX should b=
e
replicated from kernel space to userspace, then copied TX end. Here,
One packet at least, should be copied twice to accomplish forwarding.
When doing high performance network application,  the copy action want
to be reduced. If Zero-copy can be done, that's better. (May be you
will find that Zero-copy will bring other obstacles, such as memory
management overhead with high performance. We do not care about it
temporally.)
To achieve this goal, a alternative approach is that,  unmapping the
packets buffer after receiving it from A device, then mapping this
packet buffer to B device. We hope to reduce the two mapping
operation, so one packet DMA buffer should be mapped to A device(NIC
port) as well as B device simultaneously.
Q: Can this come to ture? Is it legal for mmaping operation at this pla=
tform?

Thanks.

Yanfei


>
> This still doesn't really provide the information needed to elucidate
> the question.
>
> James
>
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-arch"=
 in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at =A0http://vger.kernel.org/majordomo-info.html
