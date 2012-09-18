From: Chris Metcalf <cmetcalf@tilera.com>
Subject: Re: [PATCH] compat: Generic compat_sys_sched_rr_get_interval implementation
Date: Tue, 18 Sep 2012 13:39:38 -0400
Message-ID: <5058B1DA.4070001@tilera.com>
References: <1347987727-13739-2-git-send-email-catalin.marinas@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from usmamail.tilera.com ([12.216.194.151]:51469 "EHLO
	USMAMAIL.TILERA.COM" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752404Ab2IRRjk (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Tue, 18 Sep 2012 13:39:40 -0400
In-Reply-To: <1347987727-13739-2-git-send-email-catalin.marinas@arm.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Catalin Marinas <catalin.marinas@arm.com>
Cc: linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Paul Mackerras <paulus@samba.org>, "David S. Miller" <davem@davemloft.net>, Alexander Viro <viro@zeniv.linux.org.uk>, Andrew Morton <akpm@linux-foundation.org>

On 9/18/2012 1:02 PM, Catalin Marinas wrote:
> This function is used by sparc, powerpc tile and arm64 for compat
> support. The patch adds a generic implementation with a wrapper for
> PowerPC to do the u32->int sign extension.
>
> The reason for a single patch covering powerpc, tile and sparc is to
> keep it bisectable, otherwise kernel building may fail with mismatched
> function declarations.
>
> Signed-off-by: Catalin Marinas <catalin.marinas@arm.com>
> Cc: Arnd Bergmann <arnd@arndb.de>
> Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
> Cc: Paul Mackerras <paulus@samba.org>
> Cc: David S. Miller <davem@davemloft.net>
> Cc: Alexander Viro <viro@zeniv.linux.org.uk>
> Cc: Chris Metcalf <cmetcalf@tilera.com>
> Cc: Andrew Morton <akpm@linux-foundation.org>
> ---
>
> Please note that the patch has only been compile-tested on sparc, tile
> and powerpc (run-time tested on arm64).

Acked-by: Chris Metcalf <cmetcalf@tilera.com>  [for tile]

-- 
Chris Metcalf, Tilera Corp.
http://www.tilera.com
