From: Bjorn Helgaas <bhelgaas@google.com>
Subject: Re: [PATCH v3 00/34] Create PCI root buses with correct resources
Date: Fri, 11 Nov 2011 09:40:07 -0700
Message-ID: <CAErSpo5xAJowmEfLXnGkTXXF-4fbNMW2+JYg=5yPK3e-PZWsrw@mail.gmail.com>
References: <20111028222432.30729.8431.stgit@bhelgaas.mtv.corp.google.com> <CAErSpo5X00LFs6XUcnqoogZEZhR2H4G7AJvh9+FAsvr3vMHkeA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-pci-owner@vger.kernel.org>
In-Reply-To: <CAErSpo5X00LFs6XUcnqoogZEZhR2H4G7AJvh9+FAsvr3vMHkeA@mail.gmail.com>
Sender: linux-pci-owner@vger.kernel.org
To: linux-pci@vger.kernel.org
Cc: linux-arch@vger.kernel.org, James Bottomley <James.Bottomley@hansenpartnership.com>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Russell King <linux@arm.linux.org.uk>, Deng-Cheng Zhu <dengcheng.zhu@gmail.com>
List-Id: linux-arch.vger.kernel.org

On Sat, Oct 29, 2011 at 10:25 AM, Bjorn Helgaas <bhelgaas@google.com> w=
rote:
> On Fri, Oct 28, 2011 at 4:25 PM, Bjorn Helgaas <bhelgaas@google.com> =
wrote:
>> The most generic way to create a PCI root bus is with pci_scan_bus()=
, but that
>> doesn't allow you to specify what resources are available on the bus=
, i.e.,
>> what the host bridge apertures are. =A0This series fixes the problem=
 by adding
>> a new pci_scan_root_bus() interface that takes a list of bus resourc=
es.
>
> These patches are also available here:
> git://github.com/bjorn-helgaas/linux.git on
> the "pci-scan-v3" branch.

This series touches 13 architectures.  Most of the changes are fairly
simple, but some (arm, parisc, powerpc) are more involved, so I'd
appreciate any feedback you have.

Since the 3.2 merge window is closed, I'm targeting these for 3.3.
They don't all have to be merged at once, though we can't remove
pci_create_bus() (patch 34/34) until all the arch patches are in.

Bjorn
