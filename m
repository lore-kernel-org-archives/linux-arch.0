From: David Miller <davem@davemloft.net>
Subject: Re: x86: faster strncpy_from_user()
Date: Tue, 10 Apr 2012 21:09:36 -0400 (EDT)
Message-ID: <20120410.210936.739937429956200591.davem@davemloft.net>
References: <20120410.204322.1625218582933057448.davem@davemloft.net>
	<CA+55aFwVbGzk1Nwj1uk=R_XPPEkF2wZ_K8zhbmPZjy39r4rYDQ@mail.gmail.com>
	<CA+55aFw9-cVKP4MUpO6pCLbpHavrB1qbJ1NeiXEBbNupZ0iYKA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from shards.monkeyblade.net ([198.137.202.13]:49576 "EHLO
	shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755954Ab2DKBJl (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Tue, 10 Apr 2012 21:09:41 -0400
In-Reply-To: <CA+55aFw9-cVKP4MUpO6pCLbpHavrB1qbJ1NeiXEBbNupZ0iYKA@mail.gmail.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: torvalds@linux-foundation.org
Cc: benh@kernel.crashing.org, mingo@kernel.org, hpa@zytor.com, x86@kernel.org, linux-arch@vger.kernel.org

From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Tue, 10 Apr 2012 17:57:07 -0700

> On Tue, Apr 10, 2012 at 5:50 PM, Linus Torvalds
> <torvalds@linux-foundation.org> wrote:
>>
>> .. and you don't have a double shift, right? So you'd need to do two
>> shifts and the or for each word.
> 
> Actually, if sparc has a "rotate" instruction, you can do with a
> single shift (rotate) per word loop.

Sorry, no rotate :-)
