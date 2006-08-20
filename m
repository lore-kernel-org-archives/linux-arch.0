Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from pentafluge.infradead.org ([213.146.154.40]:35796 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S1751195AbWHTTv0 (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Sun, 20 Aug 2006 15:51:26 -0400
Subject: Re: [PATCH] introduce kernel_execve function to replace
	__KERNEL_SYSCALLS__
From: Arjan van de Ven <arjan@infradead.org>
In-Reply-To: <20060820194552.GB11843@atjola.homenet>
References: <20060819073031.GA25711@atjola.homenet>
	 <200608201237.13194.chase.venters@clientec.com>
	 <20060820112523.f14fc6dc.akpm@osdl.org>
	 <200608201333.02951.chase.venters@clientec.com>
	 <20060820194552.GB11843@atjola.homenet>
Content-Type: text/plain
Date: Sun, 20 Aug 2006 21:50:46 +0200
Message-Id: <1156103446.23756.60.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-arch-owner@vger.kernel.org
To: =?ISO-8859-1?Q?Bj=F6rn?= Steinbrink <B.Steinbrink@gmx.de>
Cc: Chase Venters <chase.venters@clientec.com>, Andrew Morton <akpm@osdl.org>, Arnd Bergmann <arnd@arndb.de>, Russell King <rmk+lkml@arm.linux.org.uk>, rusty@rustcorp.com.au, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>

\
> Could we rename __syscall_return to IS_SYS_ERR (or whatever) and force
> kernel syscall users to do the check? That way we could eliminate errno

s/users/user/ .. there's one left that should die out soon ;)


