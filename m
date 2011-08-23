From: Mark Salter <msalter@redhat.com>
Subject: Re: [PATCH 18/24] C6X: headers
Date: Tue, 23 Aug 2011 09:43:17 -0400
Message-ID: <1314106998.2404.47.camel@deneb.redhat.com>
References: <1314043785-2880-1-git-send-email-msalter@redhat.com>
	 <1314043785-2880-19-git-send-email-msalter@redhat.com>
	 <1328178.VkYhLNAX5s@wuerfel>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:41132 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755331Ab1HWNnV (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Tue, 23 Aug 2011 09:43:21 -0400
In-Reply-To: <1328178.VkYhLNAX5s@wuerfel>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Arnd Bergmann <arnd@arndb.de>
Cc: linux-arch@vger.kernel.org

On Mon, 2011-08-22 at 23:14 +0200, Arnd Bergmann wrote:
> On Monday 22 August 2011 16:09:39 Mark Salter wrote:
> > Signed-off-by: Mark Salter <msalter@redhat.com>
> 
> > 
> > diff --git a/arch/c6x/include/asm/asm-offsets.h b/arch/c6x/include/asm/asm-offsets.h
> > new file mode 100644
> > index 0000000..d370ee3
> > --- /dev/null
> > +++ b/arch/c6x/include/asm/asm-offsets.h
> > @@ -0,0 +1 @@
> > +#include <generated/asm-offsets.h>
> 
> I wonder if it makes sense to install this file in asm-generic/asm-offsets.h
> and referencing it like the other files.

I think so. It is the same for all arches.

> 
> > +#include <asm-generic/bitops/hweight.h>
> 
> Do you have an instruction that can be used for hweight? That is often a useful
> optimization.

Hmm, there is a bit count instruction, but it counts bits within octets
of a 32 bit register, so it ends with 4 sums that would need shifting
and adding. Even so, a little asm here would be a good optimization. All
of the bitops need a look for such optimizations because of how well
DSPs support bit manipulations.

--Mark
