Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from stat9.steeleye.com ([209.192.50.41]:8837 "EHLO
	hancock.sc.steeleye.com") by vger.kernel.org with ESMTP
	id S932190AbWCWOOG (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Thu, 23 Mar 2006 09:14:06 -0500
Subject: Re: Potential problem with the page_mapping macro and
	flush_dcache_page()
From: James Bottomley <James.Bottomley@steeleye.com>
In-Reply-To: <20060322222027.4615e245.akpm@osdl.org>
References: <1142801589.3240.51.camel@mulgrave.il.steeleye.com>
	 <20060319.130009.102283514.davem@davemloft.net>
	 <1142802286.3240.54.camel@mulgrave.il.steeleye.com>
	 <20060319.132511.116548328.davem@davemloft.net>
	 <1142803783.3240.64.camel@mulgrave.il.steeleye.com>
	 <20060322222027.4615e245.akpm@osdl.org>
Content-Type: text/plain
Date: Thu, 23 Mar 2006 09:13:00 -0500
Message-Id: <1143123180.3415.5.camel@mulgrave.il.steeleye.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-arch-owner@vger.kernel.org
To: Andrew Morton <akpm@osdl.org>
Cc: davem@davemloft.net, linux-arch@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>

On Wed, 2006-03-22 at 22:20 -0800, Andrew Morton wrote:
> James Bottomley <James.Bottomley@SteelEye.com> wrote:
> umm, except in the case where direct-io hit a file hole.  In that case we
> memset the user's page and use flush_dcache_page().  And that's most likely
> an anonymous page.

Actually, in this one case, you need to use the
flush_kernel_dcache_page() API rather than the flush_anon_page(), since
it sounds like what you've modified is the kernel view of the page, not
the user's view.

James


