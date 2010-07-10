From: David Miller <davem@davemloft.net>
Subject: Re: LMB bits
Date: Fri, 09 Jul 2010 20:55:44 -0700 (PDT)
Message-ID: <20100709.205544.48508808.davem@davemloft.net>
References: <1278659480.28659.149.camel@pasglop>
	<20100709072408.GD10743@elte.hu>
	<20100709.172050.112604881.davem@davemloft.net>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from 74-93-104-97-Washington.hfc.comcastbusiness.net ([74.93.104.97]:34521
	"EHLO sunset.davemloft.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753492Ab0GJDza (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Fri, 9 Jul 2010 23:55:30 -0400
In-Reply-To: <20100709.172050.112604881.davem@davemloft.net>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: mingo@elte.hu
Cc: benh@kernel.crashing.org, yinghai@kernel.org, hpa@zytor.com, tglx@linutronix.de, torvalds@linux-foundation.org, linux-arch@vger.kernel.org

From: David Miller <davem@davemloft.net>
Date: Fri, 09 Jul 2010 17:20:50 -0700 (PDT)

> From: Ingo Molnar <mingo@elte.hu>
> Date: Fri, 9 Jul 2010 09:24:08 +0200
> 
>> Dave, can you confirm that it works fine on Sparc?
> 
> It hangs very eary in the boot, I'll try to bisect.

A quick update, I'm still chipping away to find the culprit,
I know so far that things are ok at least 14 patches into the
series.

I'll work more to try and track down the exact problem tomorrow.
