Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from terminus.zytor.com ([192.83.249.54]:33947 "EHLO
	terminus.zytor.com") by vger.kernel.org with ESMTP id S1750823AbWH3Fm7
	(ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Wed, 30 Aug 2006 01:42:59 -0400
Message-ID: <44F524EE.90304@zytor.com>
Date: Tue, 29 Aug 2006 22:41:02 -0700
From: "H. Peter Anvin" <hpa@zytor.com>
MIME-Version: 1.0
Subject: Re: [PATCH 4/7] Remove the use of _syscallX macros in UML
References: <20060827214734.252316000@klappe.arndb.de> <20060827215636.797086000@klappe.arndb.de>
In-Reply-To: <20060827215636.797086000@klappe.arndb.de>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-arch-owner@vger.kernel.org
To: Arnd Bergmann <arnd@arndb.de>
Cc: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, Jeff Dike <jdike@addtoit.com>, Bjoern Steinbrink <B.Steinbrink@gmx.de>, Arjan van de Ven <arjan@infradead.org>, Chase Venters <chase.venters@clientec.com>, Andrew Morton <akpm@osdl.org>, Russell King <rmk+lkml@arm.linux.org.uk>, rusty@rustcorp.com.au
List-ID: <linux-arch.vger.kernel.org>

Arnd Bergmann wrote:
> User mode linux uses _syscallX() to call into the host kernel.
> The recommended way to do this is to use the syscall() function
> from libc.

Not really.

syscall() is a horrible botch; it is in fact unimplementable (without 
enormous switch statements) on a number of architectures.

	-hpa
