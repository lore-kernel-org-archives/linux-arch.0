From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [GIT PULL] Disintegrate and kill asm/system.h
Date: Wed, 28 Mar 2012 21:24:41 -0700
Message-ID: <CA+55aFzn=bsH76hPDUgS-FBP=RVu51gwmRdqjkw5RJO=Q_cRfA@mail.gmail.com>
References: <5599.1332958811@redhat.com> <30702.1332989444@neuling.org>
 <20120329135555.06593144b65bf81cc9191f8a@canb.auug.org.au> <20120329151544.ef2117821dfb459e8b52af48@canb.auug.org.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mail-ey0-f174.google.com ([209.85.215.174]:43803 "EHLO
	mail-ey0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750859Ab2C2EZD convert rfc822-to-8bit (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Thu, 29 Mar 2012 00:25:03 -0400
In-Reply-To: <20120329151544.ef2117821dfb459e8b52af48@canb.auug.org.au>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Stephen Rothwell <sfr@canb.auug.org.au>
Cc: Michael Neuling <mikey@neuling.org>, David Howells <dhowells@redhat.com>, Grant Likely <grant.likely@secretlab.ca>, akpm@linux-foundation.org, linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org, paul.gortmaker@windriver.com, arnd@arndb.de, hpa@zytor.com, ppc-dev <linuxppc-dev@lists.ozlabs.org>

On Wed, Mar 28, 2012 at 9:15 PM, Stephen Rothwell <sfr@canb.auug.org.au=
> wrote:
>
> The following patch fixes (as much as possible) a powerpc allyesconfi=
g build.

Ugh:

> diff --git a/kernel/irq/irqdomain.c b/kernel/irq/irqdomain.c
> index af48e59..1f94ddf 100644
> --- a/kernel/irq/irqdomain.c
> +++ b/kernel/irq/irqdomain.c
> @@ -12,6 +12,9 @@
> =A0#include <linux/slab.h>
> =A0#include <linux/smp.h>
> =A0#include <linux/fs.h>
> +#ifdef CONFIG_VIRQ_DEBUG
> +#include <asm/debug.h>
> +#endif

Can we please move that abortion into arch/powerpc/? Instead of making
generic code even uglier..

                       Linus
