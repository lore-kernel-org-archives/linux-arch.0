Return-Path: <linux-arch-owner@vger.kernel.org>
Message-ID: <42C275FB.40209@yahoo.com.au>
Date: Wed, 29 Jun 2005 20:20:43 +1000
From: Nick Piggin <nickpiggin@yahoo.com.au>
MIME-Version: 1.0
Subject: Re: Remaining arch problems in cpu_idle
References: <42C24874.8030702@yahoo.com.au> <20050629080058.GA2694@linux-sh.org> <42C26552.5020304@yahoo.com.au> <20050629101145.GB2694@linux-sh.org>
In-Reply-To: <20050629101145.GB2694@linux-sh.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
To: Paul Mundt <lethal@linux-sh.org>
Cc: linux-arch@vger.kernel.org, Andrew Morton <akpm@osdl.org>
List-ID: <linux-arch.vger.kernel.org>

Paul Mundt wrote:
> On Wed, Jun 29, 2005 at 07:09:38PM +1000, Nick Piggin wrote:

>>Now this might introduce some power and heat penalty. What's more,
>>your race isn't a fatal one: in the worst case, it should just
>>stall until the next timer interrupt (aside, that might be fatal
>>with a tickless kernel).
>>
> 
> After incorporating your changes, how about this?
> 

So, just ignore the race, remove the irq disabling completely?
(with the hlt_counter fallback for busy waiting). If you're
happy with that then I think it looks good. Thanks Paul.

I'll also update the Documentation/ file to point out that such
a race isn't fatal.

-- 
SUSE Labs, Novell Inc.

Send instant messages to your online friends http://au.messenger.yahoo.com 
