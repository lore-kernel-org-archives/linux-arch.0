From: Sam Ravnborg <sam@ravnborg.org>
Subject: Re: [RFC] remove linux/hardirq.h from asm-generic/local.h
Date: Wed, 17 Dec 2008 06:45:51 +0100
Message-ID: <20081217054551.GA2983@uranus.ravnborg.org>
References: <20081214133941.GA18035@flint.arm.linux.org.uk> <20081214095803.9d16e85f.akpm@linux-foundation.org> <20081216184704.GA4976@x200.localdomain> <20081216183547.de79b7f0.akpm@linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from pfepa.post.tele.dk ([195.41.46.235]:45865 "EHLO
	pfepa.post.tele.dk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751207AbYLQFoZ (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Wed, 17 Dec 2008 00:44:25 -0500
Content-Disposition: inline
In-Reply-To: <20081216183547.de79b7f0.akpm@linux-foundation.org>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Alexey Dobriyan <adobriyan@gmail.com>, Russell King <rmk+lkml@arm.linux.org.uk>, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org

> > +++ b/arch/sparc64/kernel/mdesc.c
> > @@ -11,6 +11,7 @@
> >  #include <linux/mm.h>
> >  #include <linux/miscdevice.h>
> >  
> > +#include <asm/cpudata.h>
> >  #include <asm/hypervisor.h>
> >  #include <asm/mdesc.h>
> >  #include <asm/prom.h>
> > diff --git a/arch/sparc64/kernel/sysfs.c b/arch/sparc64/kernel/sysfs.c
> > index 84e5ce1..d28f496 100644
> > --- a/arch/sparc64/kernel/sysfs.c
> > +++ b/arch/sparc64/kernel/sysfs.c
> > @@ -8,6 +8,7 @@
> >  #include <linux/percpu.h>
> >  #include <linux/init.h>
> >  
> > +#include <asm/cpudata.h>
> >  #include <asm/hypervisor.h>
> >  #include <asm/spitfire.h>
> 
> hm, the two sparc64 files have just magically disappeared from linux-next.

s/magically/by hard work/ ;-)

We have unified sparc and sparc64 so all files lives in
arch/sparc/* these days.
Feed the sparc64 bits to davem and he will take care.
Or I can do it if you like.

	Sam
