From: KOSAKI Motohiro <kosaki.motohiro@jp.fujitsu.com>
Subject: Re: [patch 2/2] lockless get_user_pages
Date: Tue, 27 May 2008 09:57:11 +0900
Message-ID: <20080527095519.4676.KOSAKI.MOTOHIRO@jp.fujitsu.com>
References: <20080525145227.GC25747@wotan.suse.de> <8763t1w1ko.fsf@saeurebad.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from fgwmail5.fujitsu.co.jp ([192.51.44.35]:34545 "EHLO
	fgwmail5.fujitsu.co.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752864AbYE0BC2 (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Mon, 26 May 2008 21:02:28 -0400
In-Reply-To: <8763t1w1ko.fsf@saeurebad.de>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Johannes Weiner <hannes@saeurebad.de>
Cc: kosaki.motohiro@jp.fujitsu.com, Nick Piggin <npiggin@suse.de>, Andrew Morton <akpm@linux-foundation.org>, shaggy@austin.ibm.com, jens.axboe@oracle.com, torvalds@linux-foundation.org, linux-mm@kvack.org, linux-arch@vger.kernel.org, apw@shadowen.org

> > Introduce a new "fast_gup" (for want of a better name right now)
> 
> Perhaps,
> 
>   * get_address_space
>   * get_address_mappings
>   * get_mapped_pages
>   * get_page_mappings
> 
> Or s@get_@ref_@?

Why get_user_pages_lockless() is wrong?
or get_my_pages() is better?
(because this method assume task is current task)
