From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH v3 16/31] arm64: ELF definitions
Date: Fri, 7 Sep 2012 19:40:25 +0000
Message-ID: <201209071940.25377.arnd@arndb.de>
References: <1347035226-18649-1-git-send-email-catalin.marinas@arm.com> <1347035226-18649-17-git-send-email-catalin.marinas@arm.com>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="windows-1252"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.17.8]:56578 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753540Ab2IGTka (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Fri, 7 Sep 2012 15:40:30 -0400
In-Reply-To: <1347035226-18649-17-git-send-email-catalin.marinas@arm.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Catalin Marinas <catalin.marinas@arm.com>
Cc: linux-arch@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org

On Friday 07 September 2012, Catalin Marinas wrote:
> This patch adds definitions for the ELF format, including personality
> personality setting and EXEC_PAGESIZE. The are only two hwcap
> definitions for 64-bit applications - HWCAP_FP and HWCAP_ASIMD.
> 
> Signed-off-by: Will Deacon <will.deacon@arm.com>
> Signed-off-by: Catalin Marinas <catalin.marinas@arm.com>
> Acked-by: Tony Lindgren <tony@atomide.com>

Acked-by: Arnd Bergmann <arnd@arndb.de>
