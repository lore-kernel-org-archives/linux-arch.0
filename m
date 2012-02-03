From: Yinghai Lu <yinghai@kernel.org>
Subject: Re: [PATCH 02/15] PCI: Add iobusn_resource
Date: Fri, 3 Feb 2012 09:19:16 -0800
Message-ID: <CAE9FiQX0+t_Ta76=TWS_xdUwrHrrr5ZPBTaeqFeH9WopYEnS+Q@mail.gmail.com>
References: <1328136242-17725-1-git-send-email-yinghai@kernel.org>
	<1328136242-17725-3-git-send-email-yinghai@kernel.org>
	<CAErSpo44bef-Vj4LPB0QJ8HRjWxqRFK_=kpMq8hYEe=4t58zGQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mail-yw0-f46.google.com ([209.85.213.46]:55745 "EHLO
	mail-yw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755050Ab2BCRTQ convert rfc822-to-8bit (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Fri, 3 Feb 2012 12:19:16 -0500
In-Reply-To: <CAErSpo44bef-Vj4LPB0QJ8HRjWxqRFK_=kpMq8hYEe=4t58zGQ@mail.gmail.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Bjorn Helgaas <bhelgaas@google.com>
Cc: Jesse Barnes <jbarnes@virtuousgeek.org>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Tony Luck <tony.luck@intel.com>, Dominik Brodowski <linux@dominikbrodowski.net>, Andrew Morton <akpm@linux-foundation.org>, Linus Torvalds <torvalds@linux-foundation.org>, linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org

On Fri, Feb 3, 2012 at 8:36 AM, Bjorn Helgaas <bhelgaas@google.com> wro=
te:
> On Wed, Feb 1, 2012 at 2:43 PM, Yinghai Lu <yinghai@kernel.org> wrote=
:
>> also add busn_res into struct pci_bus.
>>
>> will use them to have bus number resource tree.
>
> Will you make this tree visible in /proc? =A0Seems like that would be
> useful for debugging and for symmetry with /proc/iomem and
> /proc/ioports.

will give it try.

>
=2E..
>> @@ -419,6 +419,7 @@ struct pci_bus {
>> =A0 =A0 =A0 =A0struct list_head slots; =A0 =A0 =A0 =A0 /* list of sl=
ots on this bus */
>> =A0 =A0 =A0 =A0struct resource *resource[PCI_BRIDGE_RESOURCE_NUM];
>> =A0 =A0 =A0 =A0struct list_head resources; =A0 =A0 /* address space =
routed to this bus */
>> + =A0 =A0 =A0 struct resource busn_res; =A0 =A0 =A0 /* track registe=
red bus num range */
>
> Is this different from bus.secondary and bus.subordinate? =A0Do we ne=
ed
> both busn_res and secondary/subordinate? =A0If we need both, in what
> circumstance with they contain different information?

yes,  sometime it

for non-peer root bus just after scan. and at that time will set
busn_res.end correctly according to subordinate.

for peer root bus, busn_res.end could be bigger than bus subordinate

Yinghai
