Return-Path: <linux-arch-owner+james.bottomley=40steeleye.com-S267625AbUHPNBQ@vger.kernel.org>
Received: from palrel11.hp.com ([156.153.255.246]:30103 "EHLO palrel11.hp.com")
	by vger.kernel.org with ESMTP id S267619AbUHPNAy (ORCPT
	<rfc822;linux-arch@vger.kernel.org>);
	Mon, 16 Aug 2004 09:00:54 -0400
From: David Mosberger <davidm@napali.hpl.hp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16672.45037.630064.539644@napali.hpl.hp.com>
Date: Mon, 16 Aug 2004 06:00:29 -0700
Subject: Re: clear_user_highpage()
In-Reply-To: <20040813144115.4c59a2f0.davem@redhat.com>
References: <20040811161537.5e24c2b6.davem@redhat.com>
	<Pine.LNX.4.58.0408111635160.1839@ppc970.osdl.org>
	<20040812004654.GX11200@holomorphy.com>
	<Pine.LNX.4.58.0408111905210.1839@ppc970.osdl.org>
	<20040813144115.4c59a2f0.davem@redhat.com>
Reply-To: davidm@hpl.hp.com
To: "David S. Miller" <davem@redhat.com>
Cc: Linus Torvalds <torvalds@osdl.org>, wli@holomorphy.com, linux-arch@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>

>>>>> On Fri, 13 Aug 2004 14:41:15 -0700, "David S. Miller" <davem@redhat.com> said:

  DaveM> On Wed, 11 Aug 2004 19:18:18 -0700 (PDT) Linus Torvalds
  DaveM> <torvalds@osdl.org> wrote:

  >> I really do believe (but can't back it up with any real numbers)
  >> that we want to try to keep pages in cache as long as
  >> possible. That means keeping the pages close to the last CPU that
  >> used them, btw.

  DaveM> So I did some testing.

  DaveM> I changed the cache-bypassing clear_user_page() into one that
  DaveM> uses normal stores and does allocate in the L2 cache.

  DaveM> I ran the full build tests 3 times for each case, and the
  DaveM> numbers were consistent.  It makes the full build take a full
  DaveM> minute longer.

Very interesting. I tried something similar on a dual 1.5GHz Itanium
2.  I tried two versions of clear_page: one with .nta (no-temporal
affinity hint, which is the default) and one without.  The result for
5 runs of a fairly minimal kernel-compile (with make -j8):

	with .nta:			without .nta:

real	80.0 70.2 71.0 70.4 70.3	79.4 69.5 69.5 69.5 69.3
sys	 4.6  4.6  4.6  4.6  4.5	 5.3  5.4  5.3  5.4  5.4

Note that the first run was with cold page cache, hence the longer
runtime.

So, on average, dropping the .nta costs us 0.78 seconds of kernel-time
but, overall, the kernel-builds complete about 0.94 seconds faster.

Of course, it's just one (more) data-point...

	--david
