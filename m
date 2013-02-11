From: James Hogan <james.hogan@imgtec.com>
Subject: Re: [PATCH v3 02/71] ARC: Build system: Makefiles, Kconfig, Linker
 script
Date: Mon, 11 Feb 2013 11:29:33 +0000
Message-ID: <5118D61D.7010302@imgtec.com>
References: <1359024639-21915-1-git-send-email-vgupta@synopsys.com> <1359024639-21915-3-git-send-email-vgupta@synopsys.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from multi.imgtec.com ([194.200.65.239]:35237 "EHLO multi.imgtec.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755447Ab3BKL3j (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Mon, 11 Feb 2013 06:29:39 -0500
In-Reply-To: <1359024639-21915-3-git-send-email-vgupta@synopsys.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Vineet Gupta <Vineet.Gupta1@synopsys.com>
Cc: linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org, arnd@arndb.de, Sam Ravnborg <sam@ravnborg.org>

Hi Vineet,

On 24/01/13 10:50, Vineet Gupta wrote:
> diff --git a/arch/arc/Kconfig b/arch/arc/Kconfig
> new file mode 100644
> index 0000000..b0b09ae
> --- /dev/null
> +++ b/arch/arc/Kconfig
> @@ -0,0 +1,328 @@
> +#
> +# Copyright (C) 2004, 2007-2010, 2011-2012 Synopsys, Inc. (www.synopsys.com)
> +#
> +# This program is free software; you can redistribute it and/or modify
> +# it under the terms of the GNU General Public License version 2 as
> +# published by the Free Software Foundation.
> +#
> +
> +config ARC
> +	def_bool y
> +	select ARCH_NO_VIRT_TO_BUS

I noticed this in linux-next. ARCH_NO_VIRT_TO_BUS was defined
generically in the past in linux-next but the patch seems to have gone.
Therefore with an arc defconfig I see CONFIG_VIRT_TO_BUS=y defined which
I'm guessing it shouldn't be.

Cheers
James
