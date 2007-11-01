Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from 74-93-104-97-Washington.hfc.comcastbusiness.net ([74.93.104.97]:41979
	"EHLO sunset.davemloft.net" rhost-flags-OK-FAIL-OK-OK)
	by vger.kernel.org with ESMTP id S1753729AbXKAH53 (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Thu, 1 Nov 2007 03:57:29 -0400
Date: Thu, 01 Nov 2007 00:57:27 -0700 (PDT)
Message-Id: <20071101.005727.218970168.davem@davemloft.net>
Subject: Re: [patch 0/7] [RFC] SLUB: Improve allocpercpu to reduce per cpu
 access overhead
From: David Miller <davem@davemloft.net>
In-Reply-To: <47297DA6.5070904@cosmosbay.com>
References: <20071101000211.970501947@sgi.com>
	<47297DA6.5070904@cosmosbay.com>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-arch-owner@vger.kernel.org
To: dada1@cosmosbay.com
Cc: clameter@sgi.com, akpm@linux-foundation.org, linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org, mathieu.desnoyers@polymtl.ca, penberg@cs.helsinki.fi
List-ID: <linux-arch.vger.kernel.org>

From: Eric Dumazet <dada1@cosmosbay.com>
Date: Thu, 01 Nov 2007 08:17:58 +0100

> Say we reserve on x86_64 a really huge (2^32 bytes) area, and change
> VM layout so that each cpu maps its own per_cpu area on this area,
> so that the local per_cpu data sits in the same virtual address on
> each cpu.

This is a mechanism used partially on IA64 already.

I think you have to be very careful, and you can only use this per-cpu
fixed virtual address area in extremely limited cases.

The reason is, I think the address matters, consider list heads, for
example.

So you couldn't do:

	list_add(&obj->list, &per_cpu_ptr(list_head));

and use that per-cpu fixed virtual address.

IA64 seems to use it universally for every __get_cpu_var()
access, so maybe it works out somehow :-)))

I guess if list modifications by remote cpus are disallowed, it would
work (list traversal works because using the fixed virtual address as
the list head sentinal is OK), but that is an extremely fragile
assumption to base the entire mechanism upon.
