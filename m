From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH 1/2] OF: Fix coding style violation in of_device.c and of_platform.c
Date: Sat, 3 May 2008 23:04:57 +0200
Message-ID: <200805032304.58709.arnd@arndb.de>
References: <monstr@seznam.cz> <1209824532-7939-1-git-send-email-monstr@seznam.cz> <765c6c8053679c45eb370255a110f7bc680a8f25.1209824033.git.monstr@monstr.eu>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.126.174]:57084 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752884AbYECVFJ (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Sat, 3 May 2008 17:05:09 -0400
In-Reply-To: <765c6c8053679c45eb370255a110f7bc680a8f25.1209824033.git.monstr@monstr.eu>
Content-Disposition: inline
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: monstr@seznam.cz
Cc: paulus@samba.org, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, Michal Simek <monstr@monstr.eu>

On Saturday 03 May 2008, monstr@seznam.cz wrote:

>  
>  #include <asm/errno.h>
> +
> +#ifdef CONFIG_PPC_PSERIES
>  #include <asm/dcr.h>
> +#endif
>  

The patch looks basically good, but we normally try to not have an #include
inside of #ifdef. If the file builds without this #include, maybe you should
better leave it out entirely? Same for the ppc-pci.h in the other file.

	Arnd <><
