From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCHv2 06/11] unicore32 core architecture: mm related: generic codes
Date: Thu, 17 Feb 2011 18:28:15 +0100
Message-ID: <201102171828.15482.arnd@arndb.de>
References: <02ed01cbcb48$3e3781a0$baa684e0$@mprc.pku.edu.cn>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.17.9]:56375 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754325Ab1BQR2T (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Thu, 17 Feb 2011 12:28:19 -0500
In-Reply-To: <02ed01cbcb48$3e3781a0$baa684e0$@mprc.pku.edu.cn>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Guan Xuetao <gxt@mprc.pku.edu.cn>
Cc: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, 'Greg KH' <greg@kroah.com>

On Sunday 13 February 2011, Guan Xuetao wrote:
> This patch includes generic codes for memory management.
> 
> Signed-off-by: Guan Xuetao <gxt@mprc.pku.edu.cn>

Reviewed-by: Arnd Bergmann <arnd@arndb.de>

> +#ifdef __io
> +void __iomem *ioport_map(unsigned long port, unsigned int nr)
> +{
> +       /* we map PC lagcy 64K IO port to PCI IO space 0x80030000 */
> +       return (void __iomem *) (unsigned long)
> +                       io_p2v((port & 0xffff) + PKUNITY_PCILIO_BASE);
> +}

Interestingly, this function looks completely correct, but I don't see
the definition for __io, so I suspect that the function is not actually
getting used.

Best make this unconditional. The code is obviously derived from the
ARM version, which uses a macro called __io, but you don't need this
macro because you only support one SoC platform.

	Arnd
