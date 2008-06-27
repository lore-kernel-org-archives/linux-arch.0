From: David Miller <davem@davemloft.net>
Subject: Re: [PATCH 17/20] sparc64: use generic show_mem()
Date: Fri, 27 Jun 2008 15:46:23 -0700 (PDT)
Message-ID: <20080627.154623.29942091.davem@davemloft.net>
References: <20080627115349.743368154@saeurebad.de>
	<20080627120050.347718797@saeurebad.de>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from 74-93-104-97-Washington.hfc.comcastbusiness.net ([74.93.104.97]:55002
	"EHLO sunset.davemloft.net" rhost-flags-OK-FAIL-OK-OK)
	by vger.kernel.org with ESMTP id S1753182AbYF0WqX (ORCPT
	<rfc822;linux-arch@vger.kernel.org>);
	Fri, 27 Jun 2008 18:46:23 -0400
In-Reply-To: <20080627120050.347718797@saeurebad.de>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: hannes@saeurebad.de
Cc: akpm@linux-foundation.org, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org

From: Johannes Weiner <hannes@saeurebad.de>
Date: Fri, 27 Jun 2008 13:54:06 +0200

> Remove arch-specific show_mem() in favor of the generic version.
> 
> This also removes the following redundant information display:
> 
> 	- free swap pages, printed by show_swap_cache_info()
> 	- pages in swapcache, printed by show_swap_cache_info()
> 	- dirty pages, writeback pages, mapped pages, slab pages,
> 	  pagetables pages, printed by show_free_areas()
> 
> where show_mem() calls show_free_areas(), which calls
> show_swap_cache_info().
> 
> Signed-off-by: Johannes Weiner <hannes@saeurebad.de>
> CC: David S. Miller <davem@davemloft.net>

Thank you for doing this work:

Acked-by: David S. Miller <davem@davemloft.net>
