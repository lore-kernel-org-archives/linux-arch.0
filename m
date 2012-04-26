From: Stephen Boyd <sboyd@codeaurora.org>
Subject: Re: [PATCH] Move most arches to asm-generic/current.h
Date: Thu, 26 Apr 2012 10:51:48 -0700
Message-ID: <4F998B34.4090403@codeaurora.org>
References: <1335237509-17113-1-git-send-email-sboyd@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from wolverine01.qualcomm.com ([199.106.114.254]:50537 "EHLO
	wolverine01.qualcomm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751716Ab2DZRvu (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Thu, 26 Apr 2012 13:51:50 -0400
In-Reply-To: <1335237509-17113-1-git-send-email-sboyd@codeaurora.org>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Arnd Bergmann <arnd@arndb.de>
Cc: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org

On 04/23/12 20:18, Stephen Boyd wrote:
> Make get_current() into a static inline function in the
> generic version of current.h so we match what almost every
> architecture is doing. This allows us to move most of the arches
> over to this generic header instead of redefining the same thing
> over and over in each asm directory.
>
> Signed-off-by: Stephen Boyd <sboyd@codeaurora.org>
> Cc: linux-arch@vger.kernel.org
> ---
> diff --git a/arch/alpha/include/asm/Kbuild b/arch/alpha/include/asm/Kbuild
> index e423def..8b8f979 100644
> --- a/arch/alpha/include/asm/Kbuild
> +++ b/arch/alpha/include/asm/Kbuild
> @@ -2,6 +2,7 @@ include include/asm-generic/Kbuild.asm
>  
>  header-y += compiler.h
>  header-y += console.h
> +header-y += current.h

Oops. This should be generic-y not header-y.

-- 
Sent by an employee of the Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum.
