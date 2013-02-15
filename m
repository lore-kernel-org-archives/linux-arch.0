From: David Miller <davem@davemloft.net>
Subject: Re: [patch 1/2] mm: fincore()
Date: Fri, 15 Feb 2013 15:39:13 -0500 (EST)
Message-ID: <20130215.153913.1285091915738918107.davem@davemloft.net>
References: <20130211162701.GB13218@cmpxchg.org>
	<20130211141239.f4decf03.akpm@linux-foundation.org>
	<20130215063450.GA24047@cmpxchg.org>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from shards.monkeyblade.net ([149.20.54.216]:44453 "EHLO
	shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750832Ab3BOUjU (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Fri, 15 Feb 2013 15:39:20 -0500
In-Reply-To: <20130215063450.GA24047@cmpxchg.org>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: hannes@cmpxchg.org
Cc: akpm@linux-foundation.org, rusty@rustcorp.com.au, linux-kernel@vger.kernel.org, npiggin@suse.de, stewart@flamingspork.com, linux-mm@kvack.org, linux-arch@vger.kernel.org

From: Johannes Weiner <hannes@cmpxchg.org>
Date: Fri, 15 Feb 2013 01:34:50 -0500

> +	nr_pages = DIV_ROUND_UP(len, PAGE_CACHE_SIZE);

A small nit, maybe use PAGE_CACHE_ALIGN() here.
