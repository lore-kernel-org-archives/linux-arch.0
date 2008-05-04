From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH 48/56] microblaze_v2: pool.h socket.h
Date: Mon, 5 May 2008 00:39:23 +0200
Message-ID: <200805050039.24553.arnd@arndb.de>
References: <1209901305-6404-1-git-send-email-monstr@seznam.cz> <eff9f144fc70b87a9ff6767e9ab92d3d55eebbae.1209897267.git.monstr@monstr.eu> <643084ee3819dd169cad3c4e3565c5ff20dd3429.1209897267.git.monstr@monstr.eu>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.126.171]:52084 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756658AbYEDWjy (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Sun, 4 May 2008 18:39:54 -0400
In-Reply-To: <643084ee3819dd169cad3c4e3565c5ff20dd3429.1209897267.git.monstr@monstr.eu>
Content-Disposition: inline
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: monstr@seznam.cz
Cc: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, stephen.neuendorffer@xilinx.com, John.Linn@xilinx.com, john.williams@petalogix.com, matthew@wil.cx, will.newton@gmail.com, drepper@redhat.com, microblaze-uclinux@itee.uq.edu.au, grant.likely@secretlab.ca, Michal Simek <monstr@monstr.eu>

On Sunday 04 May 2008, monstr@seznam.cz wrote:
> diff --git a/include/asm-microblaze/poll.h b/include/asm-microblaze/poll.h
> new file mode 100644
> index 0000000..4b33ac7
> --- /dev/null
> +++ b/include/asm-microblaze/poll.h
> @@ -0,0 +1,37 @@
> +/*
> + * include/asm-microblaze/poll.h

Please use the existing asm-generic/poll.h here.

> --- /dev/null
> +++ b/include/asm-microblaze/socket.h
> @@ -0,0 +1,68 @@
> +/*
> + * include/asm-microblaze/socket.h

Please make a new asm-generic/socket.h out of this file, and use it.

	Arnd <><
