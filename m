From: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: [PATCH] Prevent reserving RAM in the region already reserved
 by 	BIOS
Date: Wed, 19 May 2010 16:00:43 -0700
Message-ID: <4BF46D9B.4090806@zytor.com>
References: <AANLkTimwxXtNnmBuDJxg3i72VwWuHmemjrr1iGqj4j8e@mail.gmail.com>	 <4BF42296.1030905@oracle.com> <4BF4235D.3080904@zytor.com> <AANLkTikYcu6fM3yLoYIZOGZXgsRUfCgJeWS51Sjo-Fny@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from terminus.zytor.com ([198.137.202.10]:54406 "EHLO mail.zytor.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751891Ab0ESXBf (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Wed, 19 May 2010 19:01:35 -0400
In-Reply-To: <AANLkTikYcu6fM3yLoYIZOGZXgsRUfCgJeWS51Sjo-Fny@mail.gmail.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Mathieu Rondonneau <mathieu.rondonneau@gmail.com>
Cc: Yinghai <yinghai.lu@oracle.com>, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, Ingo Molnar <mingo@elte.hu>, Linus Torvalds <torvalds@linux-foundation.org>

On 05/19/2010 03:58 PM, Mathieu Rondonneau wrote:
> Thanks for the feedback.
> 
> No, I don' t see any changes in the /proc/iomem.
> 
> I am trying to prevent a ioremap of a 4K size on a non aligned 4K
> address that is below the ISA_START_ADDRESS.
> 
> The problem generates a oops about overlapping.
> I have a fix which instruct to not to do any re-map if the section
> name is "reserved".
> Which is not really clean.
> I am looking for a clean way to tell the ioremap function to not remap
> bios reserved memory.
> That' s why I thought the e820 would be a good start.
> 
> I will continue looking into this. It does not crash the systems. A
> warning generates the oops.
> 

Why are you mapping a fixed-address in ISA space to begin with?

Requests to a fixed address (as opposed to dynamic allocation) have to
be granted even in reserved space -- after all, that's what the address
might be reserved for!

	-hpa
