From: Johannes Weiner <hannes@saeurebad.de>
Subject: Re: [patch 2/2] lockless get_user_pages
Date: Mon, 26 May 2008 17:02:31 +0200
Message-ID: <8763t1w1ko.fsf@saeurebad.de>
References: <20080525144847.GB25747@wotan.suse.de>
	<20080525145227.GC25747@wotan.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from saeurebad.de ([85.214.36.134]:49588 "EHLO saeurebad.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755073AbYEZPDH (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Mon, 26 May 2008 11:03:07 -0400
In-Reply-To: <20080525145227.GC25747@wotan.suse.de> (Nick Piggin's message of
	"Sun, 25 May 2008 16:52:27 +0200")
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Nick Piggin <npiggin@suse.de>
Cc: Andrew Morton <akpm@linux-foundation.org>, shaggy@austin.ibm.com, jens.axboe@oracle.com, torvalds@linux-foundation.org, linux-mm@kvack.org, linux-arch@vger.kernel.org, apw@shadowen.org

Hi Nick,

Nick Piggin <npiggin@suse.de> writes:

> Introduce a new "fast_gup" (for want of a better name right now)

Perhaps,

  * get_address_space
  * get_address_mappings
  * get_mapped_pages
  * get_page_mappings

Or s@get_@ref_@?

	Hannes
