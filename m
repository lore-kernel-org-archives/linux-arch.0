Return-Path: <linux-arch-owner+james.bottomley=40steeleye.com-S266443AbUHIKCA@vger.kernel.org>
Received: from palrel13.hp.com ([156.153.255.238]:15506 "EHLO palrel13.hp.com")
	by vger.kernel.org with ESMTP id S263040AbUHIKCA (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Mon, 9 Aug 2004 06:02:00 -0400
From: David Mosberger <davidm@napali.hpl.hp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16663.19349.428906.148363@napali.hpl.hp.com>
Date: Mon, 9 Aug 2004 03:01:57 -0700
Subject: Re: copy_page_range()
In-Reply-To: <20040809092943.GP11200@holomorphy.com>
References: <20040807000529.5ca6e8fe.davem@redhat.com>
	<16663.15729.828367.307053@napali.hpl.hp.com>
	<20040809090458.GO11200@holomorphy.com>
	<16663.17268.247682.953102@napali.hpl.hp.com>
	<20040809092943.GP11200@holomorphy.com>
Reply-To: davidm@hpl.hp.com
To: William Lee Irwin III <wli@holomorphy.com>
Cc: davidm@hpl.hp.com, "David S. Miller" <davem@redhat.com>, torvalds@osdl.org, linux-arch@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>

>>>>> On Mon, 9 Aug 2004 02:29:43 -0700, William Lee Irwin III <wli@holomorphy.com> said:

  William> On Mon, Aug 09, 2004 at 02:27:16AM -0700, David Mosberger
  William> wrote:
  >> Hmmh, for me, the single biggest stall seems to come from the
  >> pmd_none() check in free_one_pmd().

  William> That was the case in clear_page_tables(); it was
  William> copy_page_range() that saw mm->rss++ take an unusual amount
  William> of time.

Sorry, I misread your mail.  In my cause, the biggest staller in
copy_page_range() seems to be page_dup_rmap() (right after
dst->rss++).  Specifically, the test_and_set_bit() which comes from
page_dup_rmap()->page_map_lock()->bit_spin_lock() is causing the
stalls.

	--david
