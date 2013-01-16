From: James Bottomley <James.Bottomley@HansenPartnership.com>
Subject: architecture problems with SPARSEMEM and page iteration functions
Date: Wed, 16 Jan 2013 16:09:24 +0000
Message-ID: <1358352564.2384.48.camel@dabdike.int.hansenpartnership.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-15"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from bedivere.hansenpartnership.com ([66.63.167.143]:54453 "EHLO
	bedivere.hansenpartnership.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S932739Ab3APQJ1 (ORCPT
	<rfc822;linux-arch@vger.kernel.org>);
	Wed, 16 Jan 2013 11:09:27 -0500
Received: from localhost (localhost [127.0.0.1])
	by bedivere.hansenpartnership.com (Postfix) with ESMTP id 003C18EE0DF
	for <linux-arch@vger.kernel.org>; Wed, 16 Jan 2013 08:09:27 -0800 (PST)
Received: from bedivere.hansenpartnership.com ([127.0.0.1])
	by localhost (bedivere.hansenpartnership.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id InwPnkPik_AU for <linux-arch@vger.kernel.org>;
	Wed, 16 Jan 2013 08:09:26 -0800 (PST)
Received: from [153.66.254.224] (accolon.hansenpartnership.com [46.65.52.191])
	by bedivere.hansenpartnership.com (Postfix) with ESMTPSA id 4C7948EE0C9
	for <linux-arch@vger.kernel.org>; Wed, 16 Jan 2013 08:09:26 -0800 (PST)
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: linux-arch@vger.kernel.org

A cursory grep indicates the architectures which may be affected by this
bug are:

arm, avr32, m32r, microblaze, mips, powerpc, s390, sparc, x86

The problem is the assumption that if you have a piece of contiguous
physical memory, you can iterate over it by starting with the first
struct page *page and doing page++.

The page++ trick works with FLATMEM and DISCONTIGMEM, but not SPARSEMEM.
The reason is that the SPARSEMEM section arrays have arbitrary power of
2 boundaries, so you can end up with physically adjacent pieces of
memory which are in different section arrays, meaning that page++
doesn't work, because it doesn't move from the end of the old section
array to the beginning of the new one.

The fix is to iterate by means of the pfn instead (the pfn_to_page()
functions do the right thing with respect to the section arrays) or
simply replace

page++

with

page = pfn_to_page(page_to_pfn(page) + 1);

A large number of the architectures seem to pick up the problem through
huge pages, so I note that as long as your SECTION_SIZE_BITS is large
enough (i.e. huge page size < 1 << (SECTION_SIZE_BITS + PAGE_SIZE)) you
should be OK.

James
