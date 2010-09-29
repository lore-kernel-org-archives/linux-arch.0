From: FUJITA Tomonori <fujita.tomonori@lab.ntt.co.jp>
Subject: Re: dma-mapping commit breaks UML
Date: Wed, 29 Sep 2010 22:20:38 +0900
Message-ID: <20100929221620K.fujita.tomonori@lab.ntt.co.jp>
References: <201009291155.30873.toralf.foerster@gmx.de>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from sh.osrg.net ([192.16.179.4]:42807 "EHLO sh.osrg.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755712Ab0I2NUv (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Wed, 29 Sep 2010 09:20:51 -0400
In-Reply-To: <201009291155.30873.toralf.foerster@gmx.de>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: toralf.foerster@gmx.de
Cc: fujita.tomonori@lab.ntt.co.jp, linux-arch@vger.kernel.org

On Wed, 29 Sep 2010 11:55:30 +0200
Toralf **UNKNOWN CHARSET** <toralf.foerster@gmx.de> wrote:

> The 
> 
> 4565f0170dfc849b3629c27d769db800467baa62 is the first bad commit
> commit 4565f0170dfc849b3629c27d769db800467baa62
> Author: FUJITA Tomonori <fujita.tomonori@lab.ntt.co.jp>
> Date:   Tue Aug 10 18:03:22 2010 -0700
> 
>     dma-mapping: unify dma_get_cache_alignment implementations

I think that the commit f3c072ad727617f00bffae17dba8cd895f5b7bdb
already fixed this breakage. You still have the issue with the latest
git?
