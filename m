From: Bjorn Helgaas <bhelgaas@google.com>
Subject: Re: [PATCH -v11 04/30] PCI: Add busn_res into struct pci_bus.
Date: Mon, 30 Apr 2012 17:25:52 -0600
Message-ID: <CAErSpo6Wbjh_pzDOkGRoog2WeJQET9UT0fiaanV0r15pq7hT6Q@mail.gmail.com>
References: <1332135781-13695-1-git-send-email-yinghai@kernel.org> <1332135781-13695-5-git-send-email-yinghai@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mail-lb0-f174.google.com ([209.85.217.174]:44895 "EHLO
	mail-lb0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757137Ab2D3X0O convert rfc822-to-8bit (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Mon, 30 Apr 2012 19:26:14 -0400
Received: by lbbgm6 with SMTP id gm6so582965lbb.19
        for <linux-arch@vger.kernel.org>; Mon, 30 Apr 2012 16:26:13 -0700 (PDT)
In-Reply-To: <1332135781-13695-5-git-send-email-yinghai@kernel.org>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Yinghai Lu <yinghai@kernel.org>
Cc: Jesse Barnes <jbarnes@virtuousgeek.org>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Tony Luck <tony.luck@intel.com>, David Miller <davem@davemloft.net>, x86 <x86@kernel.org>, Dominik Brodowski <linux@dominikbrodowski.net>, Andrew Morton <akpm@linux-foundation.org>, Linus Torvalds <torvalds@linux-foundation.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org

On Sun, Mar 18, 2012 at 11:42 PM, Yinghai Lu <yinghai@kernel.org> wrote=
:
> Will use it to track bus number resource tree.
>
> Signed-off-by: Yinghai Lu <yinghai@kernel.org>
> Cc: Andrew Morton <akpm@linux-foundation.org>
> ---
> =A0include/linux/pci.h | =A0 =A01 +
> =A01 files changed, 1 insertions(+), 0 deletions(-)
>
> diff --git a/include/linux/pci.h b/include/linux/pci.h
> index d93d3ae..7c03852 100644
> --- a/include/linux/pci.h
> +++ b/include/linux/pci.h
> @@ -419,6 +419,7 @@ struct pci_bus {
> =A0 =A0 =A0 =A0struct list_head slots; =A0 =A0 =A0 =A0 /* list of slo=
ts on this bus */
> =A0 =A0 =A0 =A0struct resource *resource[PCI_BRIDGE_RESOURCE_NUM];
> =A0 =A0 =A0 =A0struct list_head resources; =A0 =A0 /* address space r=
outed to this bus */
> + =A0 =A0 =A0 struct resource busn_res; =A0 =A0 =A0 /* track register=
ed bus num range */
>
> =A0 =A0 =A0 =A0struct pci_ops =A0*ops; =A0 =A0 =A0 =A0 =A0 /* configu=
ration access functions */
> =A0 =A0 =A0 =A0void =A0 =A0 =A0 =A0 =A0 =A0*sysdata; =A0 =A0 =A0 /* h=
ook for sys-specific extension */

struct pci_bus already includes "secondary" and "subordinate".    This
new "busn_res" looks like it will contain the same information.  Why
do we need both?
