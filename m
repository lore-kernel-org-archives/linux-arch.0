Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from saraswathi.solana.com ([198.99.130.12]:46242 "EHLO
	saraswathi.solana.com") by vger.kernel.org with ESMTP
	id S932245AbWHVNl0 (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Tue, 22 Aug 2006 09:41:26 -0400
Date: Tue, 22 Aug 2006 09:39:45 -0400
From: Jeff Dike <jdike@addtoit.com>
Subject: Re: [PATCH] introduce kernel_execve function to replace __KERNEL_SYSCALLS__
Message-ID: <20060822133945.GA3813@ccure.user-mode-linux.org>
References: <20060819073031.GA25711@atjola.homenet> <1156231742.21752.101.camel@localhost.localdomain> <20060822080046.GA22572@atjola.homenet> <200608221207.00344.arnd@arndb.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200608221207.00344.arnd@arndb.de>
Sender: linux-arch-owner@vger.kernel.org
To: Arnd Bergmann <arnd@arndb.de>
Cc: Bj?rn Steinbrink <B.Steinbrink@gmx.de>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Paul Mackerras <paulus@samba.org>, Russell King <rmk+lkml@arm.linux.org.uk>, Andrew Morton <akpm@osdl.org>, rusty@rustcorp.com.au, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>

On Tue, Aug 22, 2006 at 12:06:59PM +0200, Arnd Bergmann wrote:
> UML can be converted to use the syscall function provided by libc
> in order to call the host OS.

You're contemplating changing UML to do, e.g.
	syscall(NR_write, fd, buf, len)
instead of the current
	write(fd, buf,len)
?

That hardly seems like an improvement and it seems fairly unnecessary.

				Jeff
