From: David Miller <davem@davemloft.net>
Subject: Re: [PATCH] compat: Generic compat_sys_sched_rr_get_interval
 implementation
Date: Tue, 18 Sep 2012 16:07:11 -0400 (EDT)
Message-ID: <20120918.160711.306288733249793274.davem@davemloft.net>
References: <1347987727-13739-2-git-send-email-catalin.marinas@arm.com>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1347987727-13739-2-git-send-email-catalin.marinas@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
To: catalin.marinas@arm.com
Cc: linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org, arnd@arndb.de, benh@kernel.crashing.org, paulus@samba.org, viro@zeniv.linux.org.uk, cmetcalf@tilera.com, akpm@linux-foundation.org
List-Id: linux-arch.vger.kernel.org

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
