From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH 1/1] mm: unify pmd_free() implementation
Date: Mon, 28 Jul 2008 08:53:46 -0700 (PDT)
Message-ID: <alpine.LFD.1.10.0807280851130.3486@nehalem.linux-foundation.org>
References: <> <1217260287-13115-1-git-send-email-righi.andrea@gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from smtp1.linux-foundation.org ([140.211.169.13]:49888 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751717AbYG1P5R (ORCPT
	<rfc822;linux-arch@vger.kernel.org>);
	Mon, 28 Jul 2008 11:57:17 -0400
In-Reply-To: <1217260287-13115-1-git-send-email-righi.andrea@gmail.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Andrea Righi <righi.andrea@gmail.com>
Cc: akpm@linux-foundation.org, linux-mm@kvack.org, linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org



On Mon, 28 Jul 2008, Andrea Righi wrote:
>
> Move multiple definitions of pmd_free() from different include/asm-* into
> mm/util.c.

But this is horrible, because it forces a totally unnecessary function 
call for that empty function.

Yeah, the function will be cheap, but the call itself will not be (it's a 
C language barrier and basically disables optimizations around it, causing 
thigns like register spill/reload for no good reason).

		Linus
