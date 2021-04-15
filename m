Return-Path: <linux-arch-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5D5DC433B4
	for <linux-arch@archiver.kernel.org>; Thu, 15 Apr 2021 18:55:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 90C08610F7
	for <linux-arch@archiver.kernel.org>; Thu, 15 Apr 2021 18:55:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234640AbhDOSz5 (ORCPT <rfc822;linux-arch@archiver.kernel.org>);
        Thu, 15 Apr 2021 14:55:57 -0400
Received: from mail.kernel.org ([198.145.29.99]:48302 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234101AbhDOSzx (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Thu, 15 Apr 2021 14:55:53 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id B112961152;
        Thu, 15 Apr 2021 18:55:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1618512930;
        bh=tAQpTOBvkJ3hO9SBP+PvxFjqv3ZJBkP6NKwXUOWSDMQ=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=HNXlP42LpU+p8j7cbvKDbs0kNEL4K3d+jo0sxGNF5GAA1tEMwmLmF9ldGris8qG6T
         UPNLhbgnVGH8C4oOOf+LYW9+B5hMrMsQr/AJg4HXVzgV2yRa7pJo7/rf7X9lVOg68+
         NIrZ+0NCp39XcGwwQZH1V2i2PGLStNBOuQwhRgRw=
Date:   Thu, 15 Apr 2021 11:55:29 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Christophe Leroy <christophe.leroy@csgroup.eu>
Cc:     Nicholas Piggin <npiggin@gmail.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
        Jonathan Cameron <Jonathan.Cameron@Huawei.com>,
        Christoph Hellwig <hch@infradead.org>,
        Rick Edgecombe <rick.p.edgecombe@intel.com>,
        Ding Tianhong <dingtianhong@huawei.com>,
        linuxppc-dev@lists.ozlabs.org,
        Michael Ellerman <mpe@ellerman.id.au>,
        Stephen Rothwell <sfr@canb.auug.org.au>
Subject: Re: [PATCH v13 14/14] powerpc/64s/radix: Enable huge vmalloc
 mappings
Message-Id: <20210415115529.9703ba8e9f7a38dea39efa56@linux-foundation.org>
In-Reply-To: <a5c57276-737d-930b-670c-58dc0c815501@csgroup.eu>
References: <20210317062402.533919-1-npiggin@gmail.com>
        <20210317062402.533919-15-npiggin@gmail.com>
        <a5c57276-737d-930b-670c-58dc0c815501@csgroup.eu>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Thu, 15 Apr 2021 12:23:55 +0200 Christophe Leroy <christophe.leroy@csgroup.eu> wrote:
> > +	 * is done. STRICT_MODULE_RWX may require extra work to support this
> > +	 * too.
> > +	 */
> >   
> > -	return __vmalloc_node_range(size, 1, MODULES_VADDR, MODULES_END, GFP_KERNEL,
> > -				    PAGE_KERNEL_EXEC, VM_FLUSH_RESET_PERMS, NUMA_NO_NODE,
> 
> 
> I think you should add the following in <asm/pgtable.h>
> 
> #ifndef MODULES_VADDR
> #define MODULES_VADDR VMALLOC_START
> #define MODULES_END VMALLOC_END
> #endif
> 
> And leave module_alloc() as is (just removing the enclosing #ifdef MODULES_VADDR and adding the 
> VM_NO_HUGE_VMAP  flag)
> 
> This would minimise the conflits with the changes I did in powerpc/next reported by Stephen R.
> 

I'll drop powerpc-64s-radix-enable-huge-vmalloc-mappings.patch for now,
make life simpler.

Nick, a redo on top of Christophe's changes in linux-next would be best
please.

