From: Catalin Marinas <catalin.marinas@arm.com>
Subject: Re: [PATCH RESEND 03/14] arm64: locks: remove redundant
 arch_*_relax operations
Date: Wed, 26 Feb 2014 12:15:22 +0000
Message-ID: <20140226121522.GA7761@arm.com>
References: <1393004101-25382-1-git-send-email-will.deacon@arm.com>
 <1393004101-25382-4-git-send-email-will.deacon@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from fw-tnat.austin.arm.com ([217.140.110.23]:46458 "EHLO
	collaborate-mta1.arm.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1750918AbaBZMPd (ORCPT
	<rfc822;linux-arch@vger.kernel.org>);
	Wed, 26 Feb 2014 07:15:33 -0500
Content-Disposition: inline
In-Reply-To: <1393004101-25382-4-git-send-email-will.deacon@arm.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Will Deacon <will.deacon@arm.com>
Cc: akpm@linux-foundation.org, linux-arch@vger.kernel.org

On Fri, Feb 21, 2014 at 05:34:50PM +0000, Will Deacon wrote:
> Now that the arch_{spin,read,write}_relax macros default to cpu_relax(),
> remove the redundant definitions for arm64.
> 
> Cc: Catalin Marinas <catalin.marinas@arm.com>
> Signed-off-by: Will Deacon <will.deacon@arm.com>

Acked-by: Catalin Marinas <catalin.marinas@arm.com>
