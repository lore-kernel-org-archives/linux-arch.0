From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [PATCH 03/35] lmb: Add ARCH_DISCARD_LMB to put lmb code to
 .init
Date: Fri, 14 May 2010 18:10:23 +1000
Message-ID: <1273824623.21352.580.camel@pasglop>
References: <1273796396-29649-1-git-send-email-yinghai@kernel.org>
	 <1273796396-29649-4-git-send-email-yinghai@kernel.org>
	 <1273803249.21352.357.camel@pasglop>  <4BECEBF4.7000402@oracle.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <4BECEBF4.7000402@oracle.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Yinghai <yinghai.lu@oracle.com>
Cc: Ingo Molnar <mingo@elte.hu>, Thomas Gleixner <tglx@linutronix.de>, "H. Peter Anvin" <hpa@zytor.com>, Andrew Morton <akpm@linux-foundation.org>, David Miller <davem@davemloft.net>, Linus Torvalds <torvalds@linux-foundation.org>, Johannes Weiner <hannes@cmpxchg.org>, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org
List-Id: linux-arch.vger.kernel.org

On Thu, 2010-05-13 at 23:21 -0700, Yinghai wrote:
> > So you do not intend to use lmb after boot ? This will break the
> debugfs
> > files unless you also remove those.
> 
> no, x86 don't lmb after boot.
> 
> yes 

So you need some kind of CONFIG option to keep lmb after boot, at least
the data structures, for debugfs, or when not set, disable the debugfs
files.

Ben.
