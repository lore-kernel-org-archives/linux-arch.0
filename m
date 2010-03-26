From: David Daney <ddaney@caviumnetworks.com>
Subject: Re: [PATCH] Protect prefetch macro arguments.
Date: Fri, 26 Mar 2010 14:18:05 -0700
Message-ID: <4BAD248D.7070603@caviumnetworks.com>
References: <1269636240-8895-1-git-send-email-ddaney@caviumnetworks.com> <alpine.LFD.2.00.1003261402170.3721@i5.linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from smtp2.caviumnetworks.com ([209.113.159.134]:16264 "EHLO
	smtp2.caviumnetworks.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753948Ab0CZVeu (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Fri, 26 Mar 2010 17:34:50 -0400
In-Reply-To: <alpine.LFD.2.00.1003261402170.3721@i5.linux-foundation.org>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: akpm@linux-foundation.org, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org

On 03/26/2010 02:04 PM, Linus Torvalds wrote:
>
>
> On Fri, 26 Mar 2010, David Daney wrote:
>>
>> The GCC built-in __builtin_prefetch() is a vargs function.  If we
>> don't wrap the macro parameter in parentheses, a comma operator in the
>> actual argument list might cause unintended parameters to be passed to
>> __builtin_prefetch().
>
> This seems totally pointless and actively wrong.

Pointless, perhaps.  But 'actively wrong'?  Are you sure about that?

In any event I guess I don't care much one way or the other.  I was 
working on something else when I saw this. It looked wrong to me.

Thanks,
David Daney


>
> You cannot have a comma operator in the actual argument list to the
> #define, because if you did, then you'd get a
>
> 	macro "prefetch()" passed 2 arguments, but takes just 1
>
> so the only way I see to pass a comma operator is to _already_ have the
> macro parameter in parenthesis.
>
> 		Linus
