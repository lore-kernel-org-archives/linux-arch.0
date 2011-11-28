From: Bjorn Helgaas <bhelgaas@google.com>
Subject: Re: [PATCH v3 00/34] Create PCI root buses with correct resources
Date: Mon, 28 Nov 2011 10:58:02 -0800
Message-ID: <CAErSpo7Tv-fTngZ0=UiNwo=XOwzN49vygMA8aAd_YH0srJ5cdw@mail.gmail.com>
References: <20111028222432.30729.8431.stgit@bhelgaas.mtv.corp.google.com>
 <CAErSpo5X00LFs6XUcnqoogZEZhR2H4G7AJvh9+FAsvr3vMHkeA@mail.gmail.com> <CAErSpo5xAJowmEfLXnGkTXXF-4fbNMW2+JYg=5yPK3e-PZWsrw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-pci-owner@vger.kernel.org>
In-Reply-To: <CAErSpo5xAJowmEfLXnGkTXXF-4fbNMW2+JYg=5yPK3e-PZWsrw@mail.gmail.com>
Sender: linux-pci-owner@vger.kernel.org
To: linux-pci@vger.kernel.org
Cc: linux-arch@vger.kernel.org, James Bottomley <James.Bottomley@hansenpartnership.com>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Russell King <linux@arm.linux.org.uk>, Deng-Cheng Zhu <dengcheng.zhu@gmail.com>
List-Id: linux-arch.vger.kernel.org

On Fri, Nov 11, 2011 at 8:40 AM, Bjorn Helgaas <bhelgaas@google.com> wr=
ote:
> On Sat, Oct 29, 2011 at 10:25 AM, Bjorn Helgaas <bhelgaas@google.com>=
 wrote:
>> On Fri, Oct 28, 2011 at 4:25 PM, Bjorn Helgaas <bhelgaas@google.com>=
 wrote:
>>> The most generic way to create a PCI root bus is with pci_scan_bus(=
), but that
>>> doesn't allow you to specify what resources are available on the bu=
s, i.e.,
>>> what the host bridge apertures are. =A0This series fixes the proble=
m by adding
>>> a new pci_scan_root_bus() interface that takes a list of bus resour=
ces.
>>
>> These patches are also available here:
>> git://github.com/bjorn-helgaas/linux.git on
>> the "pci-scan-v3" branch.
>
> This series touches 13 architectures. =A0Most of the changes are fair=
ly
> simple, but some (arm, parisc, powerpc) are more involved, so I'd
> appreciate any feedback you have.
>
> Since the 3.2 merge window is closed, I'm targeting these for 3.3.
> They don't all have to be merged at once, though we can't remove
> pci_create_bus() (patch 34/34) until all the arch patches are in.

Jesse, would you consider putting these in your branch for linux-next?
 They've been floating in the ether for a month, so it seems like it's
time for the next step.

The "pci-scan-v3" github branch is still current.  Let me know if
you'd like any updates or rework.

Bjorn
