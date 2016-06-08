From: Bjorn Helgaas <helgaas@kernel.org>
Subject: Re: [PATCH][RFC] PCI: Workaround to enable poweroff on Mac Pro 11
Date: Wed, 8 Jun 2016 07:47:42 -0500
Message-ID: <20160608124742.GA16764@localhost>
References: <1464604404-11257-1-git-send-email-yu.c.chen@intel.com>
 <20160530213305.GA21322@localhost>
 <574D03F9.6050201@intel.com>
 <CAE9FiQV_Mc9VuyBvCB7hL_0pgj+-wW1_jupzhbTHij+VQeLF-A@mail.gmail.com>
 <574D3AAA.6090503@intel.com>
 <20160531131658.GA23837@localhost>
 <57579F9F.6010200@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:60573 "EHLO mail.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1161596AbcFHMrs (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Wed, 8 Jun 2016 08:47:48 -0400
Content-Disposition: inline
In-Reply-To: <57579F9F.6010200@intel.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Chen Yu <yu.c.chen@intel.com>
Cc: Yinghai Lu <yinghai@kernel.org>, "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>, linux-arch <linux-arch@vger.kernel.org>, Bjorn Helgaas <bhelgaas@google.com>, Arnd Bergmann <arnd@arndb.de>, "Rafael J . Wysocki" <rafael@kernel.org>, Len Brown <lenb@kernel.org>, Mika Westerberg <mika.westerberg@linux.intel.com>

On Wed, Jun 08, 2016 at 12:31:27PM +0800, Chen Yu wrote:
> Hi Bjorn,
>=20
> On 2016=E5=B9=B405=E6=9C=8831=E6=97=A5 21:16, Bjorn Helgaas wrote:
> >On Tue, May 31, 2016 at 03:18:02PM +0800, Chen Yu wrote:
> >>On 2016=E5=B9=B405=E6=9C=8831=E6=97=A5 15:00, Yinghai Lu wrote:
> >>>On Mon, May 30, 2016 at 8:24 PM, Chen Yu <yu.c.chen@intel.com> wro=
te:
> >>>
> >>>>and then in pcibios_assign_resources, 0000:00:1c.0 tries to alloc=
ate minimal
> >>>>resource window and then update related base/limit registers:
> >>>>
> >>>>[    0.865342] pci 0000:00:1c.0: bridge window [io  0x1000-0x0fff=
] to [bus
> >>>>02] add_size 1000
> >>>>[    0.865343] pci 0000:00:1c.0: bridge window [mem 0x00100000-0x=
000fffff
> >>>>64bit pref] to [bus 02] add_size 200000 add_align 100000
> >>>>[    0.865344] pci 0000:00:1c.0: bridge window [mem 0x00100000-0x=
000fffff]
> >>>>to [bus 02] add_size 200000 add_align 100000
> >>>>
> >>>That is for hotplug bridge, then we could use following instead.
> >>>
> >>>diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
> >>>index ee72ebe..d3ec833 100644
> >>>--- a/drivers/pci/quirks.c
> >>>+++ b/drivers/pci/quirks.c
> >>>@@ -2775,6 +2775,13 @@ static void quirk_hotplug_bridge(struct pci=
_dev *dev)
> >>>
> >>>  DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_HINT, 0x0020, quirk_hotpl=
ug_bridge);
> >>>
> >>>+static void quirk_hotplug_bridge_skip(struct pci_dev *dev)
> >>>+{
> >>>+       dev->is_hotplug_bridge =3D 0;
> >>>+}
> >>>+
> >>>+DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_INTEL, 0x8c10,
> >>>quirk_hotplug_bridge_skip);
> >>>+
> >>>  /*
> >>>   * This is a quirk for the Ricoh MMC controller found as a part =
of
> >>>   * some mulifunction chips.
> >>Good idea, but in this way we might not have io window allocated fo=
r
> >>it?I'm not sure
> >>if this would break wifi,etc, I'll suggest reporters to have a try.
> >Let's figure out the root cause before trying more random fixes.  I
> >have the same objection to the patch above.  No doubt there are many
> >ways we could "fix" this, but unless we know the root cause, we're
> >likely to make a change that's not a complete fix or will cause othe=
r
> >issues in the future.
> >
> I just let the reporter  paste their lspci in Mac OS, it looks that
> Mac OS also
> does not allocate any resource for this broken pci bridge, and other =
pci
> devices have almost the same resource region as it is in linux, so I =
think
> this is an evidence that Apple does not want to use this firmware for=
 now,
> maybe reserved for future use, declaim resource for this pci bridge m=
ight
> cause unpredictable result, how about adding a dmi+pci quirk for this
> special platform?

This is not a root cause.  We still have no idea why the problem
occurs.  I do not think a quirk is a good idea until we know what the
problem is and exactly how a quirk would fix it.

> lspci result from Mac OS, there's no resource behind this bridge:
> https://bugzilla.kernel.org/attachment.cgi?id=3D219321
>=20
>=20
> thanks,
> Yu
