Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from smtp1.linux-foundation.org ([140.211.169.13]:60705 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S933384AbYDYTDi (ORCPT
	<rfc822;linux-arch@vger.kernel.org>);
	Fri, 25 Apr 2008 15:03:38 -0400
Date: Fri, 25 Apr 2008 12:03:12 -0700 (PDT)
From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH 01/24] types: create <asm-generic/int-*.h>
In-Reply-To: <20080425185251.GL14990@parisc-linux.org>
Message-ID: <alpine.LFD.1.10.0804251158410.2779@woody.linux-foundation.org>
References: <1209078352-7593-1-git-send-email-hpa@zytor.com> <1209078352-7593-2-git-send-email-hpa@zytor.com> <1209078352-7593-3-git-send-email-hpa@zytor.com> <alpine.LNX.1.10.0804252026040.20150@fbirervta.pbzchgretzou.qr> <alpine.LFD.1.10.0804251133100.2779@woody.linux-foundation.org>
 <20080425185251.GL14990@parisc-linux.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Matthew Wilcox <matthew@wil.cx>
Cc: Jan Engelhardt <jengelh@computergmbh.de>, "H. Peter Anvin" <hpa@zytor.com>, Andrew Morton <akpm@linux-foundation.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Linux Arch Mailing List <linux-arch@vger.kernel.org>
Message-ID: <20080425190312.6e2SGXz5iUxW2csBucYTrFAj6T4Vd_YRePB6aEt2Ibs@z>



On Fri, 25 Apr 2008, Matthew Wilcox wrote:
> 
> So ... given all this, why do we define s64 to be 'long' on some
> architectures and 'long long' on others?

Historical reasons, mainly. Once we start using one type for things like 
loff_t, it ends up getting encoded in user header files, and we're then 
basically forced to continue to use that particular type. Some of them end 
literally being embedded in the compiler itself (ie __builtin_size_t etc 
end up being known by compiler built-ins).

But yes, we could probably try to standardize the internal kernel s64/u64 
types that don't end up spreading anywhere else. 

Of course, part of the worry is probably that people thought that maybe 
"long long" would some day be 128-bit on a 64-bit architecture.

			Linus
