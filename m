From: Yinghai Lu <yinghai@kernel.org>
Subject: Re: [PATCH 01/24] PCI: Add iobusn_resource
Date: Mon, 6 Feb 2012 10:55:14 -0800
Message-ID: <CAE9FiQXeRGXE2RCe5S1iOE=QY37wauM=WUevjXWkMqMOjV3t7A@mail.gmail.com>
References: <1328425088-6562-1-git-send-email-yinghai@kernel.org>
	<1328425088-6562-2-git-send-email-yinghai@kernel.org>
	<CAErSpo4HJH+3EQAWowyVxZFa5jVy1EOo=SoybJqqcjhVdo0nzw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-pci-owner@vger.kernel.org>
In-Reply-To: <CAErSpo4HJH+3EQAWowyVxZFa5jVy1EOo=SoybJqqcjhVdo0nzw@mail.gmail.com>
Sender: linux-pci-owner@vger.kernel.org
To: Bjorn Helgaas <bhelgaas@google.com>
Cc: Jesse Barnes <jbarnes@virtuousgeek.org>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Tony Luck <tony.luck@intel.com>, Dominik Brodowski <linux@dominikbrodowski.net>, Andrew Morton <akpm@linux-foundation.org>, Linus Torvalds <torvalds@linux-foundation.org>, Greg Kroah-Hartman <gregkh@suse.de>, linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org
List-Id: linux-arch.vger.kernel.org

On Mon, Feb 6, 2012 at 10:48 AM, Bjorn Helgaas <bhelgaas@google.com> wr=
ote:
>> +struct resource iobusn_resource =3D {
>> + =A0 =A0 =A0 .name =A0 =3D "PCI busn",
>> + =A0 =A0 =A0 .start =A0=3D 0,
>> + =A0 =A0 =A0 .end =A0 =A0=3D 0xffffff,
>> + =A0 =A0 =A0 .flags =A0=3D IORESOURCE_BUS,
>> +};
>
> I'm not sure this should be global. =A0iomem_resource and
> ioport_resource *are* really global, because they refer to processor
> address space that is the same for everybody. =A0But PCI bus numbers =
are
> specific to PCI. =A0Some machines don't have PCI at all, and there ar=
e
> different bus architectures to which this doesn't apply.

that does not hurt them.

>
> The 0-0xffffff range is misleading because it includes both the domai=
n
> and the bus number, and it's meaningless to allocate ranges that cros=
s
> domain boundaries. =A0For example, [bus 0x0000f0-0x000120] includes b=
us
> numbers from domain 0000 and domain 0001, which doesn't make any sens=
e
> because a bus can only be in one domain.

allocation code will make sure it will be cross the boundary for domain=
=2E

>
> I think it would make more sense to keep this bus number resource in =
a
> per-host bridge structure. =A0Then we wouldn't need to include the
> domain number at all because the host bridge determines the domain.

not sure. insert the all busn_res of all peer root buses into one
global iobusn_resource
looks more simple.

Yinghai
