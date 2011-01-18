From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH] asm-generic/io.h: Fix io{read,write}{16,32}be for big endian systems
Date: Tue, 18 Jan 2011 19:44:07 +0100
Message-ID: <201101181944.07146.arnd@arndb.de>
References: <1295374261-19609-1-git-send-email-lars@metafoo.de>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.126.186]:61403 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752512Ab1ARSoO (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Tue, 18 Jan 2011 13:44:14 -0500
In-Reply-To: <1295374261-19609-1-git-send-email-lars@metafoo.de>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Lars-Peter Clausen <lars@metafoo.de>
Cc: linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org

On Tuesday 18 January 2011 19:11:01 Lars-Peter Clausen wrote:
> Currently io{read,write}{16,32} expand to
>         *addr = cpu_to_leXX(cpu_to_beXX(val))
> and
>         val = beXX_to_cpu(leXX_to_cpu(*addr))
> 
> While it should rather be:
>         *addr = cpu_to_be{16,32}(val)
> and
>         val = be{16,32}_to_cpu(*addr)
> 
> The current implementation works on litte-endian targets(where cpu_to_leXX is a
> noop), but breaks on on big-endian targets, this patch fixes it.
> 
> Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>

The existing code looks broken on big-endian indeed, thanks
for the report!

However, you cannot use __raw_readl in general, because that
function knows nothing about the various kinds of I/O accesses
(potentially) handled by readl. Think of architectures where
readl is not a pointer dereference but something else.

The right solution is probably to use swab16/swab32 for the
big-endian functions. This also corrects the iowrite functions
which really should be using cpu_to_be32 instead of be32_to_cpu
(although they are always defined to be the same afaict.

	Arnd
