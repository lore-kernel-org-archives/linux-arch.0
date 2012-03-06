From: Mark Salter <msalter@redhat.com>
Subject: Re: lib/string.h build failure in linux-next
Date: Tue, 06 Mar 2012 11:16:17 -0500
Message-ID: <1331050578.17099.13.camel@deneb.redhat.com>
References: <1331048540.17099.9.camel@deneb.redhat.com>
	 <201203061602.23512.arnd@arndb.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:2104 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755060Ab2CFQQW (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Tue, 6 Mar 2012 11:16:22 -0500
In-Reply-To: <201203061602.23512.arnd@arndb.de>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Arnd Bergmann <arnd@arndb.de>
Cc: linux-kernel <linux-kernel@vger.kernel.org>, linux-next <linux-next@vger.kernel.org>, linux-arch <linux-arch@vger.kernel.org>

On Tue, 2012-03-06 at 16:02 +0000, Arnd Bergmann wrote:
> On Tuesday 06 March 2012, Mark Salter wrote:
> > I'm seeing a build failure in lib/string.h in linux-next:
> > 
> > /es/linux/linux-next/lib/string.c: In function 'strlcat':
> > /es/linux/linux-next/lib/string.c:225:2: error: implicit declaration of function 'printk'
> > /es/linux/linux-next/lib/string.c:225:2: error: implicit declaration of function 'panic'
> > 
> > Commit e2950c2b6ecb928bfd3a13dd237df1f29f712704 removed an include of
> > linux/module.h which triggered the problem for arch/c6x and probably
> > other architectures using the asm-generic BUG macro.
> > 
> > I think this needs fixing in asm-generic/bug.h which should include
> > linux/kernel.h for panic and linux/printk.h for printk.
> 
> I think you cannot do that as long as linux/kernel.h includes asm/bug.h,
> or you will get a lot of other build failures.

It didn't for my build, but to tell the truth, I really wasn't too keen
on adding an include of kernel.h to asm/bug.h since kernel.h pulls in so
much other stuff.

> 
> The safer option is probably to add the two missing headers separately
> to string.c.

Okay, I can put together a patch that does that.

--Mark
