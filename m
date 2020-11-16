Return-Path: <linux-arch-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E340C4742C
	for <linux-arch@archiver.kernel.org>; Mon, 16 Nov 2020 15:54:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F1C90207BC
	for <linux-arch@archiver.kernel.org>; Mon, 16 Nov 2020 15:54:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="Q4mgMpkp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730812AbgKPPy2 (ORCPT <rfc822;linux-arch@archiver.kernel.org>);
        Mon, 16 Nov 2020 10:54:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57906 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730328AbgKPPy2 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 16 Nov 2020 10:54:28 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D931DC0613CF;
        Mon, 16 Nov 2020 07:54:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=esjCI1Ilt4rqIh2c5OoP0ZOCK5VTOQGHZkmINdOilPQ=; b=Q4mgMpkplmuw95hgWTQ6+BlRj0
        uOfRZMIJHzav9IdLwC9ckIxRZH15e/Co1SsDhx71QrzehPvueZMdwLuZ1KZdknOau65FGGiiVET/F
        k674UDf+BX9XAXwfweBX6RrGb0wnMobgxyGVWhWn2Igd8Tfpv+W+jOzeWYomchIgV22oso25aWqqo
        8820PqyIy+Vmqd565DZP4wURtlwH9RRPLr4G+rnDcvKr4srwnvbQFIzjlO0edrn/+Eb4WrTGIaBjx
        2VoTGfBHrYd9go23OLiaxnKfyx91LfkAAaXVjufE8rjE7o8sfYcW364KBUVgKn9VzLoiOq1tan+Ij
        7Hb74+tg==;
Received: from willy by casper.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kegpQ-0001xk-GD; Mon, 16 Nov 2020 15:54:04 +0000
Date:   Mon, 16 Nov 2020 15:54:04 +0000
From:   Matthew Wilcox <willy@infradead.org>
To:     "Kirill A. Shutemov" <kirill@shutemov.name>
Cc:     Peter Zijlstra <peterz@infradead.org>, kan.liang@linux.intel.com,
        mingo@kernel.org, acme@kernel.org, mark.rutland@arm.com,
        alexander.shishkin@linux.intel.com, jolsa@redhat.com,
        eranian@google.com, christophe.leroy@csgroup.eu, npiggin@gmail.com,
        linuxppc-dev@lists.ozlabs.org, mpe@ellerman.id.au, will@kernel.org,
        aneesh.kumar@linux.ibm.com, sparclinux@vger.kernel.org,
        davem@davemloft.net, catalin.marinas@arm.com,
        linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org,
        ak@linux.intel.com, dave.hansen@intel.com,
        kirill.shutemov@linux.intel.com
Subject: Re: [PATCH 0/5] perf/mm: Fix PERF_SAMPLE_*_PAGE_SIZE
Message-ID: <20201116155404.GD29991@casper.infradead.org>
References: <20201113111901.743573013@infradead.org>
 <20201116154357.bw64c5ie2kiu5l4x@box>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201116154357.bw64c5ie2kiu5l4x@box>
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Mon, Nov 16, 2020 at 06:43:57PM +0300, Kirill A. Shutemov wrote:
> On Fri, Nov 13, 2020 at 12:19:01PM +0100, Peter Zijlstra wrote:
> > Hi,
> > 
> > These patches provide generic infrastructure to determine TLB page size from
> > page table entries alone. Perf will use this (for either data or code address)
> > to aid in profiling TLB issues.
> 
> I'm not sure it's an issue, but strictly speaking, size of page according
> to page table tree doesn't mean pagewalk would fill TLB entry of the size.
> CPU may support 1G pages in page table tree without 1G TLB at all.
> 
> IIRC, current Intel CPU still don't have any 1G iTLB entries and fill 2M
> iTLB instead.

It gets even more complicated with CPUs with multiple levels of TLB
which support different TLB entry sizes.  My CPU reports:

TLB info
 Instruction TLB: 2M/4M pages, fully associative, 8 entries
 Instruction TLB: 4K pages, 8-way associative, 64 entries
 Data TLB: 1GB pages, 4-way set associative, 4 entries
 Data TLB: 4KB pages, 4-way associative, 64 entries
 Shared L2 TLB: 4KB/2MB pages, 6-way associative, 1536 entries

I'm not quite sure what the rules are for evicting a 1GB entry in the
dTLB into the s2TLB.  I've read them for so many different processors,
I get quite confused.  Some CPUs fracture them; others ditch them entirely
and will look them up again if needed.

I think the architecture here is fine, but it'll need a little bit of
finagling to maybe pass i-vs-d to the pXd_leaf_size() routines, and x86
will need an implementation of pud_leaf_size() which interrogates the
TLB info to find out what size TLB entry will actually be used.
