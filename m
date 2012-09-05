From: Chris Metcalf <cmetcalf@tilera.com>
Subject: Re: [patch 2/3] tile: remove duplicate CONFIG_HOTPLUG definition
Date: Tue, 4 Sep 2012 20:56:11 -0400
Message-ID: <5046A32B.7010702@tilera.com>
References: <20120904234803.554552301@clark.kroah.org> <20120904235155.138994400@clark.kroah.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from usmamail.tilera.com ([12.216.194.151]:11623 "EHLO
	USMAMAIL.TILERA.COM" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752763Ab2IEA4P (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Tue, 4 Sep 2012 20:56:15 -0400
In-Reply-To: <20120904235155.138994400@clark.kroah.org>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org, Geert Uytterhoeven <geert@linux-m68k.org>, Ralf Baechle <ralf@linux-mips.org>, Bjorn Helgaas <bhelgaas@google.com>, Chris Zankel <chris@zankel.net>

On 9/4/2012 8:01 PM, Greg Kroah-Hartman wrote:
> From: Greg KH <gregkh@linuxfoundation.org>
>
> As part of the plan to remove CONFIG_HOTPLUG, it was found that tile
> duplicates this config option for no reason (it's already defined as part of
> init/Kconfig).  This patch removes it from the tile-only Kconfig file.
>
> Cc: Chris Metcalf <cmetcalf@tilera.com>
> Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
>
> ---
>  arch/tile/Kconfig |    8 --------
>  1 file changed, 8 deletions(-)

Acked-by: Chris Metcalf <cmetcalf@tilera.com>

-- 
Chris Metcalf, Tilera Corp.
http://www.tilera.com
