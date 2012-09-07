Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.17.9]:65296 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757057Ab2IGTo3 (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Fri, 7 Sep 2012 15:44:29 -0400
From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH v3 18/31] arm64: VDSO support
Date: Fri, 7 Sep 2012 19:44:23 +0000
References: <1347035226-18649-1-git-send-email-catalin.marinas@arm.com> <1347035226-18649-19-git-send-email-catalin.marinas@arm.com>
In-Reply-To: <1347035226-18649-19-git-send-email-catalin.marinas@arm.com>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="windows-1252"
Content-Transfer-Encoding: 7bit
Message-ID: <201209071944.23703.arnd@arndb.de>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Catalin Marinas <catalin.marinas@arm.com>
Cc: linux-arch@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Message-ID: <20120907194423.R8LxDDweK0__JXWgyeJVTmvQmx-D47BPMkfBLztJyWY@z>

On Friday 07 September 2012, Catalin Marinas wrote:
> From: Will Deacon <will.deacon@arm.com>
> 
> This patch adds VDSO support for 64-bit applications. The VDSO code is
> currently used for sys_rt_sigreturn() and optimised gettimeofday()
> (using the user-accessible generic counter).
> 
> Signed-off-by: Will Deacon <will.deacon@arm.com>
> Signed-off-by: Catalin Marinas <catalin.marinas@arm.com>
> Acked-by: Tony Lindgren <tony@atomide.com>

Acked-by: Arnd Bergmann <arnd@arndb.de>
