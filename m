From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH 2/2]: atomic_t: Remove volatile from atomic_t
 definition
Date: Mon, 17 May 2010 08:01:54 -0700 (PDT)
Message-ID: <alpine.LFD.2.00.1005170800100.4195@i5.linux-foundation.org>
References: <20100517043353.GA22127@kryten> <20100517043457.GA22416@kryten>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from smtp1.linux-foundation.org ([140.211.169.13]:41245 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751878Ab0EQPEv (ORCPT
	<rfc822;linux-arch@vger.kernel.org>);
	Mon, 17 May 2010 11:04:51 -0400
In-Reply-To: <20100517043457.GA22416@kryten>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Anton Blanchard <anton@samba.org>
Cc: akpm@linux-foundation.org, willy@linux.intel.com, benh@kernel.crashing.org, paulus@samba.org, linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org



On Mon, 17 May 2010, Anton Blanchard wrote:
> 
> It turns out this bad code is a result of us defining atomic_t as a
> volatile int.

Heh. Ok, as you point out in the commit message, I obviously agree with 
this patch. "volatile" on data is evil, with the possible exception of 
"jiffies" type things.

So applied.

		Linus
