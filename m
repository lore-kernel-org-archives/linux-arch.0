From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH v2 13/31] arm64: Device specific operations
Date: Wed, 15 Aug 2012 16:13:57 +0000
Message-ID: <201208151613.57400.arnd@arndb.de>
References: <1344966752-16102-1-git-send-email-catalin.marinas@arm.com> <1344966752-16102-14-git-send-email-catalin.marinas@arm.com>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="windows-1252"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.17.9]:60695 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752088Ab2HOQOD (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Wed, 15 Aug 2012 12:14:03 -0400
In-Reply-To: <1344966752-16102-14-git-send-email-catalin.marinas@arm.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Catalin Marinas <catalin.marinas@arm.com>
Cc: linux-arch@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, Will Deacon <will.deacon@arm.com>

On Tuesday 14 August 2012, Catalin Marinas wrote:
> 
> This patch adds several definitions for device communication, including
> I/O accessors and ioremap(). The __raw_* accessors are implemented as
> inline asm to avoid compiler generation of post-indexed accesses (less
> efficient to emulate in a virtualised environment).
> 
> Signed-off-by: Will Deacon <will.deacon@arm.com>
> Signed-off-by: Catalin Marinas <catalin.marinas@arm.com>


Acked-by: Arnd Bergmann <arnd@arndb.de>
