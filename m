From: Yanfei Wang <backyes@mail.ustc.edu.cn>
Subject: =?UTF-8?Q?Re=3A_=E3=80=90Question=E3=80=91Whether_it=27s_legal_to_enable_same_?=
	=?UTF-8?Q?physical_DMA_memory_mapped_for_different_NIC_device=3F?=
Date: Fri, 6 Jan 2012 10:05:42 +0800
Message-ID: <CAJULonhqBMLFRLLizhVB1SxR=sWUPTTHFu2=KhEX2sf2GFdV0g@mail.gmail.com>
References: <CAJULonj9rFDKNCzpEXj2r3XjkYojy-CGYpVQ1RF8SxwLVrXqAA@mail.gmail.com>
	<20120103203357.GD17472@phenom.dumpdata.com>
	<CAJULongKix3QXmcoUcraQxCyLN0wz6oe6p5Efg2A7S_r3nO6Fg@mail.gmail.com>
	<1325692766.2758.22.camel@dabdike.int.hansenpartnership.com>
	<CAJULoniAdLbyNUyrCYWbxOWAdB-Re-BxSNb0xfuFD8w6pDETWA@mail.gmail.com>
	<1325780417.2775.6.camel@dabdike.Larkspurhotels.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from smtp2.ustc.edu.cn ([202.38.64.46]:39151 "HELO ustc.edu.cn"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with SMTP
	id S1758437Ab2AFCFv convert rfc822-to-8bit (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Thu, 5 Jan 2012 21:05:51 -0500
In-Reply-To: <1325780417.2775.6.camel@dabdike.Larkspurhotels.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: James Bottomley <James.Bottomley@hansenpartnership.com>
Cc: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>, linux-pci@vger.kernel.org, linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org

On Fri, Jan 6, 2012 at 12:20 AM, James Bottomley
<James.Bottomley@hansenpartnership.com> wrote:
> On Thu, 2012-01-05 at 20:40 +0800, Yanfei Wang wrote:
>> On Wed, Jan 4, 2012 at 11:59 PM, James Bottomley
>> <James.Bottomley@hansenpartnership.com> wrote:
>> > On Wed, 2012-01-04 at 10:44 +0800, Yanfei Wang wrote:
>> >> On Wed, Jan 4, 2012 at 4:33 AM, Konrad Rzeszutek Wilk
>> >> <konrad.wilk@oracle.com> wrote:
>> >> > On Wed, Dec 07, 2011 at 10:16:40PM +0800, ustc.mail wrote:
>> >> >> Dear all,
>> >> >>
>> >> >> In NIC driver, to eliminate the =A0overhead of dma_map_single(=
) for DMA
>> >> >> packet data, =A0we have statically allocated huge DMA memory b=
uffer ring
>> >> >> at once instead of calling dma_map_single() per packet. =A0Con=
sidering
>> >> >> to further reduce the copy overhead between different NIC(port=
) ring
>> >> >> while forwarding, one packet from a input NIC(port) will be
>> >> >> transferred to output NIC(port) with no any copy action.
>> >> >>
>> >> >> To satisfy this requirement, the packet memory should be mappe=
d into
>> >> >> input port and unmapped when leaving input port, then mapped i=
nto
>> >> >> output port and unmapped later.
>> >> >>
>> >> >> Whether it's legal to map the same DMA memory into input and o=
utput
>> >> >> port simultaneously? If it's not, then the zero-copy for packe=
t
>> >> >> forwarding is not feasible?
>> >> >>
>> >> >
>> >> > Did you ever a get a response about this?
>> >> No.
>> >
>> > This is probably because no-one really understands what you're ask=
ing.
>> > As far as mapping memory to PCI devices goes, it's the job of the =
bridge
>> > (or the iommu which may or may not be part of the bridge). =A0A st=
andard
>> > iommu tends not to care about devices and functions, so a range on=
ce
>> > mapped is available to everything behind the bridge. =A0A more sec=
ure
>> > virtualisation based iommu (like the on in VT-D) does, and tends t=
o map
>> > ranges per device. =A0I know of none that map per device and funct=
ion, but
>> > maybe there are.
>> >
>> > Your question reads like you have a range of memory mapped to a PC=
I
>> > device that you want to use for two different purposes, can you do=
 this?
>> > to which the answer is that a standard PCI bridge really doesn't c=
are
>> > and it all depends on the mechanics of the actual device. =A0The o=
nly
>> > wrinkle might be if the two different purposes are on two separate=
 PCI
>> > functions of the device and the iommu does care.
>> >
>> >> >
>> >> > Is the output/input port on a seperate device function? Or is i=
t
>> >> > just a specific MMIO BAR in your PCI device?
>> >> >
>> >> Platform: x86, intel nehalem 8Core NUMA, linux 2.6.39, 10G
>> >> 82599NIC(two ports per NIC card);
>> >> Function: Forwarding packets between different ports.
>> >> Targets: Forwarding packets with Zero-Overhead, despite other obs=
tacles.
>> Besides hardware and OS presented above, more detailed descriptions =
as follows,
>>
>> When IXGBE driver do initialization, DMA Descriptors Ring Buffers ar=
e
>> allocated statically and mapped as cache coherent. Instead of
>> dynamically allocating skb buffers for packet data, to reduce the hu=
ge
>> overhead from skb memory allocation, huge Packet data buffers are
>> pre-allocated and mapped =A0when driver is loaded. The same strategy=
 =A0is
>> done for RX end and TX end.
>> For simple packet forwarding application, one packet from RX should =
be
>> replicated from kernel space to userspace, then copied TX end. Here,
>> One packet at least, should be copied twice to accomplish forwarding=
=2E
>> When doing high performance network application, =A0the copy action =
want
>> to be reduced. If Zero-copy can be done, that's better. (May be you
>> will find that Zero-copy will bring other obstacles, such as memory
>> management overhead with high performance. We do not care about it
>> temporally.)
>> To achieve this goal, a alternative approach is that, =A0unmapping t=
he
>> packets buffer after receiving it from A device, then mapping this
>> packet buffer to B device. We hope to reduce the two mapping
>> operation, so one packet DMA buffer should be mapped to A device(NIC
>> port) as well as B device simultaneously.
>> Q: Can this come to ture? Is it legal for mmaping operation at this =
platform?
>
> But you still haven't answered the question upon which all this depen=
ds.
> Let me make it simple. =A0In PCI terms are A and B
>
> =A0 =A0 I. Same Device, Same Function
> =A0 =A0II. Same Device, Different Function
> =A0 III. Different Devices
$lspci
09:00.0 Ethernet controller: Intel Corporation 82599EB 10-Gigabit
Network Connection (rev 01)
09:00.1 Ethernet controller: Intel Corporation 82599EB 10-Gigabit
Network Connection (rev 01)
Here, only one physical 10G NIC device, which contains two 10G ports.
So, the information list above shows that one port correspond one
function.
If forwarding packet between two ports, then A,B are different function=
s.
Otherwise, A,B are different devices if forwarding packets between two
physical NIC device. Is it right?
The OS is built on bare-metal hardware, no kvm, no xen, no VT.

Thanks.
>
> ?
>
> James
>
>
