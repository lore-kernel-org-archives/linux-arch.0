Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from accolon.hansenpartnership.com ([76.243.235.52]:41042 "EHLO
	accolon.hansenpartnership.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S932106AbYD1Onk (ORCPT
	<rfc822;linux-arch@vger.kernel.org>);
	Mon, 28 Apr 2008 10:43:40 -0400
Subject: Re: [PATCH 1/11] Add generic helpers for arch IPI function calls
From: James Bottomley <James.Bottomley@HansenPartnership.com>
In-Reply-To: <18470.1209392727@redhat.com>
References: <1209219236.3113.6.camel@localhost.localdomain>
	 <1208890227-24808-1-git-send-email-jens.axboe@oracle.com>
	 <1208890227-24808-2-git-send-email-jens.axboe@oracle.com>
	 <20080425231100.b93a1601.akpm@linux-foundation.org>
	 <18470.1209392727@redhat.com>
Content-Type: text/plain
Date: Mon, 28 Apr 2008 10:43:32 -0400
Message-ID: <1209393812.3367.24.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: David Howells <dhowells@redhat.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, Jens Axboe <jens.axboe@oracle.com>, linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org, npiggin@suse.de, torvalds@linux-foundation.org, peterz@infradead.org, sam@ravnborg.org, "Paul E. McKenney" <paulmck@us.ibm.com>
Message-ID: <20080428144332.wDnFRGeUBZjTsaVzyY8bIB9n3CqKdPcrhLK8dfYFAx0@z>

On Mon, 2008-04-28 at 15:25 +0100, David Howells wrote:
> We could use a GOT, but I believe that would add an extra memory
> access to any
> memory access or jump - which I'd prefer to avoid.

Not necessarily; this is how we work on PARISC with a GOT as the ELF
spec defines.  The point is that the GOT is linker constructed, so we
only lay down GOT entries when the linker sees that relative
displacements fail, so they don't consume memory (or even get brought
into existence) in the ordinary case.  The flip side of this is that we
do double jump (relative to jump through got) for the long displacements
we can't reach.

James


