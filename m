From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH v2 29/31] arm64: Miscellaneous header files
Date: Wed, 15 Aug 2012 15:56:46 +0000
Message-ID: <201208151556.46426.arnd@arndb.de>
References: <1344966752-16102-1-git-send-email-catalin.marinas@arm.com> <1344966752-16102-30-git-send-email-catalin.marinas@arm.com>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="windows-1252"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.17.8]:49178 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754681Ab2HOP4u (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Wed, 15 Aug 2012 11:56:50 -0400
In-Reply-To: <1344966752-16102-30-git-send-email-catalin.marinas@arm.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Catalin Marinas <catalin.marinas@arm.com>
Cc: linux-arch@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, Will Deacon <will.deacon@arm.com>

On Tuesday 14 August 2012, Catalin Marinas wrote:

> diff --git a/arch/arm64/include/asm/cmpxchg.h b/arch/arm64/include/asm/cmpxchg.h
> new file mode 100644
> index 0000000..dc50de7
> --- /dev/null
> +++ b/arch/arm64/include/asm/cmpxchg.h

> +	default:
> +		__bad_cmpxchg(ptr, size);
> +		oldval = 0;
> +	}

I did not see a definition for __bad_cmpxchg but I may have missed that.
Please make sure that none exists, or just use BUILD_BUG_ON().

	Arnd
