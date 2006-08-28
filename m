Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.126.187]:56525 "EHLO
	moutng.kundenserver.de") by vger.kernel.org with ESMTP
	id S1751271AbWH1IB7 (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Mon, 28 Aug 2006 04:01:59 -0400
From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH 6/7] remove all remaining _syscallX macros
Date: Mon, 28 Aug 2006 10:01:38 +0200
References: <20060827214734.252316000@klappe.arndb.de> <200608280941.10965.arnd@arndb.de> <200608280950.04441.ak@suse.de>
In-Reply-To: <200608280950.04441.ak@suse.de>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200608281001.39381.arnd@arndb.de>
Sender: linux-arch-owner@vger.kernel.org
To: Andi Kleen <ak@suse.de>
Cc: linux-arch@vger.kernel.org, Jeff Dike <jdike@addtoit.com>, Bjoern Steinbrink <B.Steinbrink@gmx.de>, Arjan van de Ven <arjan@infradead.org>, Chase Venters <chase.venters@clientec.com>, Andrew Morton <akpm@osdl.org>, Russell King <rmk+lkml@arm.linux.org.uk>, rusty@rustcorp.com.au, linux-kernel@vger.kernel.org, David Woodhouse <dwmw2@infradead.org>
List-ID: <linux-arch.vger.kernel.org>

On Monday 28 August 2006 09:50, Andi Kleen wrote:
> Or just keep the current ones that work fine? 
> 

Are you sure they do? Since dwmw2 did the changeset 
56142536868a2be34f261ed8fdca1610f8a73fbd, they are all inside
#ifdef __KERNEL__. You may argue that merging that patch was
wrong and it should be reverted, but now that we have it, the 
code is not relevant for user space anymore.

	Arnd <><
