Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.126.187]:53453 "EHLO
	moutng.kundenserver.de") by vger.kernel.org with ESMTP
	id S965159AbWIEFtX (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Tue, 5 Sep 2006 01:49:23 -0400
From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH 3/9] actual generic PAGE_SIZE infrastructure
Date: Tue, 5 Sep 2006 07:49:07 +0200
References: <20060901190805.C906A21A@localhost.localdomain> <20060901190807.522EDD97@localhost.localdomain> <1157434085.2413.22.camel@shinybook.infradead.org>
In-Reply-To: <1157434085.2413.22.camel@shinybook.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200609050749.07639.arnd@arndb.de>
Sender: linux-arch-owner@vger.kernel.org
To: David Woodhouse <dwmw2@infradead.org>
Cc: Dave Hansen <haveblue@us.ibm.com>, linux-arch@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>

On Tuesday 05 September 2006 07:28, David Woodhouse wrote:
> It does look like you've correctly refrained from making the new
> PAGE_SIZE definitions visible to userspace, which is good. Userspace
> should be using sysconf(), not hardcoded PAGE_SIZE.

With generic PAGE_SIZE, it's not even possible to making the definitions
visible to user space, because CONFIG_* can not be exported in the
first place.

linux-libc-headers apparently exported something anyway, in the form
of

#include <unistd.h>
#define PAGE_SIZE ((unsigned long)getpagesize())
#define PAGE_SHIFT ((PAGE_SIZE > 65536) ? -1 : ((unsigned long[]){12,13,14,-1,15,-1,-1,-1,16}[PAGE_SIZE>>13]))
#define PAGE_MASK    (~(PAGE_SIZE-1))

This looks like a reasonable implementation, I wonder if we should
have something like this in the #ifndef __KERNEL__ part of
asm-generic/page.h.

	Arnd <><
