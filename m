From: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: x86: faster strncpy_from_user()
Date: Tue, 10 Apr 2012 16:33:48 -0700
Message-ID: <4F84C35C.1020803@zytor.com>
References: <CA+55aFy8J5Ns4P514g7Ow4WhJXO+pjPBozYuCinYB+FQUKjZ6A@mail.gmail.com> <1334097321.3040.62.camel@pasglop> <CA+55aFwpX=SG6ECoi958+huLJ=egi3FDLxEeFpFtR8Hn8BJMDg@mail.gmail.com> <20120410.192935.289591767950787447.davem@davemloft.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from terminus.zytor.com ([198.137.202.10]:51878 "EHLO mail.zytor.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756243Ab2DJXd5 (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Tue, 10 Apr 2012 19:33:57 -0400
In-Reply-To: <20120410.192935.289591767950787447.davem@davemloft.net>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: David Miller <davem@davemloft.net>
Cc: torvalds@linux-foundation.org, benh@kernel.crashing.org, mingo@kernel.org, x86@kernel.org, linux-arch@vger.kernel.org

On 04/10/2012 04:29 PM, David Miller wrote:
> 
> Just wanted to mention that handling the detect zeroes operations on
> cpus that require alignment is easy, just rewind the pointer at the
> beginning to be aligned and "or" in a mask of 0xff for each alignment
> pad byte into the initially loaded word.
> 

Even on machines which don't require alignment it will still be faster
to do aligned memory references only, not counting the startup cost
(which is substantial in this case, of course, since the average length
is so short.)  However, it also neatly avoids the page overrun problem.

	-hpa
