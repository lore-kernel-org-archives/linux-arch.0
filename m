Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from dsl027-180-168.sfo1.dsl.speakeasy.net ([216.27.180.168]:14539
	"EHLO sunset.davemloft.net") by vger.kernel.org with ESMTP
	id S1750920AbWCSV0F (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Sun, 19 Mar 2006 16:26:05 -0500
Date: Sun, 19 Mar 2006 13:26:03 -0800 (PST)
Message-Id: <20060319.132603.132950779.davem@davemloft.net>
Subject: Re: Potential problem with the page_mapping macro and
 flush_dcache_page()
From: "David S. Miller" <davem@davemloft.net>
In-Reply-To: <1142803431.3240.58.camel@mulgrave.il.steeleye.com>
References: <20060319.130009.102283514.davem@davemloft.net>
	<1142802286.3240.54.camel@mulgrave.il.steeleye.com>
	<1142803431.3240.58.camel@mulgrave.il.steeleye.com>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-arch-owner@vger.kernel.org
To: James.Bottomley@steeleye.com
Cc: linux-arch@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>

From: James Bottomley <James.Bottomley@SteelEye.com>
Date: Sun, 19 Mar 2006 15:23:51 -0600

> On Sun, 2006-03-19 at 15:04 -0600, James Bottomley wrote:
> > OK, I confess to not ever having looked at that ... does it use
> > get_user_pages() as well?
> 
> If the fix is to be in get_user_pages(), this is what works for parisc.

flush_cache_page() is a nop on many architectures which have
cache aliasing issues, such as sparc64.
