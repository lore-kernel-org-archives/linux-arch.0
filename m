Return-Path: <linux-arch-owner+james.bottomley=40steeleye.com-S266409AbUHIJgn@vger.kernel.org>
Received: from holomorphy.com ([207.189.100.168]:19422 "EHLO holomorphy.com")
	by vger.kernel.org with ESMTP id S266386AbUHIJgn (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Mon, 9 Aug 2004 05:36:43 -0400
Date: Mon, 9 Aug 2004 02:29:43 -0700
From: William Lee Irwin III <wli@holomorphy.com>
Subject: Re: copy_page_range()
Message-ID: <20040809092943.GP11200@holomorphy.com>
References: <20040807000529.5ca6e8fe.davem@redhat.com> <16663.15729.828367.307053@napali.hpl.hp.com> <20040809090458.GO11200@holomorphy.com> <16663.17268.247682.953102@napali.hpl.hp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <16663.17268.247682.953102@napali.hpl.hp.com>
To: davidm@hpl.hp.com
Cc: "David S. Miller" <davem@redhat.com>, torvalds@osdl.org, linux-arch@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>

On Mon, 9 Aug 2004 02:04:58 -0700, William Lee Irwin III <wli@holomorphy.com> said:
William> These results are actually consistent with large-memory
William> ia32.  Instruction-level profiles showed that the largest
William> overhead in copy_page_range() on such ia32 boxen appeared
William> to be mm->rss++.

On Mon, Aug 09, 2004 at 02:27:16AM -0700, David Mosberger wrote:
> Hmmh, for me, the single biggest stall seems to come from the pmd_none()
> check in free_one_pmd().

That was the case in clear_page_tables(); it was copy_page_range() that
saw mm->rss++ take an unusual amount of time.


-- wli
