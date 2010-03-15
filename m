From: David Miller <davem@davemloft.net>
Subject: Re: 64-syscall args on 32-bit vs syscall()
Date: Sun, 14 Mar 2010 22:06:46 -0700 (PDT)
Message-ID: <20100314.220646.190065794.davem@davemloft.net>
References: <1268628493.2355.2.camel@pasglop>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from 74-93-104-97-Washington.hfc.comcastbusiness.net ([74.93.104.97]:37191
	"EHLO sunset.davemloft.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754082Ab0COFG1 (ORCPT
	<rfc822;linux-arch@vger.kernel.org>);
	Mon, 15 Mar 2010 01:06:27 -0400
In-Reply-To: <1268628493.2355.2.camel@pasglop>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: benh@kernel.crashing.org
Cc: linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org, kernel@teksavvy.com, drepper@redhat.com, torvalds@linux-foundation.org, munroesj@linux.vnet.ibm.com

From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Date: Mon, 15 Mar 2010 15:48:13 +1100

> As it is, any 32-bit app using syscall() on any of the syscalls that
> takes 64-bit arguments will be broken, unless the app itself breaks up
> the argument, but the the order of the hi and lo part is different
> between BE and LE architectures ;-)

I think it is even different on the same endian architectures,
f.e. mips I think.

There is no way to do this without some arch specific code
to handle things properly, really.
