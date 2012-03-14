From: David Howells <dhowells@redhat.com>
Subject: Re: [ORLinux] [PATCH 17/35] Make asm-generic/cmpxchg.h #include asm-generic/cmpxchg-local.h [ver #2]
Date: Wed, 14 Mar 2012 11:10:00 +0000
Message-ID: <11556.1331723400@redhat.com>
References: <CACM3HyHaFqVBaALMNB9dTE+7JrT1qD0jrYtV2PzwTskv8sW4Hg@mail.gmail.com> <20120312233602.13888.27659.stgit@warthog.procyon.org.uk> <20120312233858.13888.34822.stgit@warthog.procyon.org.uk> <201203130900.41993.arnd@arndb.de>
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:41532 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752002Ab2CNLKO (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Wed, 14 Mar 2012 07:10:14 -0400
In-Reply-To: <CACM3HyHaFqVBaALMNB9dTE+7JrT1qD0jrYtV2PzwTskv8sW4Hg@mail.gmail.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Jonas Bonn <jonas.bonn@gmail.com>
Cc: dhowells@redhat.com, Arnd Bergmann <arnd@arndb.de>, linux-arch@vger.kernel.org, linux@openrisc.net, linux-kernel@vger.kernel.org, paul.gortmaker@windriver.com, hpa@zytor.com, torvalds@linux-foundation.org

Jonas Bonn <jonas.bonn@gmail.com> wrote:

> --- a/include/asm-generic/bitops/atomic.h
> +++ b/include/asm-generic/bitops/atomic.h
> @@ -2,7 +2,6 @@
>  #define _ASM_GENERIC_BITOPS_ATOMIC_H_
> 
>  #include <asm/types.h>
> -#include <asm/system.h>
> 
>  #ifdef CONFIG_SMP
>  #include <asm/spinlock.h>

That's actually done in patch 33.  I wouldn't want to remove that if I can
avoid it until after all the arches have been altered.

David
