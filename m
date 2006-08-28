Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from dsl027-180-168.sfo1.dsl.speakeasy.net ([216.27.180.168]:27583
	"EHLO sunset.davemloft.net") by vger.kernel.org with ESMTP
	id S1751416AbWH1IJq (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Mon, 28 Aug 2006 04:09:46 -0400
Date: Mon, 28 Aug 2006 01:09:48 -0700 (PDT)
Message-Id: <20060828.010948.131918560.davem@davemloft.net>
Subject: Re: [PATCH 6/7] remove all remaining _syscallX macros
From: David Miller <davem@davemloft.net>
In-Reply-To: <200608281003.02757.ak@suse.de>
References: <200608280950.04441.ak@suse.de>
	<200608281001.39381.arnd@arndb.de>
	<200608281003.02757.ak@suse.de>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-arch-owner@vger.kernel.org
To: ak@suse.de
Cc: arnd@arndb.de, linux-arch@vger.kernel.org, jdike@addtoit.com, B.Steinbrink@gmx.de, arjan@infradead.org, chase.venters@clientec.com, akpm@osdl.org, rmk+lkml@arm.linux.org.uk, rusty@rustcorp.com.au, linux-kernel@vger.kernel.org, dwmw2@infradead.org
List-ID: <linux-arch.vger.kernel.org>

From: Andi Kleen <ak@suse.de>
Date: Mon, 28 Aug 2006 10:03:02 +0200

> Thanks for brining it to my attention. I indeed think think the
> patch was wrong.

I disagree, this stuff really doesn't have a strong argument
for existence.
