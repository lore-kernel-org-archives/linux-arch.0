Return-Path: <SRS0=FX5x=B7=vger.kernel.org=linux-arch-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8196AC433DF
	for <linux-arch@archiver.kernel.org>; Fri, 21 Aug 2020 20:07:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 35D232076E
	for <linux-arch@archiver.kernel.org>; Fri, 21 Aug 2020 20:07:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1598040479;
	bh=ignXh6GswzXrZuZocSxHHQfCSn5EcPz6JCZGg+djnYo=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=LdxYoNvPAxQb4vthmamaVU7dsMVYjXdU45j3PJ1P8AuO77GVHMAzv+21pklNavPEf
	 jPr/sVN6t4i3vbwp8rFb3IksrNcf4UVS9snOUM2ggdYx9GzxuhsBOtPhNgIlTfU0c5
	 dyg7glyaCkZTwitXCYJ0ymKrRSuQ4m3V46zngP0U=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725834AbgHUUH6 (ORCPT <rfc822;linux-arch@archiver.kernel.org>);
        Fri, 21 Aug 2020 16:07:58 -0400
Received: from mail.kernel.org ([198.145.29.99]:47250 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725801AbgHUUH6 (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Fri, 21 Aug 2020 16:07:58 -0400
Received: from localhost.localdomain (c-73-231-172-41.hsd1.ca.comcast.net [73.231.172.41])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9477A20735;
        Fri, 21 Aug 2020 20:07:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1598040478;
        bh=ignXh6GswzXrZuZocSxHHQfCSn5EcPz6JCZGg+djnYo=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=njkQpcRWmyvRGvq8Ez91V2VkE1Zs62ocapcA2kFZe6Cg3jHjvrg/HHMBFU7llUhLq
         pibH5nQ/+1y7fY2Rj6xKk66sjW7+05COtWLKo7FT9ik+mMR+lneY17JFnOY5rRvOSo
         4E2SVYhlV9OdHOnpvUTpJrFSRWD0cVpJMF1873g0=
Date:   Fri, 21 Aug 2020 13:07:57 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Nicholas Piggin <npiggin@gmail.com>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        linux-arch@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        Zefan Li <lizefan@huawei.com>,
        Jonathan Cameron <Jonathan.Cameron@Huawei.com>,
        Christoph Hellwig <hch@infradead.org>,
        Christophe Leroy <christophe.leroy@csgroup.eu>
Subject: Re: [PATCH v6 01/12] mm/vmalloc: fix vmalloc_to_page for huge vmap
 mappings
Message-Id: <20200821130757.289570e4bb491672087d3396@linux-foundation.org>
In-Reply-To: <20200821151216.1005117-2-npiggin@gmail.com>
References: <20200821151216.1005117-1-npiggin@gmail.com>
        <20200821151216.1005117-2-npiggin@gmail.com>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Sat, 22 Aug 2020 01:12:05 +1000 Nicholas Piggin <npiggin@gmail.com> wrote:

> vmalloc_to_page returns NULL for addresses mapped by larger pages[*].
> Whether or not a vmap is huge depends on the architecture details,
> alignments, boot options, etc., which the caller can not be expected
> to know. Therefore HUGE_VMAP is a regression for vmalloc_to_page.

I assume this doesn't matter in current mainline?

If wrong, then what are the user-visible effects and why no cc:stable?

> This change teaches vmalloc_to_page about larger pages, and returns
> the struct page that corresponds to the offset within the large page.
> This makes the API agnostic to mapping implementation details.
