From: David Daney <ddaney.cavm@gmail.com>
Subject: Re: [PATCH 01/10] Use __kernel_long_t in struct timex
Date: Thu, 17 May 2012 16:51:17 -0700
Message-ID: <4FB58EF5.2090306@gmail.com>
References: <1337292816-10839-1-git-send-email-hjl.tools@gmail.com> <1337292816-10839-2-git-send-email-hjl.tools@gmail.com> <CA+55aFx98qvVg1JhMV0JjgNGb++xtir5ocseY3xgQNc3qAtWdQ@mail.gmail.com> <4FB57EB2.4050208@zytor.com> <CA+55aFzztct_HzmGiit=9SwwM4_YPuXbjwMdJpM1JHMXGBNqaA@mail.gmail.com> <CA+55aFxAY5FvJOjr9=W=g7WDj_gNwKrEeCFAiY2L2YmpaDx1cw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mail-pz0-f46.google.com ([209.85.210.46]:64490 "EHLO
	mail-pz0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753709Ab2EQXvT (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Thu, 17 May 2012 19:51:19 -0400
In-Reply-To: <CA+55aFxAY5FvJOjr9=W=g7WDj_gNwKrEeCFAiY2L2YmpaDx1cw@mail.gmail.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: "H. Peter Anvin" <hpa@zytor.com>, "H.J. Lu" <hjl.tools@gmail.com>, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, mingo@kernel.org, tglx@linutronix.de

On 05/17/2012 03:56 PM, Linus Torvalds wrote:
> On Thu, May 17, 2012 at 3:50 PM, Linus Torvalds
> <torvalds@linux-foundation.org>  wrote:
>>
>> I think __word would be good too, *except* for the fact that
>> especially in x86 land, I think there's the legacy confusion with
>> "word" being 16-bit. Ugh.
>
> Looking at the x32 case, I have to say that "long" in general looks
> horrible. Especially when we have things like
>
>    typedef long long __kernel_long_t;
>
> (and __long really wouldn't look any nicer). Any sane person would go
> "Eww" at looking at that - we're using 'long long' to typedef a type
> that is named 'long'.
>
> It would make much more sense to use "__word" for reasons like that.
> But I really don't think that works well in a x86 context.
>
> Other ideas? Maybe "__wordsize" would be less associated with x86 16-bit words?
>

FWIW: "__abi_wordsize" to indicate that it is not really a property of 
the machine itself, but rather the ABI in use.

David Daney
