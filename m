Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from dsl027-180-168.sfo1.dsl.speakeasy.net ([216.27.180.168]:11723
	"EHLO sunset.davemloft.net") by vger.kernel.org with ESMTP
	id S1751053AbWCSVZO (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Sun, 19 Mar 2006 16:25:14 -0500
Date: Sun, 19 Mar 2006 13:25:11 -0800 (PST)
Message-Id: <20060319.132511.116548328.davem@davemloft.net>
Subject: Re: Potential problem with the page_mapping macro and
 flush_dcache_page()
From: "David S. Miller" <davem@davemloft.net>
In-Reply-To: <1142802286.3240.54.camel@mulgrave.il.steeleye.com>
References: <1142801589.3240.51.camel@mulgrave.il.steeleye.com>
	<20060319.130009.102283514.davem@davemloft.net>
	<1142802286.3240.54.camel@mulgrave.il.steeleye.com>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-arch-owner@vger.kernel.org
To: James.Bottomley@steeleye.com
Cc: linux-arch@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>

From: James Bottomley <James.Bottomley@SteelEye.com>
Date: Sun, 19 Mar 2006 15:04:46 -0600

> On Sun, 2006-03-19 at 13:00 -0800, David S. Miller wrote:
> > You have physically indexed caches, thus cache coherency transactions
> > should purge all cache lines with that same physical TAG.
> 
> No, we have virtually indexed but physically tagged caches; this is why
> we have the problem (we have to select one of the aliases to flush).

This is exactly what Sparc64's caches are too, L1 D-cache is virtually
indexed and physically tagged.  But any bus coherency transaction will
update all lines with matching physical tags, otherwise things just
won't work.

> > Direct I/O is another problematic case.
> 
> OK, I confess to not ever having looked at that ... does it use
> get_user_pages() as well?

I believe so, Andrew knows...
