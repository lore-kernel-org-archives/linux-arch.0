From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: Re: [PATCH 2/2] asm-generic: Don't warn that atomic_t is only 24
	bit
Date: Thu, 29 Apr 2010 17:10:35 -0400
Message-ID: <20100429211035.GA16179@Krystal>
References: <20100428162708.GB2846@Krystal> <1272451837-17961-1-git-send-email-peter.fritzsche@gmx.de> <1272453036-18670-1-git-send-email-peter.fritzsche@gmx.de> <201004281533.29327.arnd@arndb.de> <20100428135434.GA4662@Krystal> <20100428152815.GB25569@shareable.org> <22809.1272558128@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <22809.1272558128@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
To: David Howells <dhowells@redhat.com>, Peter Fritzsche <peter.fritzsche@gmx.de>
Cc: Jamie Lokier <jamie@shareable.org>, Arnd Bergmann <arnd@arndb.de>, Ingo Molnar <mingo@elte.hu>, Andrew Morton <akpm@linux-foundation.org>, Heiko Carstens <heiko.carstens@de.ibm.com>, linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org, Keith M Wesolowski <wesolows@foobazco.org>, Martin Schwidefsky <schwidefsky@de.ibm.com>
List-Id: linux-arch.vger.kernel.org

* David Howells (dhowells@redhat.com) wrote:
> Mathieu Desnoyers <mathieu.desnoyers@efficios.com> wrote:
> 
> > How about simply replacing arch/mn10300/include/asm/atomic.h by:
> > 
> > arch/mn10300/include/asm/atomic.h:
> > #include <asm-generic/atomic.h>
> > 
> > ?
> > 
> > This should have been done a while ago. They are almost the same, except for
> > added cmpxchg*_local() in the asm-generic version (which would benefit to
> > mn10300).
> 
> Fine by me.

Then I'll let Peter Fritzsche deal with that. I don't want to conflict with his
current patches.

Thanks,

Mathieu

> 
> David

-- 
Mathieu Desnoyers
Operating System Efficiency R&D Consultant
EfficiOS Inc.
http://www.efficios.com
