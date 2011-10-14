From: Bjorn Helgaas <bhelgaas@google.com>
Subject: Re: [PATCH v2 00/29] Create PCI root buses with correct resources
Date: Fri, 14 Oct 2011 11:21:26 -0600
Message-ID: <CAErSpo7HKLHUcFBO9=--C4X3casDvtTpwRTq3up_mfOBJ+zbjw@mail.gmail.com>
References: <20111014042142.23504.70417.stgit@bhelgaas.mtv.corp.google.com>
 <1318605254.3018.20.camel@dabdike.int.hansenpartnership.com>
 <CAErSpo7d3hHeJU87zYo=yJoG3eqOZ4QggkOyNnu7xuJe8oG9Qg@mail.gmail.com> <1318607132.3018.30.camel@dabdike.int.hansenpartnership.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1318607132.3018.30.camel@dabdike.int.hansenpartnership.com>
Sender: linux-kernel-owner@vger.kernel.org
To: James Bottomley <James.Bottomley@hansenpartnership.com>
Cc: linux-pci@vger.kernel.org, linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-arch.vger.kernel.org

On Fri, Oct 14, 2011 at 9:45 AM, James Bottomley
<James.Bottomley@hansenpartnership.com> wrote:
> On Fri, 2011-10-14 at 09:33 -0600, Bjorn Helgaas wrote:
>> On Fri, Oct 14, 2011 at 9:14 AM, James Bottomley
>> <James.Bottomley@hansenpartnership.com> wrote:
>> > On Thu, 2011-10-13 at 22:27 -0600, Bjorn Helgaas wrote:
>> >> The most generic way to create a PCI root bus is with pci_scan_bu=
s(), but
>> >> that doesn't allow you to specify what resources are available on=
 the bus,
>> >> i.e., what the host bridge apertures are.
>> >
>> > Do you have an actual tree for this? =A0The PARISC pieces look a b=
it
>> > non-trivial and I'd like to test them out on the various sba/astro=
/dino
>> > systems.
>>
>> I don't yet, but it'd be great if you were willing to test them out,
>> so I'll set one up.
>>
>> While this is on your mind, I'm dubious about the pci_enable_bridges=
()
>> call in lba_driver_probe() and the pci_bus_assign_resources() call i=
n
>> dino_probe(). =A0These stand out as exceptions because no other arch=
es
>> do that.
>>
>> If they weren't there, both places could use pci_scan_root_bus() lik=
e
>> most other arches.
>
> Right, the dino code actually has to rearrange some of the PCI resour=
ces
> to make sure we get our apertures correct. =A0That's the specific bit=
 I
> was planning to test. =A0I think it's only relevant for dino SBA card=
s
> where the bridge doesn't set up the card correctly so we have to do i=
t
> after the fact.

I put these patches here: git://github.com/bjorn-helgaas/linux.git on
the "pci-scan" branch.

Bjorn
