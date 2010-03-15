From: David Miller <davem@davemloft.net>
Subject: Re: 64-syscall args on 32-bit vs syscall()
Date: Sun, 14 Mar 2010 22:54:43 -0700 (PDT)
Message-ID: <20100314.225443.150715656.davem@davemloft.net>
References: <1268628493.2355.2.camel@pasglop>
	<20100314.220646.190065794.davem@davemloft.net>
	<1268630313.2335.2.camel@pasglop>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from 74-93-104-97-Washington.hfc.comcastbusiness.net ([74.93.104.97]:36908
	"EHLO sunset.davemloft.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1759685Ab0COFyW (ORCPT
	<rfc822;linux-arch@vger.kernel.org>);
	Mon, 15 Mar 2010 01:54:22 -0400
In-Reply-To: <1268630313.2335.2.camel@pasglop>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: benh@kernel.crashing.org
Cc: linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org, kernel@teksavvy.com, drepper@redhat.com, torvalds@linux-foundation.org, munroesj@linux.vnet.ibm.com

From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Date: Mon, 15 Mar 2010 16:18:33 +1100

> Or is there any good reason -not- to do that in glibc ?

The whole point of syscall() is to handle cases where the C library
doesn't know about the system call yet.

I think it's therefore very much "buyer beware".

On sparc it'll never work to use the workaround you're proposing since
we pass everything in via registers.

So arch knowledge will always need to be present in these situations.
