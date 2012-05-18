From: "H. Peter Anvin" <hpa@kernel.org>
Subject: Re: [PATCH 08/10] Use __kernel_ulong_t in struct msqid64_ds
Date: Fri, 18 May 2012 14:06:27 -0700
Message-ID: <4FB6B9D3.6020307@kernel.org>
References: <1337292816-10839-1-git-send-email-hjl.tools@gmail.com> <1337292816-10839-9-git-send-email-hjl.tools@gmail.com> <4FB58EFD.7010302@zytor.com> <4FB5C050.9070805@kernel.org> <CAMe9rOrKq8Ait8wKudRF535J5c=dDTKekmUN_=HOs5BBLtsoGQ@mail.gmail.com> <CA+55aFxtejaM8ecOw8VYk74OaXfGY7=LO3JSyz3rdHEv2r9goQ@mail.gmail.com> <CAMe9rOqKz5MjENWDixpHgcNw9BiJDZWmXzN3NmmbLkbxQEKGqA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from terminus.zytor.com ([198.137.202.10]:47714 "EHLO mail.zytor.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S967460Ab2ERVGr (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Fri, 18 May 2012 17:06:47 -0400
In-Reply-To: <CAMe9rOqKz5MjENWDixpHgcNw9BiJDZWmXzN3NmmbLkbxQEKGqA@mail.gmail.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: "H.J. Lu" <hjl.tools@gmail.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, mingo@kernel.org, tglx@linutronix.de, Paul Mundt <lethal@linux-sh.org>

On 05/17/2012 08:56 PM, H.J. Lu wrote:
> 
> We need kernel headers for constants used in system calls.  But I don't
> mind if kernel stops exporting data structures to user space.
> 

I do.  It is idiotic that data structure definitions should have be
replicated by cut and paste; all it is is a completely unnecessary
source of both delay and of error.

	-hpa
