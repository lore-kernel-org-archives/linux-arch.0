From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH] Protect prefetch macro arguments.
Date: Fri, 26 Mar 2010 14:04:08 -0700 (PDT)
Message-ID: <alpine.LFD.2.00.1003261402170.3721@i5.linux-foundation.org>
References: <1269636240-8895-1-git-send-email-ddaney@caviumnetworks.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from smtp1.linux-foundation.org ([140.211.169.13]:51159 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751512Ab0CZVJH (ORCPT
	<rfc822;linux-arch@vger.kernel.org>);
	Fri, 26 Mar 2010 17:09:07 -0400
In-Reply-To: <1269636240-8895-1-git-send-email-ddaney@caviumnetworks.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: David Daney <ddaney@caviumnetworks.com>
Cc: akpm@linux-foundation.org, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org



On Fri, 26 Mar 2010, David Daney wrote:
>
> The GCC built-in __builtin_prefetch() is a vargs function.  If we
> don't wrap the macro parameter in parentheses, a comma operator in the
> actual argument list might cause unintended parameters to be passed to
> __builtin_prefetch().

This seems totally pointless and actively wrong.

You cannot have a comma operator in the actual argument list to the 
#define, because if you did, then you'd get a

	macro "prefetch()" passed 2 arguments, but takes just 1

so the only way I see to pass a comma operator is to _already_ have the 
macro parameter in parenthesis.

		Linus
