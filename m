From: David Miller <davem@davemloft.net>
Subject: Re: Big git diff speedup by avoiding x86 "fast string" memcmp
Date: Wed, 15 Dec 2010 10:00:55 -0800 (PST)
Message-ID: <20101215.100055.226772943.davem@davemloft.net>
References: <12853.1292353313@jrobl>
	<AANLkTinjkcciZhJM5FmUkh_YCJ6bc9aTq8zV=SACDb1O@mail.gmail.com>
	<4D08BF5D.1060509@panasas.com>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from 74-93-104-97-Washington.hfc.comcastbusiness.net ([74.93.104.97]:35426
	"EHLO sunset.davemloft.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751226Ab0LOSA1 (ORCPT
	<rfc822;linux-arch@vger.kernel.org>);
	Wed, 15 Dec 2010 13:00:27 -0500
In-Reply-To: <4D08BF5D.1060509@panasas.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: bharrosh@panasas.com
Cc: npiggin@gmail.com, hooanon05@yahoo.co.jp, npiggin@kernel.dk, torvalds@linux-foundation.org, linux-arch@vger.kernel.org, x86@kernel.org, linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org

From: Boaz Harrosh <bharrosh@panasas.com>
Date: Wed, 15 Dec 2010 15:15:09 +0200

> I agree that the byte-compare or long-compare should give you very close
> results in modern pipeline CPUs. But surly 12 increments-and-test should
> show up against 3 (or even 2). I would say it must be a better plan.

For strings of these lengths the setup code necessary to initialize
the inner loop and the tail code to handle the sub-word ending cases
eliminate whatever gains there are.

I know this as I've been hacking on assembler optimized strcmp() and
memcmp() in my spare time over the past year or so.
