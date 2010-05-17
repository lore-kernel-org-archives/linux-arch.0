From: Jamie Lokier <jamie@shareable.org>
Subject: Re: [PATCH 2/2]: atomic_t: Remove volatile from atomic_t definition
Date: Mon, 17 May 2010 21:13:39 +0100
Message-ID: <20100517201339.GJ20356@shareable.org>
References: <20100517043353.GA22127@kryten> <20100517043457.GA22416@kryten> <alpine.LFD.2.00.1005170800100.4195@i5.linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mail2.shareable.org ([80.68.89.115]:35599 "EHLO
	mail2.shareable.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753883Ab0EQUN6 (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Mon, 17 May 2010 16:13:58 -0400
Content-Disposition: inline
In-Reply-To: <alpine.LFD.2.00.1005170800100.4195@i5.linux-foundation.org>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Anton Blanchard <anton@samba.org>, akpm@linux-foundation.org, willy@linux.intel.com, benh@kernel.crashing.org, paulus@samba.org, linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org

Linus Torvalds wrote:
> 
> 
> On Mon, 17 May 2010, Anton Blanchard wrote:
> > 
> > It turns out this bad code is a result of us defining atomic_t as a
> > volatile int.
> 
> Heh. Ok, as you point out in the commit message, I obviously agree with 
> this patch. "volatile" on data is evil, with the possible exception of 
> "jiffies" type things.

I wonder if

   extern unsigned long __nv_jiffies;
   #define jiffies (*(volatile unsigned long *)*__nv_jiffies)

would improve any code in the same way as this atomic_t change.

-- Jamie
