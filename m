From: Baruch Siach <baruch@tkos.co.il>
Subject: Re: [Linux-Xtensa] [PATCHv2 14/17] xtensa: add MX irqchip
Date: Sun, 1 Dec 2013 09:20:01 +0200
Message-ID: <20131201072001.GF4302@tarshish>
References: <528B0906.6070105@zankel.net>
 <1385876327-26445-1-git-send-email-jcmvbkbc@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from guitar.tcltek.co.il ([192.115.133.116]:36538 "EHLO
	mx.tkos.co.il" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750900Ab3LAHUD (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Sun, 1 Dec 2013 02:20:03 -0500
Content-Disposition: inline
In-Reply-To: <1385876327-26445-1-git-send-email-jcmvbkbc@gmail.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Max Filippov <jcmvbkbc@gmail.com>
Cc: Chris Zankel <chris@zankel.net>, Marc Gauthier <marc@tensilica.com>, linux-xtensa@linux-xtensa.org, linux-arch@vger.kernel.org

Hi Max,

On Sun, Dec 01, 2013 at 09:38:47AM +0400, Max Filippov wrote:
> MX is an interrupt distributor used in some SMP-capable xtensa
> configurations.
> 
> Signed-off-by: Max Filippov <jcmvbkbc@gmail.com>
> ---

[...]

> +IRQCHIP_DECLARE(xtensa_mx_irq_chip, "xtensa,mx", xtensa_mx_init);

This should probably better named "cdns,xtensa-mx", according to the ePAPR 1.1 
recommendation.

baruch

-- 
     http://baruch.siach.name/blog/                  ~. .~   Tk Open Systems
=}------------------------------------------------ooO--U--Ooo------------{=
   - baruch@tkos.co.il - tel: +972.2.679.5364, http://www.tkos.co.il -
