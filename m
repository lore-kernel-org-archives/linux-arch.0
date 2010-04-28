From: David Miller <davem@davemloft.net>
Subject: Re: [PATCH 2/2] asm-generic: Don't warn that atomic_t is only 24
 bit
Date: Wed, 28 Apr 2010 09:46:52 -0700 (PDT)
Message-ID: <20100428.094652.22534047.davem@davemloft.net>
References: <1272451837-17961-1-git-send-email-peter.fritzsche@gmx.de>
	<1272453036-18670-1-git-send-email-peter.fritzsche@gmx.de>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from 74-93-104-97-Washington.hfc.comcastbusiness.net ([74.93.104.97]:39887
	"EHLO sunset.davemloft.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752704Ab0D1Qqq (ORCPT
	<rfc822;linux-arch@vger.kernel.org>);
	Wed, 28 Apr 2010 12:46:46 -0400
In-Reply-To: <1272453036-18670-1-git-send-email-peter.fritzsche@gmx.de>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: peter.fritzsche@gmx.de
Cc: arnd@arndb.de, mingo@elte.hu, akpm@linux-foundation.org, heiko.carstens@de.ibm.com, mathieu.desnoyers@polymtl.ca, linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org, wesolows@foobazco.org

From: Peter Fritzsche <peter.fritzsche@gmx.de>
Date: Wed, 28 Apr 2010 13:10:36 +0200

> 32-bit Sparc used to only allow usage of 24-bit of it's atomic_t type.
> This was corrected with linux 2.6.3 when Keith M Wesolowski changed the
> implementation to use the parisc approach of having an array of
> spinlocks to protect the atomic_t.
> 
> These warnings were also removed from the sparc implementation when the
> new implementation was merged in BKrev:402e4949VThdc6D3iaosSFUgabMfvw,
> but the warning still remained in some other places without any
> 24-bit-only atomic_t implementation inside the kernel.
> 
> We should remove these warnings to allow users to rely on the full
> 32-bit range of atomic_t.
> 
> Signed-off-by: Peter Fritzsche <peter.fritzsche@gmx.de>

Acked-by: David S. Miller <davem@davemloft.net>
