Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.126.188]:17900 "EHLO
	moutng.kundenserver.de") by vger.kernel.org with ESMTP
	id S1751414AbWH1IJn (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Mon, 28 Aug 2006 04:09:43 -0400
From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH 6/7] remove all remaining _syscallX macros
Date: Mon, 28 Aug 2006 10:09:10 +0200
References: <20060827214734.252316000@klappe.arndb.de> <200608280941.10965.arnd@arndb.de> <1156751177.3034.158.camel@laptopd505.fenrus.org>
In-Reply-To: <1156751177.3034.158.camel@laptopd505.fenrus.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200608281009.11352.arnd@arndb.de>
Sender: linux-arch-owner@vger.kernel.org
To: Arjan van de Ven <arjan@infradead.org>
Cc: Andi Kleen <ak@suse.de>, linux-arch@vger.kernel.org, Jeff Dike <jdike@addtoit.com>, Bjoern Steinbrink <B.Steinbrink@gmx.de>, Chase Venters <chase.venters@clientec.com>, Andrew Morton <akpm@osdl.org>, Russell King <rmk+lkml@arm.linux.org.uk>, rusty@rustcorp.com.au, linux-kernel@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>

On Monday 28 August 2006 09:46, Arjan van de Ven wrote:
> we or the (g)libc headers ?
> 
I don't think having libc do it. In order to use these macros,
you always had to #include <linux/unistd.h> or <asm/unistd.h>.

Putting the headers into a libc file means that user code
would need to change its includes, when it really should
just use <sys/syscall.h>.

Changing the libc copy of asm/unistd.h is against our current
plan to get to a point where `make headers_install' gets
you a working tree. _If_ we want to have it in there, it needs
to be in the kernel source.

	Arnd <><
