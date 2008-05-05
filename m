From: "Grant Likely" <grant.likely@secretlab.ca>
Subject: Re: [PATCH 04/56] microblaze_v2: Open firmware files
Date: Mon, 5 May 2008 08:24:28 -0600
Message-ID: <fa686aa40805050724w59d4357ak6029a2a7a612329e@mail.gmail.com>
References: <a4a778e34c66d126f5c4bf1ca423cf32950ea5ab.1209897266.git.monstr@monstr.eu>
	 <684c36e5ad3f598e5079e88ec195545c4a7150c2.1209897266.git.monstr@monstr.eu>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from wr-out-0506.google.com ([64.233.184.238]:4880 "EHLO
	wr-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759054AbYEEOYb (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Mon, 5 May 2008 10:24:31 -0400
Received: by wr-out-0506.google.com with SMTP id c48so1209225wra.1
        for <linux-arch@vger.kernel.org>; Mon, 05 May 2008 07:24:28 -0700 (PDT)
In-Reply-To: <684c36e5ad3f598e5079e88ec195545c4a7150c2.1209897266.git.monstr@monstr.eu>
Content-Disposition: inline
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: monstr@seznam.cz
Cc: linux-kernel@vger.kernel.org, arnd@arndb.de, linux-arch@vger.kernel.org, stephen.neuendorffer@xilinx.com, John.Linn@xilinx.com, john.williams@petalogix.com, matthew@wil.cx, will.newton@gmail.com, microblaze-uclinux@itee.uq.edu.au, Michal Simek <monstr@monstr.eu>, linuxppc-dev <linuxppc-dev@ozlabs.org>

On Sun, May 4, 2008 at 5:40 AM,  <monstr@seznam.cz> wrote:
> From: Michal Simek <monstr@monstr.eu>
>
>
>  Signed-off-by: Michal Simek <monstr@monstr.eu>
>  ---
>   arch/microblaze/kernel/prom.c        | 1653 ++++++++++++++++++++++++++++++++++
>   include/asm-microblaze/of_device.h   |   41 +
>   include/asm-microblaze/of_platform.h |   45 +
>   include/asm-microblaze/prom.h        |  311 +++++++

another mostly-clone from arch/powerpc/kernel.  Is anyone working on
moving the guts of this file to a common location?

Cheers,
g.

-- 
Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.
