From: Yinghai Lu <yinghai@kernel.org>
Subject: Re: [PATCH 01/24] PCI: Add iobusn_resource
Date: Fri, 10 Feb 2012 15:40:53 -0800
Message-ID: <CAE9FiQXvzHM4a=u5PDbRkKEo5EC8c7VaZZgQ8wyTjveegf=7dA@mail.gmail.com>
References: <1328425088-6562-1-git-send-email-yinghai@kernel.org>
	<1328425088-6562-2-git-send-email-yinghai@kernel.org>
	<CAErSpo4HJH+3EQAWowyVxZFa5jVy1EOo=SoybJqqcjhVdo0nzw@mail.gmail.com>
	<CAE9FiQXeRGXE2RCe5S1iOE=QY37wauM=WUevjXWkMqMOjV3t7A@mail.gmail.com>
	<20120210125150.3353237c@jbarnes-desktop>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mail-yx0-f174.google.com ([209.85.213.174]:42624 "EHLO
	mail-yx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754665Ab2BJXky convert rfc822-to-8bit (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Fri, 10 Feb 2012 18:40:54 -0500
In-Reply-To: <20120210125150.3353237c@jbarnes-desktop>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Jesse Barnes <jbarnes@virtuousgeek.org>
Cc: Bjorn Helgaas <bhelgaas@google.com>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Tony Luck <tony.luck@intel.com>, Dominik Brodowski <linux@dominikbrodowski.net>, Andrew Morton <akpm@linux-foundation.org>, Linus Torvalds <torvalds@linux-foundation.org>, Greg Kroah-Hartman <gregkh@suse.de>, linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org

On Fri, Feb 10, 2012 at 12:51 PM, Jesse Barnes <jbarnes@virtuousgeek.or=
g> wrote:
> On Mon, 6 Feb 2012 10:55:14 -0800
> Yinghai Lu <yinghai@kernel.org> wrote:
>
>> On Mon, Feb 6, 2012 at 10:48 AM, Bjorn Helgaas <bhelgaas@google.com>=
 wrote:
>> >> +struct resource iobusn_resource =3D {
>> >> + =A0 =A0 =A0 .name =A0 =3D "PCI busn",
>> >> + =A0 =A0 =A0 .start =A0=3D 0,
>> >> + =A0 =A0 =A0 .end =A0 =A0=3D 0xffffff,
>> >> + =A0 =A0 =A0 .flags =A0=3D IORESOURCE_BUS,
>> >> +};
>> >
>> > I'm not sure this should be global. =A0iomem_resource and
>> > ioport_resource *are* really global, because they refer to process=
or
>> > address space that is the same for everybody. =A0But PCI bus numbe=
rs are
>> > specific to PCI. =A0Some machines don't have PCI at all, and there=
 are
>> > different bus architectures to which this doesn't apply.
>>
>> that does not hurt them.
>
> Yes but it's superfluous and confusing if you're porting to a new arc=
h
> or looking at changes in generic code that may affect you.
>
>> > The 0-0xffffff range is misleading because it includes both the do=
main
>> > and the bus number, and it's meaningless to allocate ranges that c=
ross
>> > domain boundaries. =A0For example, [bus 0x0000f0-0x000120] include=
s bus
>> > numbers from domain 0000 and domain 0001, which doesn't make any s=
ense
>> > because a bus can only be in one domain.
>>
>> allocation code will make sure it will be cross the boundary for dom=
ain.
>
> But that means everyone reading it will do a double take, have to dig
> into the implementation, and only then say "ah yeah ok it looks
> correct" rather than it being obvious from the fact that the resource
> is tracked on a per-domain basis.
>
>> > I think it would make more sense to keep this bus number resource =
in a
>> > per-host bridge structure. =A0Then we wouldn't need to include the
>> > domain number at all because the host bridge determines the domain=
=2E
>>
>> not sure. insert the all busn_res of all peer root buses into one
>> global iobusn_resource
>> looks more simple.
>
> In what sense? =A0Simpler in the sense of your current implementation=
,
> but not simpler at all to someone just reading the code...

ok, will check if i could drop iobusn_resource.

Yinghai
