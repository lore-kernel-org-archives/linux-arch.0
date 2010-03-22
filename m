From: David Miller <davem@davemloft.net>
Subject: Re: [PATCH 06/20] early_res: seperate common memmap func from
 e820.c to fw_memmap.c
Date: Sun, 21 Mar 2010 21:33:50 -0700 (PDT)
Message-ID: <20100321.213350.176660494.davem@davemloft.net>
References: <4BA6EA62.1030603@kernel.org>
	<20100321.210023.209981130.davem@davemloft.net>
	<4BA6F1F6.3070102@kernel.org>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from 74-93-104-97-Washington.hfc.comcastbusiness.net ([74.93.104.97]:44387
	"EHLO sunset.davemloft.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751842Ab0CVEd2 (ORCPT
	<rfc822;linux-arch@vger.kernel.org>);
	Mon, 22 Mar 2010 00:33:28 -0400
In-Reply-To: <4BA6F1F6.3070102@kernel.org>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: yinghai@kernel.org
Cc: benh@kernel.crashing.org, mingo@elte.hu, tglx@linutronix.de, hpa@zytor.com, akpm@linux-foundation.org, jbarnes@virtuousgeek.org, ebiederm@xmission.com, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org

From: Yinghai Lu <yinghai@kernel.org>
Date: Sun, 21 Mar 2010 21:28:38 -0700

>> 
>> That action means you absolutely don't value our feedback at all.
> 
> [PATCH 01/20] x86: add find_e820_area_node
> is addressing your concern that early_res didn't handle memory cross the nodes problem.

Now I know that you _REALLY_ aren't listening to us.

We said to use LMB because 1) it already exists 2) many
platforms have been using it for years and 3) it doesn't
lack the features you're now having to add to e820.

Instead of trying to use LMB, you're just addding feature after
feature to e820 in order to bring it up to having parity with LMB.

You're wasting a lot of time, and you're completely ignoring an
existing facility that has been working on and used for many
years.

And you've never ever convinced any of us familiar with LMB why you
keep doing this, and why LMB can't be used for what you need this
generic e820 crap for.

I'm absolutely flabbergasted at this point, you really have no
value for the feedback you've been given.

None at all.
