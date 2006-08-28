Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from ns1.suse.de ([195.135.220.2]:7324 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S1751022AbWH1Om4 (ORCPT
	<rfc822;linux-arch@vger.kernel.org>);
	Mon, 28 Aug 2006 10:42:56 -0400
From: Andi Kleen <ak@suse.de>
Subject: Re: [PATCH 6/7] remove all remaining _syscallX macros
Date: Mon, 28 Aug 2006 16:42:21 +0200
References: <200608281003.02757.ak@suse.de> <1156759232.5340.36.camel@pmac.infradead.org> <200608281606.00602.arnd@arndb.de>
In-Reply-To: <200608281606.00602.arnd@arndb.de>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200608281642.21737.ak@suse.de>
Sender: linux-arch-owner@vger.kernel.org
To: Arnd Bergmann <arnd@arndb.de>
Cc: David Woodhouse <dwmw2@infradead.org>, David Miller <davem@davemloft.net>, linux-arch@vger.kernel.org, jdike@addtoit.com, B.Steinbrink@gmx.de, arjan@infradead.org, chase.venters@clientec.com, akpm@osdl.org, rmk+lkml@arm.linux.org.uk, rusty@rustcorp.com.au, linux-kernel@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>

On Monday 28 August 2006 16:05, Arnd Bergmann wrote:

> The patch below should address both these issues, as long as the libc
> has a working implementation of syscall(2).

I would prefer the _syscall() macros to stay independent of the 
actual glibc version. Or what do you do otherwise on a system
with old glibc? Upgrading glibc is normally a major PITA.

-Andi
