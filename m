From: David Miller <davem@davemloft.net>
Subject: Re: Mostly portable strnlen_user()
Date: Sat, 26 May 2012 00:15:52 -0400 (EDT)
Message-ID: <20120526.001552.1171433126500742038.davem@davemloft.net>
References: <CA+55aFxYO-fb9K-_g8X85tK8-sGxUHy1R8X3Hes3fb-+0bhXLw@mail.gmail.com>
	<20120525.224318.1418525735588086513.davem@davemloft.net>
	<CA+55aFxDyPCEFbOFaPbXF556NbtakuC0RcoUKhCa5k2EsqJ8CQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from shards.monkeyblade.net ([198.137.202.13]:55246 "EHLO
	shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750923Ab2EZEP4 (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Sat, 26 May 2012 00:15:56 -0400
In-Reply-To: <CA+55aFxDyPCEFbOFaPbXF556NbtakuC0RcoUKhCa5k2EsqJ8CQ@mail.gmail.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: torvalds@linux-foundation.org
Cc: linux-arch@vger.kernel.org

From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Fri, 25 May 2012 20:56:37 -0700

> Does this look sane to you?

At first glance, it does.

I play with this and try to get it working on sparc tonight, thanks.
