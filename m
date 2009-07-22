From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [PATCH] mm: Pass virtual address to [__]p{te,ud,md}_free_tlb()
Date: Wed, 22 Jul 2009 20:12:15 +1000
Message-ID: <1248257535.27348.49.camel@pasglop>
References: <1248241468.27348.47.camel@pasglop>
	 <23069.1248250174@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1754831AbZGVKNK@vger.kernel.org>
In-Reply-To: <23069.1248250174@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
To: David Howells <dhowells@redhat.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Linux Arch list <linux-arch@vger.kernel.org>, Linux Kernel list <linux-kernel@vger.kernel.org>
List-Id: linux-arch.vger.kernel.org

On Wed, 2009-07-22 at 09:09 +0100, David Howells wrote:
> > Martin Schwidefsky compile tested on s390 and Michael Ellerman did
> some
> > test builds on ia64, arm, sparc32, sparc64, i386 and x86_64
> > 
> > Nobody else reacted.
> 
> I did tests for MN10300 and FRV.
> 
Ah yes, I did put you in the acked-by's and didn't think about
mentioning you again in the little blurb at the end !

Thanks for testing btw.

Cheers,
Ben.
