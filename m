From: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: [PATCH 08/10] Use __kernel_ulong_t in struct msqid64_ds
Date: Fri, 18 May 2012 15:08:34 -0700
Message-ID: <4FB6C862.5060401@zytor.com>
References: <1337292816-10839-1-git-send-email-hjl.tools@gmail.com> <201205182131.29353.arnd@arndb.de> <4FB6C1F7.1010307@zytor.com> <201205182158.59616.arnd@arndb.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from terminus.zytor.com ([198.137.202.10]:48114 "EHLO mail.zytor.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S967321Ab2ERWIx (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Fri, 18 May 2012 18:08:53 -0400
In-Reply-To: <201205182158.59616.arnd@arndb.de>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Arnd Bergmann <arnd@arndb.de>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, David Daney <ddaney.cavm@gmail.com>, Ralf Baechle <ralf@linux-mips.org>, "H.J. Lu" <hjl.tools@gmail.com>, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, mingo@kernel.org, tglx@linutronix.de

On 05/18/2012 02:58 PM, Arnd Bergmann wrote:
> 
> But why do you think it's wrong the way it is? I see the idea of putting
> padding in varying places depending on the endianess as a failed experiment
> and defining a structure that is always the same as the logical conclusion
> from that, even if it's a bit silly to have any padding in it at all.
> 

The *whole point* is to make the structure the same across modes, to
make the compat layer's job easier.

> Being consistent seems more important here than following the intent
> of whoever came up with the concept of the ipc64 data structures
> and was consequently ignored by most people after him.

So you're saying because some architectures introduced a bug, we should
*CONTINUE* to introduce the same bug??  WTF??

> If we really wanted the data structures to be compatible between 32 and
> 64 bit mode, we'd have to use __u64 here but that would mean having to
> change all bits of user code that already rely on the existing x86
> compatible layout.

x86 is doing it right.  Some bigendian architectures blindly copied what
x86 was doing without thinking.  That's a bug on their part, period.

	-hpa
