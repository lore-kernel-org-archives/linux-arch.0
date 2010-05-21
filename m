From: David Miller <davem@davemloft.net>
Subject: Re: [PATCH 2/2]: atomic_t: Remove volatile from atomic_t definition
Date: Thu, 20 May 2010 23:10:37 -0700 (PDT)
Message-ID: <20100520.231037.200798708.davem@davemloft.net>
References: <20100521052746.GL2516@laptop>
	<20100520.225454.37197037.davem@davemloft.net>
	<20100521060600.GM2516@laptop>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from 74-93-104-97-Washington.hfc.comcastbusiness.net ([74.93.104.97]:45761
	"EHLO sunset.davemloft.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S932854Ab0EUGK2 (ORCPT
	<rfc822;linux-arch@vger.kernel.org>);
	Fri, 21 May 2010 02:10:28 -0400
In-Reply-To: <20100521060600.GM2516@laptop>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: npiggin@suse.de
Cc: paulmck@linux.vnet.ibm.com, torvalds@linux-foundation.org, anton@samba.org, akpm@linux-foundation.org, willy@linux.intel.com, benh@kernel.crashing.org, paulus@samba.org, linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org

From: Nick Piggin <npiggin@suse.de>
Date: Fri, 21 May 2010 16:06:00 +1000

> Actually, I bet we have a lot of bugs there with loading integers and
> pointers atomically, where the code assumes the loaded value will not
> be reloaded by the compiler, because it is an easy thing to assume.

Alexey Kuznetsov was aware of this problem 8+ years ago when we were
first adding fine-grained locking the the networking.

> atomic_read_light could be useful though, for sure.

I definitely think so. And every usage of it should have a big fat
comment right next to it explaining how it's usage is valid in that
spot :-)
