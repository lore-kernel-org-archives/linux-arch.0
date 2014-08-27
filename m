From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: Re: [PATH V2 1/6] mm: Introduce a general RCU get_user_pages_fast.
Date: Wed, 27 Aug 2014 16:01:39 +0100
Message-ID: <20140827150139.GZ30401@n2100.arm.linux.org.uk>
References: <1408635812-31584-1-git-send-email-steve.capper@linaro.org> <1408635812-31584-2-git-send-email-steve.capper@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from gw-1.arm.linux.org.uk ([78.32.30.217]:34414 "EHLO
	pandora.arm.linux.org.uk" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S934344AbaH0PBy (ORCPT
	<rfc822;linux-arch@vger.kernel.org>);
	Wed, 27 Aug 2014 11:01:54 -0400
Content-Disposition: inline
In-Reply-To: <1408635812-31584-2-git-send-email-steve.capper@linaro.org>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Steve Capper <steve.capper@linaro.org>
Cc: linux-arm-kernel@lists.infradead.org, catalin.marinas@arm.com, linux-arch@vger.kernel.org, linux-mm@kvack.org, will.deacon@arm.com, gary.robertson@linaro.org, christoffer.dall@linaro.org, peterz@infradead.org, anders.roxell@linaro.org, akpm@linux-foundation.org, dann.frazier@canonical.com, mark.rutland@arm.com, mgorman@suse.de

On Thu, Aug 21, 2014 at 04:43:27PM +0100, Steve Capper wrote:
> +int get_user_pages_fast(unsigned long start, int nr_pages, int write,
> +			struct page **pages)
> +{
> +	struct mm_struct *mm = current->mm;
> +	int nr, ret;
> +
> +	start &= PAGE_MASK;
> +	nr = __get_user_pages_fast(start, nr_pages, write, pages);
> +	ret = nr;
> +
> +	if (nr < nr_pages) {
> +		/* Try to get the remaining pages with get_user_pages */
> +		start += nr << PAGE_SHIFT;
> +		pages += nr;

When I read this, my first reaction was... what if nr is negative?  In
that case, if nr_pages is positive, we fall through into this if, and
start to wind things backwards - which isn't what we want.

It looks like that can't happen... right?  __get_user_pages_fast() only
returns greater-or-equal to zero right now, but what about the future?

> +
> +		down_read(&mm->mmap_sem);
> +		ret = get_user_pages(current, mm, start,
> +				     nr_pages - nr, write, 0, pages, NULL);
> +		up_read(&mm->mmap_sem);
> +
> +		/* Have to be a bit careful with return values */
> +		if (nr > 0) {

This kind'a makes it look like nr could be negative.

Other than that, I don't see anything obviously wrong with it.

-- 
FTTC broadband for 0.8mile line: currently at 9.5Mbps down 400kbps up
according to speedtest.net.
