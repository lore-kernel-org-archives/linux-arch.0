Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from palinux.external.hp.com ([192.25.206.14]:48675 "EHLO
	mail.parisc-linux.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756767AbXHUTnL (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Tue, 21 Aug 2007 15:43:11 -0400
Date: Tue, 21 Aug 2007 13:43:09 -0600
From: Matthew Wilcox <matthew@wil.cx>
Subject: Re: [RFC][PATCH] introduce TASK_SIZE_OF() for all arches
Message-ID: <20070821194309.GD9163@parisc-linux.org>
References: <20070821193835.258D7DD4@kernel>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20070821193835.258D7DD4@kernel>
Sender: linux-arch-owner@vger.kernel.org
To: Dave Hansen <haveblue@us.ibm.com>
Cc: linux-arch@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>

On Tue, Aug 21, 2007 at 12:38:35PM -0700, Dave Hansen wrote:
> I'd like to have that for other architectures.  So, add it
> for all the architectures that actually use "current" in 
> their TASK_SIZE.  For the others, just add a quick #define
> in sched.h to use plain old TASK_SIZE.

MIPS seems to do things a little differently ... Ralf, what should Dave
be doing here?

#define TASK_SIZE32     0x7fff8000UL
#define TASK_SIZE       0x10000000000UL

-- 
"Bill, look, we understand that you're interested in selling us this
operating system, but compare it to ours.  We can't possibly take such
a retrograde step."
