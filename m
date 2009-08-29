From: David Miller <davem@davemloft.net>
Subject: Re: [patch 2/8] sparc: rename __spin_try_lock() and friends
Date: Sat, 29 Aug 2009 15:27:17 -0700 (PDT)
Message-ID: <20090829.152717.182541702.davem@davemloft.net>
References: <20090829102115.638224800@de.ibm.com>
	<20090829102155.053354161@de.ibm.com>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from 74-93-104-97-Washington.hfc.comcastbusiness.net ([74.93.104.97]:39117
	"EHLO sunset.davemloft.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752598AbZH2W1E (ORCPT
	<rfc822;linux-arch@vger.kernel.org>);
	Sat, 29 Aug 2009 18:27:04 -0400
In-Reply-To: <20090829102155.053354161@de.ibm.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: heiko.carstens@de.ibm.com
Cc: akpm@linux-foundation.org, mingo@elte.hu, torvalds@linux-foundation.org, benh@kernel.crashing.org, paulus@samba.org, geert@linux-m68k.org, zippel@linux-m68k.org, linux-arch@vger.kernel.org, a.p.zijlstra@chello.nl, arnd@arndb.de, nickpiggin@yahoo.com.au, schwidefsky@de.ibm.com, horsth@linux.vnet.ibm.com, ehrhardt@linux.vnet.ibm.com

From: Heiko Carstens <heiko.carstens@de.ibm.com>
Date: Sat, 29 Aug 2009 12:21:17 +0200

> From: Heiko Carstens <heiko.carstens@de.ibm.com>
> 
> Rename __spin_try_trylock() and friends to arch_spin_try_lock() etc.
> 
> Needed to avoid namespace conflicts when the common code function
> bodies of _spin_try_lock() etc. are moved to a header file where the
> function name would be __spin_try_lock().
> 
> Cc: David S. Miller <davem@davemloft.net>
> Signed-off-by: Heiko Carstens <heiko.carstens@de.ibm.com>

Acked-by: David S. Miller <davem@davemloft.net>
