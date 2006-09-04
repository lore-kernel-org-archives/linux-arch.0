Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from cantor.suse.de ([195.135.220.2]:37559 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S1751515AbWIDUaa (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Mon, 4 Sep 2006 16:30:30 -0400
From: Andi Kleen <ak@suse.de>
Subject: Re: [PATCH] Revert [i386/x86_64]: Remove __KERNEL__ ifdef around _syscall*()
Date: Mon, 4 Sep 2006 22:30:13 +0200
References: <200608302359.k7UNxIZW027536@hera.kernel.org> <1157398050.2473.137.camel@shinybook.infradead.org>
In-Reply-To: <1157398050.2473.137.camel@shinybook.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200609042230.13455.ak@suse.de>
Sender: linux-arch-owner@vger.kernel.org
To: David Woodhouse <dwmw2@infradead.org>
Cc: torvalds@osdl.org, akpm@osdl.org, linux-arch@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>


> 1. C libraries have their own syscall(); there's no _need_ for these
>    macros to be exported by the kernel.

I like having them there. I find it it useful for my test programs.
It's also useful for numactl for once.

> 3. We should be consistent about what we provide in kernel headers.
>    Since we don't provide these macros on other architectures, we should
>    not do so on i386 and x86_64 -- especially as the reason for doing so
>    seems to be just that the arch maintainer doesn't want to use the
>    proper glibc function in his test hacks.

We've always provided them and continuing to do so is consistent.

-Andi
