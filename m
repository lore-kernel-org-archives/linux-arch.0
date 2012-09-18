Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from shards.monkeyblade.net ([149.20.54.216]:46589 "EHLO
	shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754583Ab2IRUHN (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Tue, 18 Sep 2012 16:07:13 -0400
Date: Tue, 18 Sep 2012 16:07:11 -0400 (EDT)
Message-ID: <20120918.160711.306288733249793274.davem@davemloft.net>
Subject: Re: [PATCH] compat: Generic compat_sys_sched_rr_get_interval
 implementation
From: David Miller <davem@davemloft.net>
In-Reply-To: <1347987727-13739-2-git-send-email-catalin.marinas@arm.com>
References: <1347987727-13739-2-git-send-email-catalin.marinas@arm.com>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: catalin.marinas@arm.com
Cc: linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org, arnd@arndb.de, benh@kernel.crashing.org, paulus@samba.org, viro@zeniv.linux.org.uk, cmetcalf@tilera.com, akpm@linux-foundation.org
Message-ID: <20120918200711.gNPKCnH9_NF2y31-1zdXQIJmXFfH_c-Eelp0VhZGzTA@z>

From: Catalin Marinas <catalin.marinas@arm.com>
Date: Tue, 18 Sep 2012 18:02:07 +0100

> This function is used by sparc, powerpc tile and arm64 for compat
> support. The patch adds a generic implementation with a wrapper for
> PowerPC to do the u32->int sign extension.
> 
> The reason for a single patch covering powerpc, tile and sparc is to
> keep it bisectable, otherwise kernel building may fail with mismatched
> function declarations.
> 
> Signed-off-by: Catalin Marinas <catalin.marinas@arm.com>

Acked-by: David S. Miller <davem@davemloft.net>
