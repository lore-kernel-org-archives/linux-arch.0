Return-Path: <linux-arch-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01401C47082
	for <linux-arch@archiver.kernel.org>; Mon,  7 Jun 2021 23:52:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DB2EB61182
	for <linux-arch@archiver.kernel.org>; Mon,  7 Jun 2021 23:52:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230377AbhFGXys (ORCPT <rfc822;linux-arch@archiver.kernel.org>);
        Mon, 7 Jun 2021 19:54:48 -0400
Received: from mail.kernel.org ([198.145.29.99]:41162 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230344AbhFGXyr (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Mon, 7 Jun 2021 19:54:47 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 59258610E7;
        Mon,  7 Jun 2021 23:52:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1623109962;
        bh=gZ7ag71htLxjG6QOcoLqIDfNOCltH8Ce826lm+nq7yM=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=O3jUTkfKWL4/blrQFYIsKvIZXWutsz+IbZFBx+OVxX9C2UQpizZpg4Mf4DQHbaXj8
         8cqwH3XTcwDDzYwhWy9hqH54zSYylz7VJJe6W4x1eGUyFYf47lIimqT0I17baYB21n
         nyCuxTJPuapCk7QNLUVbTOyDs2dwXq0vw1HBGbGQ=
Date:   Mon, 7 Jun 2021 16:52:41 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Nicholas Piggin <npiggin@gmail.com>
Cc:     Randy Dunlap <rdunlap@infradead.org>, linux-kernel@vger.kernel.org,
        linux-arch@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        linux-mm@kvack.org, Anton Blanchard <anton@ozlabs.org>,
        Andy Lutomirski <luto@kernel.org>
Subject: Re: [PATCH v4 4/4] powerpc/64s: enable MMU_LAZY_TLB_SHOOTDOWN
Message-Id: <20210607165241.4dcd4cf63f96437c5650d179@linux-foundation.org>
In-Reply-To: <20210605014216.446867-5-npiggin@gmail.com>
References: <20210605014216.446867-1-npiggin@gmail.com>
        <20210605014216.446867-5-npiggin@gmail.com>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Sat,  5 Jun 2021 11:42:16 +1000 Nicholas Piggin <npiggin@gmail.com> wrote:

> On a 16-socket 192-core POWER8 system, a context switching benchmark
> with as many software threads as CPUs (so each switch will go in and
> out of idle), upstream can achieve a rate of about 1 million context
> switches per second. After this patch it goes up to 118 million.

Nice.  Do we have a feel for the benefit on any real-world workloads?

Could any other architectures benefit from these changes?
