Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from gw1.cosmosbay.com ([86.65.150.130]:38857 "EHLO
	gw1.cosmosbay.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754126AbXKAHZK (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Thu, 1 Nov 2007 03:25:10 -0400
Message-ID: <47297F42.4050603@cosmosbay.com>
Date: Thu, 01 Nov 2007 08:24:50 +0100
From: Eric Dumazet <dada1@cosmosbay.com>
MIME-Version: 1.0
Subject: Re: [patch 1/7] allocpercpu: Make it a true per cpu allocator by
 allocating from a per cpu array
References: <20071101000211.970501947@sgi.com> <20071101000309.765254518@sgi.com>
In-Reply-To: <20071101000309.765254518@sgi.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-arch-owner@vger.kernel.org
To: Christoph Lameter <clameter@sgi.com>
Cc: akpm@linux-foundation.org, linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org, Mathieu Desnoyers <mathieu.desnoyers@polymtl.ca>, Pekka Enberg <penberg@cs.helsinki.fi>
List-ID: <linux-arch.vger.kernel.org>

Christoph Lameter a écrit :
> +
> +enum unit_type { FREE, END, USED };
> +
> +static u8 cpu_alloc_map[UNITS_PER_CPU] = { 1, };

You mean END here instead of 1 :)


> +/*
> + * Allocate an object of a certain size
> + *
> + * Returns a per cpu pointer that must not be directly used.
> + */
> +static void *cpu_alloc(unsigned long size)
> +{

We might need to give an alignment constraint here. Some per_cpu users would 
like to get a 64 bytes zone, siting in one cache line and not two :)


