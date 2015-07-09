From: Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH v2] mm: cleaning per architecture MM hook header files
Date: Thu, 9 Jul 2015 16:09:34 -0700
Message-ID: <20150709160934.888dad2b24ce45957e65b139@linux-foundation.org>
References: <55924508.9080101@synopsys.com>
	<1435745853-27535-1-git-send-email-ldufour@linux.vnet.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mail.linuxfoundation.org ([140.211.169.12]:53864 "EHLO
	mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750744AbbGIXJf (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Thu, 9 Jul 2015 19:09:35 -0400
In-Reply-To: <1435745853-27535-1-git-send-email-ldufour@linux.vnet.ibm.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Laurent Dufour <ldufour@linux.vnet.ibm.com>
Cc: Vineet Gupta <Vineet.Gupta1@synopsys.com>, Geert Uytterhoeven <geert@linux-m68k.org>, uclinux-h8-devel@lists.sourceforge.jp, linux-arch@vger.kernel.org, linux-mm@kvack.org, linux-kernel@vger.kernel.org, Oleg Nesterov <oleg@redhat.com>

On Wed,  1 Jul 2015 12:17:33 +0200 Laurent Dufour <ldufour@linux.vnet.ibm.com> wrote:

> The commit 2ae416b142b6 ("mm: new mm hook framework") introduced an empty
> header file (mm-arch-hooks.h) for every architecture, even those which
> doesn't need to define mm hooks.
> 
> As suggested by Geert Uytterhoeven, this could be cleaned through the use
> of a generic header file included via each per architecture
> asm/include/Kbuild file.
> 
> The PowerPC architecture is not impacted here since this architecture has
> to defined the arch_remap MM hook.

So the way this works is that if an arch wants to override a hook, it
will remove the "generic-y += mm-arch-hooks.h" and add
arch/XXX/include/asm/mm-arch-hooks.h, yes?

And the new arch/XXX/include/asm/mm-arch-hooks.h only needs to define
the hook(s) which the arch wants to override?

So nothing will ever be added to include/asm-generic/mm-arch-hooks.h?

Seems fair enough.

Oleg is angling to remove arch_remap(), so there won't be anything left
in these files!  But there are plenty of ad-hoc things which *should*
be moved over.

> Changes in V2:
> --------------
>  - Vineet Gupta reported that the Kbuild files should be kept sorted.

Yes, we do this to avoid patch collisions.  Everyone always adds stuff
to the end of the list (Makefiles, #includes, etc etc), thus carefully
maximizing the number of patch collisions :(
