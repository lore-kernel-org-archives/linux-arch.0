Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org ([63.228.1.57]:39901 "EHLO gate.crashing.org")
	by vger.kernel.org with ESMTP id S263252AbUCPA6z (ORCPT
	<rfc822;linux-arch@vger.kernel.org>);
	Mon, 15 Mar 2004 19:58:55 -0500
Received: from localhost (localhost.localdomain [127.0.0.1])
	by gate.crashing.org (8.12.8/8.12.8) with ESMTP id i2G0oAUn014306
	for <linux-arch@vger.kernel.org>; Mon, 15 Mar 2004 18:50:11 -0600
Subject: More DMA API junk
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Content-Type: text/plain
Message-Id: <1079398383.1968.205.camel@gaston>
Mime-Version: 1.0
Date: Tue, 16 Mar 2004 11:53:03 +1100
Content-Transfer-Encoding: 7bit
To: Linux Arch list <linux-arch@vger.kernel.org>
List-ID: <linux-arch.vger.kernel.org>

While fixing ppc for DaveM new stuff, I found a couple of things
that look strange (not directly related to the patch though)

 - dma_is_consistent(dma_addr_t address) : Did somebody actually expect
anything useful out of this function ? AFAIK, it makes no sense. There
is simply no way an arch like ppc that use per-page cache-inhibit
mappings to do consistent memory will be able to tell you if a given
_DMA_ address is consistent... that makes no sense.

 - dma_cache_sync(): What is that function supposed to do ? It's a
duplicate of the other sync() functions and David didn't even bother
turning it into _for_device/for_cpu... which is fine since it doesn't
even takes a struct device argument.

I vote for removing the 2 functions above. I suspect something using
them is broken anyway.

Ben.
