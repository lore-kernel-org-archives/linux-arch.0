Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from ns1.suse.de ([195.135.220.2]:53670 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S1751130AbWH1Pw4 (ORCPT
	<rfc822;linux-arch@vger.kernel.org>);
	Mon, 28 Aug 2006 11:52:56 -0400
From: Andi Kleen <ak@suse.de>
Subject: Re: [PATCH 6/7] remove all remaining _syscallX macros
Date: Mon, 28 Aug 2006 19:00:09 +0200
References: <200608281003.02757.ak@suse.de> <200608281642.21737.ak@suse.de> <20060828154634.GA3450@stusta.de>
In-Reply-To: <20060828154634.GA3450@stusta.de>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200608281900.10191.ak@suse.de>
Sender: linux-arch-owner@vger.kernel.org
To: Adrian Bunk <bunk@stusta.de>
Cc: Arnd Bergmann <arnd@arndb.de>, David Woodhouse <dwmw2@infradead.org>, David Miller <davem@davemloft.net>, linux-arch@vger.kernel.org, jdike@addtoit.com, B.Steinbrink@gmx.de, arjan@infradead.org, chase.venters@clientec.com, akpm@osdl.org, rmk+lkml@arm.linux.org.uk, rusty@rustcorp.com.au, linux-kernel@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>


> This would only be required if you'd upgrade the userspace kernel
> headers on this system to a version not matching the ones glibc was
> built against - and this has never been considered a good idea
> (it should work in theory, but not with our current header mess).

Sorry, but that's just utterly wrong. It has always worked. The kernel ABI
is stable on this level.

-Andi
