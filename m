Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from dsl027-180-168.sfo1.dsl.speakeasy.net ([216.27.180.168]:11488
	"EHLO sunset.davemloft.net") by vger.kernel.org with ESMTP
	id S1422979AbWJTVav (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Fri, 20 Oct 2006 17:30:51 -0400
Date: Fri, 20 Oct 2006 14:30:51 -0700 (PDT)
Message-Id: <20061020.143051.102576722.davem@davemloft.net>
Subject: Re: [PATCH 1/3] Fix COW D-cache aliasing on fork
From: David Miller <davem@davemloft.net>
In-Reply-To: <20061020211723.GF8894@flint.arm.linux.org.uk>
References: <20061020205929.GE8894@flint.arm.linux.org.uk>
	<20061020.140619.11628819.davem@davemloft.net>
	<20061020211723.GF8894@flint.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-arch-owner@vger.kernel.org
To: rmk+lkml@arm.linux.org.uk
Cc: torvalds@osdl.org, nickpiggin@yahoo.com.au, ralf@linux-mips.org, akpm@osdl.org, linux-kernel@vger.kernel.org, anemo@mba.ocn.ne.jp, linux-arch@vger.kernel.org, schwidefsky@de.ibm.com
List-ID: <linux-arch.vger.kernel.org>

From: Russell King <rmk+lkml@arm.linux.org.uk>
Date: Fri, 20 Oct 2006 22:17:23 +0100

> I did say I had a VIVT cache.

And everything I said was premised with this understanding :-)
