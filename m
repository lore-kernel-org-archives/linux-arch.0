Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from 74-93-104-97-Washington.hfc.comcastbusiness.net ([74.93.104.97]:36809
	"EHLO sunset.davemloft.net" rhost-flags-OK-FAIL-OK-OK)
	by vger.kernel.org with ESMTP id S1754500AbXE2KZv (ORCPT
	<rfc822;linux-arch@vger.kernel.org>);
	Tue, 29 May 2007 06:25:51 -0400
Date: Tue, 29 May 2007 03:26:03 -0700 (PDT)
Message-Id: <20070529.032603.59469832.davem@davemloft.net>
Subject: Re: [CFT] read+shared mmap write+read data corruption
From: David Miller <davem@davemloft.net>
In-Reply-To: <20070529091252.GA4832@flint.arm.linux.org.uk>
References: <20070528124411.GA31764@xi.wantstofly.org>
	<20070528.223550.39158516.davem@davemloft.net>
	<20070529091252.GA4832@flint.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-arch-owner@vger.kernel.org
To: rmk@arm.linux.org.uk
Cc: buytenh@wantstofly.org, James.Bottomley@steeleye.com, linux-arch@vger.kernel.org, akpm@linux-foundation.org
List-ID: <linux-arch.vger.kernel.org>

From: Russell King <rmk@arm.linux.org.uk>
Date: Tue, 29 May 2007 10:12:52 +0100

> Could we have PG_arch_2 as bit 13 for this purpose, guaranteed to be
> cleared on page cache page allocation?  IOW, same rules as far as the
> non-arch code is concerned as PG_arch_1.

I don't think there will be much objection to adding one more arch bit
:-)
