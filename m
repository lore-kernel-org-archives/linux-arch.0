From: Yinghai Lu <yinghai@kernel.org>
Subject: Re: [PATCH 03/24] x86: Do not free zero sized per cpu areas
Date: Fri, 26 Mar 2010 16:56:27 -0700
Message-ID: <4BAD49AB.8070601@kernel.org>
References: <1269642114-16588-1-git-send-email-yinghai@kernel.org> <1269642114-16588-4-git-send-email-yinghai@kernel.org> <20100326234203.GD29222@cmpxchg.org> <4BAD47F6.3000003@kernel.org> <20100326235451.GE29222@cmpxchg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from hera.kernel.org ([140.211.167.34]:33941 "EHLO hera.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751970Ab0CZX6H (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Fri, 26 Mar 2010 19:58:07 -0400
In-Reply-To: <20100326235451.GE29222@cmpxchg.org>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Johannes Weiner <hannes@cmpxchg.org>
Cc: Ingo Molnar <mingo@elte.hu>, Thomas Gleixner <tglx@linutronix.de>, "H. Peter Anvin" <hpa@zytor.com>, Andrew Morton <akpm@linux-foundation.org>, David Miller <davem@davemloft.net>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Linus Torvalds <torvalds@linux-foundation.org>, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, Ian Campbell <ian.campbell@citrix.com>, Peter Zijlstra <peterz@infradead.org>

On 03/26/2010 04:54 PM, Johannes Weiner wrote:
> On Fri, Mar 26, 2010 at 04:49:10PM -0700, Yinghai Lu wrote:
>>
>> is there any chance that dump stack only print out address instead of function name ?
> 
> I suppose so, lacking frame pointers, but you still have
> filename + linenumber + 'wrong range'.

ok, will remove that function name.
