Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from 74-93-104-97-Washington.hfc.comcastbusiness.net ([74.93.104.97]:59057
	"EHLO sunset.davemloft.net" rhost-flags-OK-FAIL-OK-OK)
	by vger.kernel.org with ESMTP id S1755575AbXKLWqk convert rfc822-to-8bit
	(ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Mon, 12 Nov 2007 17:46:40 -0500
Date: Mon, 12 Nov 2007 14:46:39 -0800 (PST)
Message-Id: <20071112.144639.115283334.davem@davemloft.net>
Subject: Re: [patch 0/7] [RFC] SLUB: Improve allocpercpu to reduce per cpu
 access overhead
From: David Miller <davem@davemloft.net>
In-Reply-To: <4738B509.9000305@cosmosbay.com>
References: <4738AE04.1030506@cosmosbay.com>
	<Pine.LNX.4.64.0711121154270.27051@schroedinger.engr.sgi.com>
	<4738B509.9000305@cosmosbay.com>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=iso-8859-1
Content-Transfer-Encoding: 8BIT
Sender: linux-arch-owner@vger.kernel.org
To: dada1@cosmosbay.com
Cc: clameter@sgi.com, herbert@gondor.apana.org.au, akpm@linux-foundation.org, linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org, mathieu.desnoyers@polymtl.ca, penberg@cs.helsinki.fi
List-ID: <linux-arch.vger.kernel.org>

From: Eric Dumazet <dada1@cosmosbay.com>
Date: Mon, 12 Nov 2007 21:18:17 +0100

> Christoph Lameter a écrit :
> > On Mon, 12 Nov 2007, Eric Dumazet wrote:
> >> For example, I do think using a per cpu memory storage on net_device refcnt &
> >> last_rx could give us some speedups.
> > 
> > Note that there was a new patchset posted (titled cpu alloc v1) that 
> > provides on demand extension of the cpu areas.
> > 
> > See http://marc.info/?l=linux-kernel&m=119438261304093&w=2
> 
> Thank you Christoph. I was traveling last week so I missed that.
> 
> This new patchset looks very interesting, you did a fantastic job !

Yes I like it too.  It's in my backlog of things to test on
sparc64.
