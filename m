From: David Miller <davem@davemloft.net>
Subject: Re: [PATCH] Drop superfluous casts in nr_free_pages() callers
Date: Mon, 03 Aug 2009 12:02:30 -0700 (PDT)
Message-ID: <20090803.120230.197595669.davem@davemloft.net>
References: <alpine.LRH.2.00.0908031808440.11620@vixen.sonytel.be>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from 74-93-104-97-Washington.hfc.comcastbusiness.net ([74.93.104.97]:54319
	"EHLO sunset.davemloft.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753617AbZHCTCV (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Mon, 3 Aug 2009 15:02:21 -0400
In-Reply-To: <alpine.LRH.2.00.0908031808440.11620@vixen.sonytel.be>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Geert.Uytterhoeven@sonycom.com
Cc: cl@linux-foundation.org, akpm@linux-foundation.org, linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org

From: Geert Uytterhoeven <Geert.Uytterhoeven@sonycom.com>
Date: Mon, 3 Aug 2009 18:11:42 +0200 (CEST)

> Commit 96177299416dbccb73b54e6b344260154a445375 ("Drop free_pages()")
> modified nr_free_pages() to return 'unsigned long' instead of 'unsigned int'.
> This made the casts to 'unsigned long' in most callers superfluous, hence
> remove them.
> 
> Signed-off-by: Geert Uytterhoeven <Geert.Uytterhoeven@sonycom.com>

Acked-by: David S. Miller <davem@davemloft.net>
