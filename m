Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from stat9.steeleye.com ([209.192.50.41]:24542 "EHLO
	hancock.sc.steeleye.com") by vger.kernel.org with ESMTP
	id S1750916AbWCSVFU (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Sun, 19 Mar 2006 16:05:20 -0500
Subject: Re: Potential problem with the page_mapping macro and
	flush_dcache_page()
From: James Bottomley <James.Bottomley@steeleye.com>
In-Reply-To: <20060319.130009.102283514.davem@davemloft.net>
References: <1142788559.3240.30.camel@mulgrave.il.steeleye.com>
	 <20060319.123320.71795946.davem@davemloft.net>
	 <1142801589.3240.51.camel@mulgrave.il.steeleye.com>
	 <20060319.130009.102283514.davem@davemloft.net>
Content-Type: text/plain
Date: Sun, 19 Mar 2006 15:04:46 -0600
Message-Id: <1142802286.3240.54.camel@mulgrave.il.steeleye.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-arch-owner@vger.kernel.org
To: "David S. Miller" <davem@davemloft.net>
Cc: linux-arch@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>

On Sun, 2006-03-19 at 13:00 -0800, David S. Miller wrote:
> You have physically indexed caches, thus cache coherency transactions
> should purge all cache lines with that same physical TAG.

No, we have virtually indexed but physically tagged caches; this is why
we have the problem (we have to select one of the aliases to flush).

> Direct I/O is another problematic case.

OK, I confess to not ever having looked at that ... does it use
get_user_pages() as well?

James


