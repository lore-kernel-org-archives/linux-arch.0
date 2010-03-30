From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [PATCH 07/31] lmb: Add reserve_lmb/free_lmb
Date: Tue, 30 Mar 2010 16:26:34 +1100
Message-ID: <1269926794.7101.46.camel@pasglop>
References: <1269830604-26214-1-git-send-email-yinghai@kernel.org>
	 <1269830604-26214-8-git-send-email-yinghai@kernel.org>
	 <1269865322.24620.42.camel@concordia>  <4BB0D92C.3010103@kernel.org>
	 <1269901252.2286.11.camel@concordia> <1269905491.7101.40.camel@pasglop>
	 <4BB13FDB.9060006@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from gate.crashing.org ([63.228.1.57]:43416 "EHLO gate.crashing.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755528Ab0C3G3J (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Tue, 30 Mar 2010 02:29:09 -0400
In-Reply-To: <4BB13FDB.9060006@kernel.org>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Yinghai Lu <yinghai@kernel.org>
Cc: michael@ellerman.id.au, Ingo Molnar <mingo@elte.hu>, Thomas Gleixner <tglx@linutronix.de>, "H. Peter Anvin" <hpa@zytor.com>, Andrew Morton <akpm@linux-foundation.org>, David Miller <davem@davemloft.net>, Linus Torvalds <torvalds@linux-foundation.org>, Johannes Weiner <hannes@cmpxchg.org>, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org

On Mon, 2010-03-29 at 17:03 -0700, Yinghai Lu wrote:
> 
> in short: It could make us to avoid use the range that we are going to
> reserve,
>       when we try to get new position new lmb.reserved.region. 

I'm not too sure I follow you. For the resizing, I would just basically
call a low level variant of alloc (__lmb_alloc ?) that explicitely
doesn't honor the total-2 "reserved" entries in the array.

Ie. It should all be one single find/allocation function.

In fact, you want to split lmb_find from lmb_reserve, then just make
lmb_alloc use the above, I don't want 2 implementations of the same
thing (maybe call it __lmb_find to expose the fact that it's a low level
function to avoid for normal use).

Cheers,
Ben.
