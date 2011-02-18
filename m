From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH 11/12] unicore32 machine related files: ps2 driver
Date: Fri, 18 Feb 2011 11:33:26 +0100
Message-ID: <201102181133.26675.arnd@arndb.de>
References: <015701cbcdae$7d5f43f0$781dcbd0$@mprc.pku.edu.cn> <201102171803.15785.arnd@arndb.de> <00eb01cbcf56$9f372700$dda57500$@mprc.pku.edu.cn>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.17.10]:58658 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751745Ab1BRKdk (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Fri, 18 Feb 2011 05:33:40 -0500
In-Reply-To: <00eb01cbcf56$9f372700$dda57500$@mprc.pku.edu.cn>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Guan Xuetao <gxt@mprc.pku.edu.cn>
Cc: dmitry.torokhov@gmail.com, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, 'Greg KH' <greg@kroah.com>

On Friday 18 February 2011 11:28:45 Guan Xuetao wrote:
>   * Register numbers.
>   */
> -#define I8042_COMMAND_REG      ((unsigned long)&PS2_COMMAND)
> -#define I8042_STATUS_REG       ((unsigned long)&PS2_STATUS)
> -#define I8042_DATA_REG         ((unsigned long)&PS2_DATA)
> +#define I8042_COMMAND_REG      ((volatile void __iomem *)&PS2_COMMAND)
> +#define I8042_STATUS_REG       ((volatile void __iomem *)&PS2_STATUS)
> +#define I8042_DATA_REG         ((volatile void __iomem *)&PS2_DATA)
> +
> +#define I8042_REGION_START     (resource_size_t)(&PS2_DATA)
> +#define I8042_REGION_SIZE      (resource_size_t)(16)

It would be better to remove the cast and make the PS2_COMMAND
etc macros have the correct type. Aside from this, the change
looks good.

	Arnd
