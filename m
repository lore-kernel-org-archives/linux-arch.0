From: rkuo <rkuo@codeaurora.org>
Subject: Re: [PATCH 11/27] hexagon: Use common bits from generic tlb.h
Date: Tue, 20 May 2014 18:58:07 -0500
Message-ID: <20140520235807.GE12698@codeaurora.org>
References: <1400093999-18703-1-git-send-email-richard@nod.at>
 <1400093999-18703-12-git-send-email-richard@nod.at>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1400093999-18703-12-git-send-email-richard@nod.at>
Sender: linux-kernel-owner@vger.kernel.org
To: Richard Weinberger <richard@nod.at>
Cc: linux-arch@vger.kernel.org, arnd@arndb.de, linux-kernel@vger.kernel.org, Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@kernel.org>, Tim Chen <tim.c.chen@linux.intel.com>, Stephen Rothwell <sfr@canb.auug.org.au>, Chen Gang <gang.chen.5i5j@gmail.com>, linux-hexagon@vger.kernel.org
List-Id: linux-arch.vger.kernel.org

On Wed, May 14, 2014 at 08:59:43PM +0200, Richard Weinberger wrote:
> It is no longer needed to define them on our own.
> 
> Cc: Richard Kuo <rkuo@codeaurora.org>
> Cc: Peter Zijlstra <peterz@infradead.org>
> Cc: Ingo Molnar <mingo@kernel.org>
> Cc: Tim Chen <tim.c.chen@linux.intel.com>
> Cc: Stephen Rothwell <sfr@canb.auug.org.au>
> Cc: Chen Gang <gang.chen.5i5j@gmail.com>
> Cc: Richard Weinberger <richard@nod.at>
> Cc: linux-hexagon@vger.kernel.org
> Cc: linux-kernel@vger.kernel.org
> Signed-off-by: Richard Weinberger <richard@nod.at>
> ---
>  arch/hexagon/include/asm/Kbuild |  1 +
>  arch/hexagon/include/asm/tlb.h  | 39 ---------------------------------------
>  2 files changed, 1 insertion(+), 39 deletions(-)
>  delete mode 100644 arch/hexagon/include/asm/tlb.h
> 

Worked for Hexagon, thanks.

Acked-by: Richard Kuo <rkuo@codeaurora.org>

-- 

Sent by an employee of the Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
hosted by The Linux Foundation
