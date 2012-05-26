From: David Miller <davem@davemloft.net>
Subject: Re: Mostly portable strnlen_user()
Date: Sat, 26 May 2012 00:34:36 -0400 (EDT)
Message-ID: <20120526.003436.1303427362830758480.davem@davemloft.net>
References: <CA+55aFxDyPCEFbOFaPbXF556NbtakuC0RcoUKhCa5k2EsqJ8CQ@mail.gmail.com>
	<20120526.001552.1171433126500742038.davem@davemloft.net>
	<CA+55aFxukJSo7srOcfedqCSz1wiZhjz4=F8Tj96=uOqWxYqq+A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from shards.monkeyblade.net ([198.137.202.13]:55364 "EHLO
	shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750816Ab2EZEei (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Sat, 26 May 2012 00:34:38 -0400
In-Reply-To: <CA+55aFxukJSo7srOcfedqCSz1wiZhjz4=F8Tj96=uOqWxYqq+A@mail.gmail.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: torvalds@linux-foundation.org
Cc: linux-arch@vger.kernel.org

From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Fri, 25 May 2012 21:19:01 -0700

> Make sure to take the second patch, the first was scrogged for the
> asm-generic case (and thus sparc). It would never have compiled.

Will do.
