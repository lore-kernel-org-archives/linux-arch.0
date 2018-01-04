From: Mark Rutland <mark.rutland@arm.com>
Subject: Re: [RFC PATCH 1/4] asm-generic/barrier: add generic nospec helpers
Date: Thu, 4 Jan 2018 12:00:42 +0000
Message-ID: <20180104120021.lilczus6qv7e4vcw@salmiak>
References: <20180103223827.39601-1-mark.rutland@arm.com>
 <20180103223827.39601-2-mark.rutland@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from foss.arm.com ([217.140.101.70]:59798 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752848AbeADMAx (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Thu, 4 Jan 2018 07:00:53 -0500
Content-Disposition: inline
In-Reply-To: <20180103223827.39601-2-mark.rutland@arm.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: linux-kernel@vger.kernel.org
Cc: linux-arch@vger.kernel.org, Will Deacon <will.deacon@arm.com>

On Wed, Jan 03, 2018 at 10:38:24PM +0000, Mark Rutland wrote:
> +#define nospec_array_load(arr, idx, sz)					\
> +({									\
> +	typeof(*(arr)) *__arr = arr;					\
> +	typeof(idx) __idx = idx;					\
> +	typeof(sz) __sz = __sz;						\

Whoops. The second __sz should be sz here.

Mark.
