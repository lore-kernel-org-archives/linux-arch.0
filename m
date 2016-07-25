From: Catalin Marinas <catalin.marinas@arm.com>
Subject: Re: [PATCH 04/14] arm64: migrate exception table users off module.h
 and onto extable.h
Date: Mon, 25 Jul 2016 17:03:28 +0100
Message-ID: <20160725160328.GC2423@e104818-lin.cambridge.arm.com>
References: <20160725034247.109173-1-paul.gortmaker@windriver.com>
 <20160725034247.109173-5-paul.gortmaker@windriver.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from foss.arm.com ([217.140.101.70]:34783 "EHLO foss.arm.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752927AbcGYQDd (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Mon, 25 Jul 2016 12:03:33 -0400
Content-Disposition: inline
In-Reply-To: <20160725034247.109173-5-paul.gortmaker@windriver.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Paul Gortmaker <paul.gortmaker@windriver.com>
Cc: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, Will Deacon <will.deacon@arm.com>, linux-arm-kernel@lists.infradead.org

On Sun, Jul 24, 2016 at 11:42:37PM -0400, Paul Gortmaker wrote:
> These files were only including module.h for exception table
> related functions.  We've now separated that content out into its
> own file "extable.h" so now move over to that and avoid all the
> extra header content in module.h that we don't really need to compile
> these files.
> 
> Cc: Catalin Marinas <catalin.marinas@arm.com>
> Cc: Will Deacon <will.deacon@arm.com>
> Cc: linux-arm-kernel@lists.infradead.org
> Signed-off-by: Paul Gortmaker <paul.gortmaker@windriver.com>

Acked-by: Catalin Marinas <catalin.marinas@arm.com>
