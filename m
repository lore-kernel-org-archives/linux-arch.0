Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from dsl027-180-168.sfo1.dsl.speakeasy.net ([216.27.180.168]:42949
	"EHLO sunset.davemloft.net") by vger.kernel.org with ESMTP
	id S965127AbWJBVLz (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Mon, 2 Oct 2006 17:11:55 -0400
Date: Mon, 02 Oct 2006 14:12:09 -0700 (PDT)
Message-Id: <20061002.141209.21618299.davem@davemloft.net>
Subject: Re: [PATCH 3/3] IRQ: Maintain regs pointer globally rather than
 passing to IRQ handlers
From: David Miller <davem@davemloft.net>
In-Reply-To: <Pine.LNX.4.64.0610021349090.3952@g5.osdl.org>
References: <20061002132116.2663d7a3.akpm@osdl.org>
	<20061002201836.GB31365@elte.hu>
	<Pine.LNX.4.64.0610021349090.3952@g5.osdl.org>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-arch-owner@vger.kernel.org
To: torvalds@osdl.org
Cc: mingo@elte.hu, akpm@osdl.org, dhowells@redhat.com, tglx@linutronix.de, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, dtor@mail.ru, greg@kroah.com, david-b@pacbell.net, stern@rowland.harvard.edu
List-ID: <linux-arch.vger.kernel.org>

From: Linus Torvalds <torvalds@osdl.org>
Date: Mon, 2 Oct 2006 13:54:33 -0700 (PDT)

> So if the patch works against my current tree, and nobody objects, I can 
> certainly apply it.
> 
> So speak up, people...

Since it provides a suitable nestability of the regs setting, I have
no objections.

