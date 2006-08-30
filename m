Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail.suse.de ([195.135.220.2]:38815 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S1750775AbWH3HZB (ORCPT
	<rfc822;linux-arch@vger.kernel.org>);
	Wed, 30 Aug 2006 03:25:01 -0400
From: Andi Kleen <ak@suse.de>
Subject: Re: [PATCH 6/7] remove all remaining _syscallX macros
Date: Wed, 30 Aug 2006 09:22:09 +0200
References: <200608281003.02757.ak@suse.de> <200608281642.21737.ak@suse.de> <44F525BC.4020608@zytor.com>
In-Reply-To: <44F525BC.4020608@zytor.com>
MIME-Version: 1.0
Content-Disposition: inline
Message-Id: <200608300922.09436.ak@suse.de>
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Sender: linux-arch-owner@vger.kernel.org
To: "H. Peter Anvin" <hpa@zytor.com>
Cc: Arnd Bergmann <arnd@arndb.de>, David Woodhouse <dwmw2@infradead.org>, David Miller <davem@davemloft.net>, linux-arch@vger.kernel.org, jdike@addtoit.com, B.Steinbrink@gmx.de, arjan@infradead.org, chase.venters@clientec.com, akpm@osdl.org, rmk+lkml@arm.linux.org.uk, rusty@rustcorp.com.au, linux-kernel@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>


> Why don't you just have a private version of the macros?

Because I don't write a libc, just test programs, preferably
without a huge amount of cut'n'pasted code

-Andi
