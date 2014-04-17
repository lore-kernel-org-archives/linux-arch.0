From: Chris Metcalf <cmetcalf@tilera.com>
Subject: Re: [PATCH 15/18] tile: io: implement dummy relaxed accessor macros
 for writes
Date: Thu, 17 Apr 2014 10:52:53 -0400
Message-ID: <534FEAC5.10808@tilera.com>
References: <1397742261-15621-1-git-send-email-will.deacon@arm.com> <1397742261-15621-16-git-send-email-will.deacon@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from usmamail.tilera.com ([12.216.194.151]:28749 "EHLO
	USMAMAIL.TILERA.COM" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751113AbaDQOwy (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Thu, 17 Apr 2014 10:52:54 -0400
In-Reply-To: <1397742261-15621-16-git-send-email-will.deacon@arm.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Will Deacon <will.deacon@arm.com>, linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: arnd@arndb.de, monstr@monstr.eu, dhowells@redhat.com, broonie@linaro.org, benh@kernel.crashing.org, peterz@infradead.org, paulmck@linux.vnet.ibm.com

On 4/17/2014 9:44 AM, Will Deacon wrote:
> write{b,w,l,q}_relaxed are implemented by some architectures in order to
> permit memory-mapped I/O accesses with weaker barrier semantics than the
> non-relaxed variants.
>
> This patch adds dummy macros for the write accessors to tile, in the
> same vein as the dummy definitions for the relaxed read accessors.
>
> Cc: Chris Metcalf <cmetcalf@tilera.com>
> Signed-off-by: Will Deacon <will.deacon@arm.com>
> ---
>  arch/tile/include/asm/io.h | 4 ++++
>  1 file changed, 4 insertions(+)

Acked-by: Chris Metcalf <cmetcalf@tilera.com>

-- 
Chris Metcalf, Tilera Corp.
http://www.tilera.com
