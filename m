Return-Path: <linux-arch-owner+james.bottomley=40steeleye.com-S266802AbUHIRuv@vger.kernel.org>
Received: from mx1.redhat.com ([66.187.233.31]:37329 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S266797AbUHIRuq (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Mon, 9 Aug 2004 13:50:46 -0400
Date: Mon, 9 Aug 2004 10:46:16 -0700
From: "David S. Miller" <davem@redhat.com>
Subject: Re: copy_page_range()
Message-Id: <20040809104616.3ce07ddf.davem@redhat.com>
In-Reply-To: <16663.17268.247682.953102@napali.hpl.hp.com>
References: <20040807000529.5ca6e8fe.davem@redhat.com>
	<16663.15729.828367.307053@napali.hpl.hp.com>
	<20040809090458.GO11200@holomorphy.com>
	<16663.17268.247682.953102@napali.hpl.hp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
To: davidm@hpl.hp.com
Cc: davidm@napali.hpl.hp.com, wli@holomorphy.com, torvalds@osdl.org, linux-arch@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>

On Mon, 9 Aug 2004 02:27:16 -0700
David Mosberger <davidm@napali.hpl.hp.com> wrote:

> >>>>> On Mon, 9 Aug 2004 02:04:58 -0700, William Lee Irwin III <wli@holomorphy.com> said:
> 
>   William> These results are actually consistent with large-memory
>   William> ia32.  Instruction-level profiles showed that the largest
>   William> overhead in copy_page_range() on such ia32 boxen appeared
>   William> to be mm->rss++.
> 
> Hmmh, for me, the single biggest stall seems to come from the pmd_none()
> check in free_one_pmd().

Right, that is what gets hit on sparc64 too.

On ia32, the tables are half the size, thus half the amount of
memory accesses per table traversal.
