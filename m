From: Greg McGary <greg@mcgary.org>
Subject: Re: Proposal: (u)intptr_t replaces (unsigned) long as opaque type
Date: Sat, 18 Sep 2010 19:43:42 -0700
Message-ID: <4C9578DE.4090602@mcgary.org>
References: <4C95324B.2030707@mcgary.org> <20100918235436.GD25139@parisc-linux.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mpls-qmqp-02.inet.qwest.net ([63.231.195.113]:57522 "EHLO
	mpls-qmqp-02.inet.qwest.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753321Ab0ISCnv (ORCPT
	<rfc822;linux-arch@vger.kernel.org>);
	Sat, 18 Sep 2010 22:43:51 -0400
In-Reply-To: <20100918235436.GD25139@parisc-linux.org>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Matthew Wilcox <matthew@wil.cx>
Cc: linux-arch@vger.kernel.org

  On 09/18/10 16:54, Matthew Wilcox wrote:
> Linux really only supports ILP32 and LP64 models.  Pick one, and make
> your gcc mmtnp-unknown-linux triplet support it.
>
> ILP32 may be a better model for you, depending how much RAM your mmtnp
> processor is likely to support.
>
Yes, I know Linux currently supports only ILP32 and LP64.  What I propose is a way to make it support something new beyond those models, and do so in a way that has no impact on vmlinux images for existing ports.

What is mmtnp?

ILP32 will not work for me because pointers coerced to long will be truncated.  LP64 could work, but performance would suck, so that's not viable.

G
