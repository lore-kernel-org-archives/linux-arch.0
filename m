From: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
Subject: Question/clarification on pmd accessors
Date: Sun, 02 Nov 2014 19:18:46 +0530
Message-ID: <87fve1hfwh.fsf@linux.vnet.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from e23smtp09.au.ibm.com ([202.81.31.142]:46489 "EHLO
	e23smtp09.au.ibm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750959AbaKBNto (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Sun, 2 Nov 2014 08:49:44 -0500
Received: from /spool/local
	by e23smtp09.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
	for <linux-arch@vger.kernel.org> from <aneesh.kumar@linux.vnet.ibm.com>;
	Sun, 2 Nov 2014 23:49:42 +1000
Received: from d23relay06.au.ibm.com (d23relay06.au.ibm.com [9.185.63.219])
	by d23dlp03.au.ibm.com (Postfix) with ESMTP id 8C33F3578048
	for <linux-arch@vger.kernel.org>; Mon,  3 Nov 2014 00:49:38 +1100 (EST)
Received: from d23av03.au.ibm.com (d23av03.au.ibm.com [9.190.234.97])
	by d23relay06.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id sA2DnJ0623920874
	for <linux-arch@vger.kernel.org>; Mon, 3 Nov 2014 00:49:27 +1100
Received: from d23av03.au.ibm.com (localhost [127.0.0.1])
	by d23av03.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id sA2Dn5cp009227
	for <linux-arch@vger.kernel.org>; Mon, 3 Nov 2014 00:49:05 +1100
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: David Miller <davem@davemloft.net>, Andrea Arcangeli <aarcange@redhat.com>, Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: linux-arch@vger.kernel.org, "linux-mm@kvack.org" <linux-mm@kvack.org>


Hi Andrea,

This came up when I was looking at how best we can implement generic GUP
that can also handle sparc usecase. Below are the pmd accessors that
would be nice to get documented. 

pmd_present():
        I guess we should return true for both pointer to pte page and
        huge page pte (THP and explicit hugepages). We will always find
        THP and explicit hugepage present. If so how is it
        different from pmd_none() ? (There is an expection of
        __split_huge_page_map marking the pmd not
        present. Should pmd_present() return false in that case ?)

pmd_none():
        In some arch it is same as !pmd_present(). I am
        not sure that is correct. Can we explain the difference between
        !pmd_present and pmd_none ?

pmd_trans_huge():
        pmd value that represent a hugepage built via THP mechanism.
        Also implies present.

pmd_huge():
        Should cover both the THP and explicit hugepages

pmd_large():
        This is confusing. On ppc64 this one also check for
        _PAGE_PRESENT. I don't recollect how we end up with that.

-aneesh

        

        

        
