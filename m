From: Will Deacon <will.deacon@arm.com>
Subject: Re: [PATCH v5 0/8] Add generic support for relaxed atomics
Date: Wed, 26 Aug 2015 11:41:00 +0100
Message-ID: <20150826104100.GB30466@arm.com>
References: <1438880084-18856-1-git-send-email-will.deacon@arm.com>
 <20150826042834.GA10432@fixme-laptop.cn.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from foss.arm.com ([217.140.101.70]:44395 "EHLO foss.arm.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932972AbbHZKlA (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Wed, 26 Aug 2015 06:41:00 -0400
Content-Disposition: inline
In-Reply-To: <20150826042834.GA10432@fixme-laptop.cn.ibm.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Boqun Feng <boqun.feng@gmail.com>
Cc: "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>, "Waiman.Long@hp.com" <Waiman.Long@hp.com>, "peterz@infradead.org" <peterz@infradead.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "paulmck@linux.vnet.ibm.com" <paulmck@linux.vnet.ibm.com>, "mingo@kernel.org" <mingo@kernel.org>

Hi Boqun,

On Wed, Aug 26, 2015 at 05:28:34AM +0100, Boqun Feng wrote:
> On Thu, Aug 06, 2015 at 05:54:36PM +0100, Will Deacon wrote:
> > Will Deacon (8):
> >   atomics: add acquire/release/relaxed variants of some atomic
> >     operations
> >   asm-generic: rework atomic-long.h to avoid bulk code duplication
> >   asm-generic: add relaxed/acquire/release variants for atomic_long_t
> >   lockref: remove homebrew cmpxchg64_relaxed macro definition
> >   locking/qrwlock: implement queue_write_unlock using smp_store_release
> >   locking/qrwlock: make use of acquire/release/relaxed atomics
> >   include/llist: use linux/atomic.h instead of asm/cmpxchg.h
> 
> Should we step further to privatize asm/cmpxchg.h entirely? Keep it only
> included in arch/*?
> 
> Because after your next patch, in some configurations, asm/cmpxchg.h of
> ARM only provides the definition of {cmpxchg,xchg}_relaxed, others are
> built in linux/atomic.h. Further more, other architecture may implement
> asm/cmpxchg.h similarly in the future. So, IIUC, we actually don't
> guarantee all cmpxchg(), xchg() and their variants are defined in
> asm/cmpxchg.h.
> 
> Though current users of asm/cmpxchg.h outside arch/* are fine,
> because they all happen to have got linux/atomic.h included. But we'd
> better change the current users and call out that asm/cmpxchg.h is
> privatized in the document.
> 
> >   ARM: atomics: define our SMP atomics in terms of _relaxed operations
> 
> 
> Consider this patch maybe? I did a simple build test on X86.

I'm not sure that the addition to Documentation/atomic_ops.txt is really
worth it, but either way:

  Acked-by: Will Deacon <will.deacon@arm.com>

It's probably best to send this as a standalone patch, since the relaxed
parts are already queued in -tip.

Will

> -----------------------------------------------------------------------
> Subject: [PATCH] atomics,cmpxchg: Privatize the inclusion of asm/cmpxchg.h
> 
> After commit:
> 
> atomics: add acquire/release/relaxed variants of some atomic operations
> 
> Architectures may only provide {cmp,}xchg_relaxed definitions in
> asm/cmpxchg.h. Other variants, such as {cmp,}xchg, may be built in
> linux/atomic.h, which means simply including asm/cmpxchg.h may not get
> the definitions of all the{cmp,}xchg variants. Therefore, we should
> privatize the inclusions of asm/cmpxchg.h to keep it only included in
> arch/* and replace the inclusions outside with linux/atomic.h
> 
> Signed-off-by: Boqun Feng <boqun.feng@gmail.com>
> ---
>  Documentation/atomic_ops.txt        | 4 ++++
>  drivers/net/ethernet/sfc/mcdi.c     | 2 +-
>  drivers/phy/phy-rcar-gen2.c         | 3 +--
>  drivers/staging/speakup/selection.c | 2 +-
>  4 files changed, 7 insertions(+), 4 deletions(-)
> 
> diff --git a/Documentation/atomic_ops.txt b/Documentation/atomic_ops.txt
> index b19fc34..c9d1cac 100644
> --- a/Documentation/atomic_ops.txt
> +++ b/Documentation/atomic_ops.txt
> @@ -542,6 +542,10 @@ The routines xchg() and cmpxchg() must provide the same exact
>  memory-barrier semantics as the atomic and bit operations returning
>  values.
>  
> +Note: If someone wants to use xchg(), cmpxchg() and their variants,
> +linux/atomic.h should be included rather than asm/cmpxchg.h, unless
> +the code is in arch/* and can take care of itself.
> +
>  Spinlocks and rwlocks have memory barrier expectations as well.
>  The rule to follow is simple:
>  
> diff --git a/drivers/net/ethernet/sfc/mcdi.c b/drivers/net/ethernet/sfc/mcdi.c
> index 81640f8..968383e 100644
> --- a/drivers/net/ethernet/sfc/mcdi.c
> +++ b/drivers/net/ethernet/sfc/mcdi.c
> @@ -9,7 +9,7 @@
>  
>  #include <linux/delay.h>
>  #include <linux/moduleparam.h>
> -#include <asm/cmpxchg.h>
> +#include <linux/atomic.h>
>  #include "net_driver.h"
>  #include "nic.h"
>  #include "io.h"
> diff --git a/drivers/phy/phy-rcar-gen2.c b/drivers/phy/phy-rcar-gen2.c
> index 39d9b29..117b495 100644
> --- a/drivers/phy/phy-rcar-gen2.c
> +++ b/drivers/phy/phy-rcar-gen2.c
> @@ -17,8 +17,7 @@
>  #include <linux/phy/phy.h>
>  #include <linux/platform_device.h>
>  #include <linux/spinlock.h>
> -
> -#include <asm/cmpxchg.h>
> +#include <linux/atomic.h>
>  
>  #define USBHS_LPSTS			0x02
>  #define USBHS_UGCTRL			0x80
> diff --git a/drivers/staging/speakup/selection.c b/drivers/staging/speakup/selection.c
> index a031570..81c0888 100644
> --- a/drivers/staging/speakup/selection.c
> +++ b/drivers/staging/speakup/selection.c
> @@ -7,7 +7,7 @@
>  #include <linux/workqueue.h>
>  #include <linux/tty.h>
>  #include <linux/tty_flip.h>
> -#include <asm/cmpxchg.h>
> +#include <linux/atomic.h>
>  
>  #include "speakup.h"
> 
