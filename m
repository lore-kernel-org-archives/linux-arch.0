From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH 17/35] Make asm-generic/cmpxchg.h #include asm-generic/cmpxchg-local.h [ver #2]
Date: Tue, 13 Mar 2012 09:00:41 +0000
Message-ID: <201203130900.41993.arnd@arndb.de>
References: <20120312233602.13888.27659.stgit@warthog.procyon.org.uk> <20120312233858.13888.34822.stgit@warthog.procyon.org.uk>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.17.8]:61400 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965016Ab2CMJwv (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Tue, 13 Mar 2012 05:52:51 -0400
In-Reply-To: <20120312233858.13888.34822.stgit@warthog.procyon.org.uk>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: David Howells <dhowells@redhat.com>
Cc: paul.gortmaker@windriver.com, hpa@zytor.com, torvalds@linux-foundation.org, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, linux@openrisc.net

On Monday 12 March 2012, David Howells wrote:
> Make asm-generic/cmpxchg.h #include asm-generic/cmpxchg-local.h as all arch
> files that #include the former also #include the latter.  See:
> 
>         grep -rl asm-generic/cmpxchg-local[.]h arch/ | sort > b
>         grep -rl asm-generic/cmpxchg[.]h arch/ | sort > a
>         comm a b
> 
> This simplifies the disintegration of asm-generic/system.h for arches that
> don't have their own.
> 
> Signed-off-by: David Howells <dhowells@redhat.com>
> cc: Arnd Bergmann <arnd@arndb.de>

Acked-by: Arnd Bergmann <arnd@arndb.de>

I would suggest we merge this one through the openrisc tree, along with the
other asm-generic patches in your series.

asm-generic patches tend to have dependencies on other stuff and they
rarely conflict with one another, so generally my preference is to have
them sent by whoever needs them, with my ack.

	Arnd
