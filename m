Return-Path: <linux-arch-owner+james.bottomley=40steeleye.com-S266425AbUHIJ1U@vger.kernel.org>
Received: from palrel11.hp.com ([156.153.255.246]:36294 "EHLO palrel11.hp.com")
	by vger.kernel.org with ESMTP id S266409AbUHIJ1U (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Mon, 9 Aug 2004 05:27:20 -0400
From: David Mosberger <davidm@napali.hpl.hp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16663.17268.247682.953102@napali.hpl.hp.com>
Date: Mon, 9 Aug 2004 02:27:16 -0700
Subject: Re: copy_page_range()
In-Reply-To: <20040809090458.GO11200@holomorphy.com>
References: <20040807000529.5ca6e8fe.davem@redhat.com>
	<16663.15729.828367.307053@napali.hpl.hp.com>
	<20040809090458.GO11200@holomorphy.com>
Reply-To: davidm@hpl.hp.com
To: William Lee Irwin III <wli@holomorphy.com>
Cc: davidm@hpl.hp.com, "David S. Miller" <davem@redhat.com>, torvalds@osdl.org, linux-arch@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>

>>>>> On Mon, 9 Aug 2004 02:04:58 -0700, William Lee Irwin III <wli@holomorphy.com> said:

  William> These results are actually consistent with large-memory
  William> ia32.  Instruction-level profiles showed that the largest
  William> overhead in copy_page_range() on such ia32 boxen appeared
  William> to be mm->rss++.

Hmmh, for me, the single biggest stall seems to come from the pmd_none()
check in free_one_pmd().

	--david
