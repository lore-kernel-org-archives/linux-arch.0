Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from smtp110.mail.mud.yahoo.com ([209.191.85.220]:52399 "HELO
	smtp110.mail.mud.yahoo.com") by vger.kernel.org with SMTP
	id S1751127AbWCHCHr (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Tue, 7 Mar 2006 21:07:47 -0500
Message-ID: <440E3C69.2040902@yahoo.com.au>
Date: Wed, 08 Mar 2006 13:07:37 +1100
From: Nick Piggin <nickpiggin@yahoo.com.au>
MIME-Version: 1.0
Subject: Re: [PATCH] Document Linux's memory barriers
References: <31492.1141753245@warthog.cambridge.redhat.com>
In-Reply-To: <31492.1141753245@warthog.cambridge.redhat.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-arch-owner@vger.kernel.org
To: David Howells <dhowells@redhat.com>
Cc: torvalds@osdl.org, akpm@osdl.org, mingo@redhat.com, linux-arch@vger.kernel.org, linuxppc64-dev@ozlabs.org, linux-kernel@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>

David Howells wrote:

>The attached patch documents the Linux kernel's memory barriers.
>
>Signed-Off-By: David Howells <dhowells@redhat.com>
>---
>
>

Good :)

>+==============================
>+IMPLIED KERNEL MEMORY BARRIERS
>+==============================
>+
>+Some of the other functions in the linux kernel imply memory barriers. For
>+instance all the following (pseudo-)locking functions imply barriers.
>+
>+ (*) interrupt disablement and/or interrupts
>

Is this really the case? I mean interrupt disablement only synchronises with
the local CPU, so it probably should not _have_ to imply barriers (eg. some
architectures are playing around with "virtual" interrupt disablement).

[...]

>+
>+Either interrupt disablement (LOCK) and enablement (UNLOCK) will barrier
>+memory and I/O accesses individually, or interrupt handling will barrier
>+memory and I/O accesses on entry and on exit. This prevents an interrupt
>+routine interfering with accesses made in a disabled-interrupt section of code
>+and vice versa.
>+
>

But CPUs should always be consistent WRT themselves, so I'm not sure that
it is needed?

Thanks,
Nick

--
Send instant messages to your online friends http://au.messenger.yahoo.com 
