Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from stat9.steeleye.com ([209.192.50.41]:34016 "EHLO
	hancock.sc.steeleye.com") by vger.kernel.org with ESMTP
	id S1751225AbWCSXuw (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Sun, 19 Mar 2006 18:50:52 -0500
Subject: Re: Potential problem with the page_mapping macro and
	flush_dcache_page()
From: James Bottomley <James.Bottomley@steeleye.com>
In-Reply-To: <20060319.132603.132950779.davem@davemloft.net>
References: <20060319.130009.102283514.davem@davemloft.net>
	 <1142802286.3240.54.camel@mulgrave.il.steeleye.com>
	 <1142803431.3240.58.camel@mulgrave.il.steeleye.com>
	 <20060319.132603.132950779.davem@davemloft.net>
Content-Type: text/plain
Date: Sun, 19 Mar 2006 17:50:19 -0600
Message-Id: <1142812219.3240.79.camel@mulgrave.il.steeleye.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-arch-owner@vger.kernel.org
To: "David S. Miller" <davem@davemloft.net>
Cc: linux-arch@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>

On Sun, 2006-03-19 at 13:26 -0800, David S. Miller wrote:
> flush_cache_page() is a nop on many architectures which have
> cache aliasing issues, such as sparc64.

Oh ... hmm .. I was just going by the comment in cachetlb.txt which says

	After running, there will be no entries in the cache for
	'vma->vm_mm' for virtual address 'addr' which translates
	to 'pfn'.

which seemed it should do what I want.

It looks like there's no other API I can use for this ... do you want me
to construct another?  something like flush_anon_page()?

James


