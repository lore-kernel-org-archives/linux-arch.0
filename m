From: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: [PATCH 01/10] Use __kernel_long_t in struct timex
Date: Thu, 17 May 2012 15:57:39 -0700
Message-ID: <4FB58263.30700@zytor.com>
References: <1337292816-10839-1-git-send-email-hjl.tools@gmail.com> <1337292816-10839-2-git-send-email-hjl.tools@gmail.com> <CA+55aFx98qvVg1JhMV0JjgNGb++xtir5ocseY3xgQNc3qAtWdQ@mail.gmail.com> <4FB57EB2.4050208@zytor.com> <CA+55aFzztct_HzmGiit=9SwwM4_YPuXbjwMdJpM1JHMXGBNqaA@mail.gmail.com> <CA+55aFxAY5FvJOjr9=W=g7WDj_gNwKrEeCFAiY2L2YmpaDx1cw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from terminus.zytor.com ([198.137.202.10]:38281 "EHLO mail.zytor.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1760557Ab2EQW5v (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Thu, 17 May 2012 18:57:51 -0400
In-Reply-To: <CA+55aFxAY5FvJOjr9=W=g7WDj_gNwKrEeCFAiY2L2YmpaDx1cw@mail.gmail.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: "H.J. Lu" <hjl.tools@gmail.com>, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, mingo@kernel.org, tglx@linutronix.de

On 05/17/2012 03:56 PM, Linus Torvalds wrote:
> 
> It would make much more sense to use "__word" for reasons like that.
> But I really don't think that works well in a x86 context.
> 
> Other ideas? Maybe "__wordsize" would be less associated with x86 16-bit words?
> 

__[su]native maybe?

	-hpa

-- 
H. Peter Anvin, Intel Open Source Technology Center
I work for Intel.  I don't speak on their behalf.
