From: "Grant Likely" <grant.likely@secretlab.ca>
Subject: Re: [PATCH 01/56] microblaze_v2: Kconfig patches
Date: Sun, 4 May 2008 15:24:25 -0600
Message-ID: <fa686aa40805041424x26de27a1g16959e7b9c7ddbf2@mail.gmail.com>
References: <1209901305-6404-1-git-send-email-monstr@seznam.cz>
	 <a4a778e34c66d126f5c4bf1ca423cf32950ea5ab.1209897266.git.monstr@monstr.eu>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from an-out-0708.google.com ([209.85.132.248]:41740 "EHLO
	an-out-0708.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753128AbYEDVY2 (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Sun, 4 May 2008 17:24:28 -0400
Received: by an-out-0708.google.com with SMTP id d40so486431and.103
        for <linux-arch@vger.kernel.org>; Sun, 04 May 2008 14:24:27 -0700 (PDT)
In-Reply-To: <a4a778e34c66d126f5c4bf1ca423cf32950ea5ab.1209897266.git.monstr@monstr.eu>
Content-Disposition: inline
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: monstr@seznam.cz
Cc: linux-kernel@vger.kernel.org, arnd@arndb.de, linux-arch@vger.kernel.org, stephen.neuendorffer@xilinx.com, John.Linn@xilinx.com, john.williams@petalogix.com, matthew@wil.cx, will.newton@gmail.com, drepper@redhat.com, microblaze-uclinux@itee.uq.edu.au, Michal Simek <monstr@monstr.eu>

On Sun, May 4, 2008 at 5:40 AM,  <monstr@seznam.cz> wrote:
> From: Michal Simek <monstr@monstr.eu>
>
>
>  Signed-off-by: Michal Simek <monstr@monstr.eu>

>  diff --git a/arch/microblaze/Kconfig b/arch/microblaze/Kconfig
>  new file mode 100644
>  index 0000000..49767d1
>  --- /dev/null
>  +++ b/arch/microblaze/Kconfig
<snip>
>  +config XILINX_UNCACHED_SHADOW
>  +       bool "Are you using uncached shadow for RAM ?"
>  +       depends on MICROBLAZE

Isn't CONFIG_MICROBLAZE a given?


>  diff --git a/arch/microblaze/platform/Kconfig.platform b/arch/microblaze/platform/Kconfig.platform
>  new file mode 100644
>  index 0000000..64cbb80
>  --- /dev/null
>  +++ b/arch/microblaze/platform/Kconfig.platform
<snip>
>  +config HACK
>  +       bool "Increase performance"
>  +       default y

Is this appropriate for mainline?  If so, it should have a better
description.  :-)

Cheers,
g.

-- 
Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.
