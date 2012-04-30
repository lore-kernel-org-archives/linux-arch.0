From: Bjorn Helgaas <bhelgaas@google.com>
Subject: Re: [PATCH -v3 00/11] PCI: pci_host_bridge related cleanup
Date: Mon, 30 Apr 2012 16:59:07 -0600
Message-ID: <CAErSpo4sYW9juTsJbuow7OzQH3Q-7tuQT1OdnVvGD-b5Gtfb1Q@mail.gmail.com>
References: <1332135624-13528-1-git-send-email-yinghai@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mail-lpp01m010-f46.google.com ([209.85.215.46]:46327 "EHLO
	mail-lpp01m010-f46.google.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1756679Ab2D3W73 convert rfc822-to-8bit
	(ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Mon, 30 Apr 2012 18:59:29 -0400
Received: by lahj13 with SMTP id j13so2181141lah.19
        for <linux-arch@vger.kernel.org>; Mon, 30 Apr 2012 15:59:27 -0700 (PDT)
In-Reply-To: <1332135624-13528-1-git-send-email-yinghai@kernel.org>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Yinghai Lu <yinghai@kernel.org>
Cc: Jesse Barnes <jbarnes@virtuousgeek.org>, x86 <x86@kernel.org>, Andrew Morton <akpm@linux-foundation.org>, Linus Torvalds <torvalds@linux-foundation.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org

On Sun, Mar 18, 2012 at 11:40 PM, Yinghai Lu <yinghai@kernel.org> wrote=
:
> will add struct device dev into host_bridge struct.
> also will add release support to make sure allocated resource get
> freed during root bus removal including hostbridge and pci_sysdata.
>
> The patches need to apply to linus v3.3 plus pci/linux-next
>
> could get from
> =A0 =A0 =A0 =A0git://git.kernel.org/pub/scm/linux/kernel/git/yinghai/=
linux-yinghai.git for-pci-hostbridge-cleanup

I applied the patches from this branch to my "next" branch, with the
exception of the following.  Please take a look and make sure my
"next" branch has what you expect.

> =A0x86, PCI: Merge root info printing for not using _CRS path

This changes from printing info for all HT links to just one (probably
unintentional).  It should also use the "[bus %02x-%02x]" format as we
do elsewhere.

> x86, PCI: Add print all root info for not using _CRS path

This fixes the unintentional "only print one HT link info" change from =
above.

> x86, PCI: Allocate temp range array in amd_bus pci_root_info probing

This had no changelog, so I don't know why we want this.

Bjorn
