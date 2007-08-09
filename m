Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.126.171]:51224 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1762128AbXHIN4J convert rfc822-to-8bit (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Thu, 9 Aug 2007 09:56:09 -0400
From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH 0/24] make atomic_read() behave consistently across all architectures
Date: Thu, 9 Aug 2007 14:41:25 +0200
References: <20070809131423.GA9927@shell.boston.redhat.com>
In-Reply-To: <20070809131423.GA9927@shell.boston.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
Message-Id: <200708091441.28511.arnd@arndb.de>
Sender: linux-arch-owner@vger.kernel.org
To: Chris Snook <csnook@redhat.com>
Cc: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, torvalds@linux-foundation.org, netdev@vger.kernel.org, akpm@linux-foundation.org, ak@suse.de, heiko.carstens@de.ibm.com, davem@davemloft.net, schwidefsky@de.ibm.com, wensong@linux-vs.org, horms@verge.net.au, wjiang@resilience.com, cfriesen@nortel.com, zlynx@acm.org, rpjday@mindspring.com, jesper.juhl@gmail.com
List-ID: <linux-arch.vger.kernel.org>

On Thursday 09 August 2007, Chris Snook wrote:
> This patchset makes the behavior of atomic_read uniform by removing the
> volatile keyword from all atomic_t and atomic64_t definitions that currently
> have it, and instead explicitly casts the variable as volatile in
> atomic_read().  This leaves little room for creative optimization by the
> compiler, and is in keeping with the principles behind "volatile considered
> harmful".
> 

Just an idea: since all architectures already include asm-generic/atomic.h,
why not move the definitions of atomic_t and atomic64_t, as well as anything
that does not involve architecture specific inline assembly into the generic
header?

	Arnd <><
