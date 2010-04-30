From: Peter Fritzsche <peter.fritzsche@gmx.de>
Subject: Re: [PATCH 2/2] asm-generic: Don't warn that atomic_t is only 24 bit
Date: Fri, 30 Apr 2010 10:53:08 +0200
Message-ID: <201004301053.09003.peter.fritzsche@gmx.de>
References: <20100428162708.GB2846@Krystal> <22809.1272558128@redhat.com> <20100429211035.GA16179@Krystal>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mail.gmx.net ([213.165.64.20]:42440 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S933501Ab0D3R7N (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Fri, 30 Apr 2010 13:59:13 -0400
In-Reply-To: <20100429211035.GA16179@Krystal>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: David Howells <dhowells@redhat.com>, Jamie Lokier <jamie@shareable.org>, Arnd Bergmann <arnd@arndb.de>, Ingo Molnar <mingo@elte.hu>, Andrew Morton <akpm@linux-foundation.org>, Heiko Carstens <heiko.carstens@de.ibm.com>, linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org, Keith M Wesolowski <wesolows@foobazco.org>, Martin Schwidefsky <schwidefsky@de.ibm.com>

Mathieu Desnoyers wrote:
> * David Howells (dhowells@redhat.com) wrote:
> > Mathieu Desnoyers <mathieu.desnoyers@efficios.com> wrote:
> > > How about simply replacing arch/mn10300/include/asm/atomic.h by:
> > > 
> > > arch/mn10300/include/asm/atomic.h:
> > > #include <asm-generic/atomic.h>
> > > 
> > > ?
> > > 
> > > This should have been done a while ago. They are almost the same,
> > > except for added cmpxchg*_local() in the asm-generic version (which
> > > would benefit to mn10300).
> > 
> > Fine by me.
> 
> Then I'll let Peter Fritzsche deal with that. I don't want to conflict with
> his current patches.

No, please go for your solution. It is the right thing to do and definitely 
better then my "remove some comments" patch. David Howells as MN10300 
maintainer already agreed to your suggestion. So I would like to recall my 
patch https://patchwork.kernel.org/patch/95651/ and let you submit a patch 
with your idea to the MN10300 maintainers which supersede my patch.

The state of https://patchwork.kernel.org/patch/95652/ hasn't been changed and 
I would love to see it merged by Arnd Bergmann in the next merge window.

Kind regards,
	Peter Fritzsche
