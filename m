Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from 74-93-104-97-Washington.hfc.comcastbusiness.net ([74.93.104.97]:50360
	"EHLO sunset.davemloft.net" rhost-flags-OK-FAIL-OK-OK)
	by vger.kernel.org with ESMTP id S1751411AbYD2ITw (ORCPT
	<rfc822;linux-arch@vger.kernel.org>);
	Tue, 29 Apr 2008 04:19:52 -0400
Date: Tue, 29 Apr 2008 01:19:50 -0700 (PDT)
Message-ID: <20080429.011950.50578885.davem@davemloft.net>
Subject: Re: [patch 275/311] kernel: Move arches to use common unaligned
 access
From: David Miller <davem@davemloft.net>
In-Reply-To: <200804290803.m3T83UB3009859@imap1.linux-foundation.org>
References: <200804290803.m3T83UB3009859@imap1.linux-foundation.org>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: akpm@linux-foundation.org
Cc: torvalds@linux-foundation.org, harvey.harrison@gmail.com, linux-arch@vger.kernel.org
Message-ID: <20080429081950.izeWawwOnw5gGIkYSUMnzkkPyHN-GOZpZb4XZ5SO_jw@z>

From: akpm@linux-foundation.org
Date: Tue, 29 Apr 2008 01:03:30 -0700

> From: Harvey Harrison <harvey.harrison@gmail.com>
> 
> Unaligned access is ok for the following arches:
> cris, m68k, mn10300, powerpc, s390, x86
> 
> Arches that use the memmove implementation for native endian, and
> the byteshifting for the opposite endianness.
> h8300, m32r, xtensa
> 
> Packed struct for native endian, byteshifting for other endian:
> alpha, blackfin, ia64, parisc, sparc, sparc64, mips, sh
> 
> m86knommu is generic_be for Coldfire, otherwise unaligned access is ok.
> 
> frv, arm chooses endianness based on compiler settings, uses the byteshifting
> versions.  Remove the unaligned trap handler from frv as it is now unused.
> 
> v850 is le, uses the byteshifting versions for both be and le.
> 
> Remove the now unused asm-generic implementation.
> 
> Signed-off-by: Harvey Harrison <harvey.harrison@gmail.com>
> Cc: <linux-arch@vger.kernel.org>
> Signed-off-by: Andrew Morton <akpm@linux-foundation.org>

Acked-by: David S. Miller <davem@davemloft.net>
