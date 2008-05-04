From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH 52/56] microblaze_v2: pci headers
Date: Mon, 5 May 2008 00:45:28 +0200
Message-ID: <200805050045.29614.arnd@arndb.de>
References: <1209901305-6404-1-git-send-email-monstr@seznam.cz> <affa82887bee64b05420fdd5f723cca920acad90.1209897267.git.monstr@monstr.eu> <c709de3e3767d1be8b23ce73255389c525737c36.1209897267.git.monstr@monstr.eu>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.126.188]:61713 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750708AbYEDWpf (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Sun, 4 May 2008 18:45:35 -0400
In-Reply-To: <c709de3e3767d1be8b23ce73255389c525737c36.1209897267.git.monstr@monstr.eu>
Content-Disposition: inline
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: monstr@seznam.cz
Cc: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, stephen.neuendorffer@xilinx.com, John.Linn@xilinx.com, john.williams@petalogix.com, matthew@wil.cx, will.newton@gmail.com, drepper@redhat.com, microblaze-uclinux@itee.uq.edu.au, grant.likely@secretlab.ca, Michal Simek <monstr@monstr.eu>

On Sunday 04 May 2008, monstr@seznam.cz wrote:
> +
> +#ifdef __KERNEL__
> +#include <asm/io.h>
> +#endif

You don't export asm/pci.h to userspace, so the #ifdef __KERNEL__ is
not needed.

	Arnd <><
