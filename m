Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.17.9]:59973 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756266Ab3AROyj (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Fri, 18 Jan 2013 09:54:39 -0500
From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH v2 56/76] ARC: Unaligned access emulation
Date: Fri, 18 Jan 2013 14:54:36 +0000
References: <1358511930-7424-1-git-send-email-vgupta@synopsys.com> <1358511930-7424-57-git-send-email-vgupta@synopsys.com>
In-Reply-To: <1358511930-7424-57-git-send-email-vgupta@synopsys.com>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Message-ID: <201301181454.36279.arnd@arndb.de>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Vineet Gupta <Vineet.Gupta1@synopsys.com>
Cc: linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org, Tim Yao <tim.yao@amlogic.com>
Message-ID: <20130118145436.yyYPS5G4ZY-6potwpqat65bcY0IsBcv5pMnriilmjWo@z>

On Friday 18 January 2013, Vineet Gupta wrote:
> ARC700 doesn't natively support unaligned access, but can be emulated
> -Unaligned Access Exception
> -Disassembly at the Fault address to find the exact insn (long/short)
> 
> Also per Arnd's comment, we runtime control it using 2 sysctl knobs:
> * SYSCTL_ARCH_UNALIGN_ALLOW: Runtime enable/disble
> * SYSCTL_ARCH_UNALIGN_NO_WARN: Warn on each emulation attempt
> 
> Originally contributed by Tim Yao <tim.yao@amlogic.com>
> 
> Signed-off-by: Vineet Gupta <vgupta@synopsys.com>
> Cc: Tim Yao <tim.yao@amlogic.com>

Acked-by: Arnd Bergmann <arnd@arndb.de>
