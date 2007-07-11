Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from smtp2.linux-foundation.org ([207.189.120.14]:35329 "EHLO
	smtp2.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S936298AbXGKXxW (ORCPT
	<rfc822;linux-arch@vger.kernel.org>);
	Wed, 11 Jul 2007 19:53:22 -0400
Date: Wed, 11 Jul 2007 16:53:08 -0700
From: Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH] Pass -g to assembler under CONFIG_DEBUG_INFO
Message-Id: <20070711165308.551f0c6c.akpm@linux-foundation.org>
In-Reply-To: <alpine.LFD.0.999.0707111640030.20061@woody.linux-foundation.org>
References: <46955BB1.20200@windriver.com>
	<20070711224327.9B0ED4D0555@magilla.localdomain>
	<20070711160335.8705f742.akpm@linux-foundation.org>
	<alpine.LFD.0.999.0707111640030.20061@woody.linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-arch-owner@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Roland McGrath <roland@redhat.com>, Jason Wessel <jason.wessel@windriver.com>, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>

On Wed, 11 Jul 2007 16:40:29 -0700 (PDT)
Linus Torvalds <torvalds@linux-foundation.org> wrote:

> 
> 
> On Wed, 11 Jul 2007, Andrew Morton wrote:
> >
> > OK, thanks.  So I ended up with the below as a probably-2.6.23 thing:
> > ...
> > +AFLAGS		+= $(call as-option, -gdwarf)
> 
> "-gdwarf2?"
> 

yep, that's what the kgdb tree was using - I'll fix it up.
