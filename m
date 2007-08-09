Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from zcars04f.nortel.com ([47.129.242.57]:46137 "EHLO
	zcars04f.nortel.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753453AbXHIUXv (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Thu, 9 Aug 2007 16:23:51 -0400
Message-ID: <46BB74B9.4070702@nortel.com>
Date: Thu, 09 Aug 2007 14:10:33 -0600
From: "Chris Friesen" <cfriesen@nortel.com>
MIME-Version: 1.0
Subject: Re: [PATCH 24/24] document volatile atomic_read() behavior
References: <20070809142430.GA19817@shell.boston.redhat.com> <8f6bb8a9e4f2819a161d732bdb6c70c0@kernel.crashing.org> <46BB403D.10202@redhat.com> <0a08872e608cf5f7a3d9c0fc746a1051@kernel.crashing.org>
In-Reply-To: <0a08872e608cf5f7a3d9c0fc746a1051@kernel.crashing.org>
Content-Type: text/plain; charset=US-ASCII; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-arch-owner@vger.kernel.org
To: Segher Boessenkool <segher@kernel.crashing.org>
Cc: Chris Snook <csnook@redhat.com>, wjiang@resilience.com, wensong@linux-vs.org, heiko.carstens@de.ibm.com, linux-kernel@vger.kernel.org, ak@suse.de, netdev@vger.kernel.org, horms@verge.net.au, akpm@linux-foundation.org, linux-arch@vger.kernel.org, torvalds@linux-foundation.org, schwidefsky@de.ibm.com, davem@davemloft.net, zlynx@acm.org, rpjday@mindspring.com, jesper.juhl@gmail.com
List-ID: <linux-arch.vger.kernel.org>

Segher Boessenkool wrote:

> Anyway, what's the supposed advantage of *(volatile *) vs. using
> a real volatile object?  That you can access that same object in
> a non-volatile way?

That's my understanding.  That way accesses where you don't care about 
volatility may be optimised.

For instance, in cases where there are already other things controlling 
visibility (as are needed for atomic increment, for example) you don't 
need to make the access itself volatile.

Chris
