From: Kyle McMartin <kyle@mcmartin.ca>
Subject: Re: [PATCH] Drop superfluous casts in nr_free_pages() callers
Date: Mon, 3 Aug 2009 22:55:12 -0400
Message-ID: <20090804025512.GH28572@bombadil.infradead.org>
References: <alpine.LRH.2.00.0908031808440.11620@vixen.sonytel.be>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from bombadil.infradead.org ([18.85.46.34]:46017 "EHLO
	bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754848AbZHDCzO (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Mon, 3 Aug 2009 22:55:14 -0400
Content-Disposition: inline
In-Reply-To: <alpine.LRH.2.00.0908031808440.11620@vixen.sonytel.be>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Geert Uytterhoeven <Geert.Uytterhoeven@sonycom.com>
Cc: Christoph Lameter <cl@linux-foundation.org>, Andrew Morton <akpm@linux-foundation.org>, linux-arch@vger.kernel.org, Linux Kernel Development <linux-kernel@vger.kernel.org>

On Mon, Aug 03, 2009 at 06:11:42PM +0200, Geert Uytterhoeven wrote:
> Commit 96177299416dbccb73b54e6b344260154a445375 ("Drop free_pages()")
> modified nr_free_pages() to return 'unsigned long' instead of 'unsigned int'.
> This made the casts to 'unsigned long' in most callers superfluous, hence
> remove them.
> 
> Signed-off-by: Geert Uytterhoeven <Geert.Uytterhoeven@sonycom.com>

Acked-by: Kyle McMartin <kyle@mcmartin.ca>
