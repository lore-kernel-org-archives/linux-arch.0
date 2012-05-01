From: Yinghai Lu <yinghai@kernel.org>
Subject: Re: [PATCH -v11 04/30] PCI: Add busn_res into struct pci_bus.
Date: Mon, 30 Apr 2012 17:32:18 -0700
Message-ID: <CAE9FiQV0XTd_1Ujz=tb6BSuwJvJ9nbT_GbE2PREtgMGv=yG0+g@mail.gmail.com>
References: <1332135781-13695-1-git-send-email-yinghai@kernel.org>
	<1332135781-13695-5-git-send-email-yinghai@kernel.org>
	<CAErSpo6Wbjh_pzDOkGRoog2WeJQET9UT0fiaanV0r15pq7hT6Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-pci-owner@vger.kernel.org>
In-Reply-To: <CAErSpo6Wbjh_pzDOkGRoog2WeJQET9UT0fiaanV0r15pq7hT6Q@mail.gmail.com>
Sender: linux-pci-owner@vger.kernel.org
To: Bjorn Helgaas <bhelgaas@google.com>
Cc: Jesse Barnes <jbarnes@virtuousgeek.org>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Tony Luck <tony.luck@intel.com>, David Miller <davem@davemloft.net>, x86 <x86@kernel.org>, Dominik Brodowski <linux@dominikbrodowski.net>, Andrew Morton <akpm@linux-foundation.org>, Linus Torvalds <torvalds@linux-foundation.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org
List-Id: linux-arch.vger.kernel.org

On Mon, Apr 30, 2012 at 4:25 PM, Bjorn Helgaas <bhelgaas@google.com> wr=
ote:
>> --- a/include/linux/pci.h
>> +++ b/include/linux/pci.h
>> @@ -419,6 +419,7 @@ struct pci_bus {
>> =A0 =A0 =A0 =A0struct list_head slots; =A0 =A0 =A0 =A0 /* list of sl=
ots on this bus */
>> =A0 =A0 =A0 =A0struct resource *resource[PCI_BRIDGE_RESOURCE_NUM];
>> =A0 =A0 =A0 =A0struct list_head resources; =A0 =A0 /* address space =
routed to this bus */
>> + =A0 =A0 =A0 struct resource busn_res; =A0 =A0 =A0 /* track registe=
red bus num range */
>>
>> =A0 =A0 =A0 =A0struct pci_ops =A0*ops; =A0 =A0 =A0 =A0 =A0 /* config=
uration access functions */
>> =A0 =A0 =A0 =A0void =A0 =A0 =A0 =A0 =A0 =A0*sysdata; =A0 =A0 =A0 /* =
hook for sys-specific extension */
>
> struct pci_bus already includes "secondary" and "subordinate". =A0 =A0=
This
> new "busn_res" looks like it will contain the same information. =A0Wh=
y
> do we need both?

In some case the could be different.
for root bus from _CRS, busn_res could bigger than subordinate,
because scan_childbus will update subordinate.

and also we have one resource to insert it into the resource tree, so
later could probe/allocate bus num range.

Yinghai
