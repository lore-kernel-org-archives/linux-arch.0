Return-Path: <linux-arch-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05484C48BC2
	for <linux-arch@archiver.kernel.org>; Mon, 28 Jun 2021 01:12:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D4CFB61A1D
	for <linux-arch@archiver.kernel.org>; Mon, 28 Jun 2021 01:12:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231873AbhF1BOx (ORCPT <rfc822;linux-arch@archiver.kernel.org>);
        Sun, 27 Jun 2021 21:14:53 -0400
Received: from mail.kernel.org ([198.145.29.99]:36190 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231706AbhF1BOx (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Sun, 27 Jun 2021 21:14:53 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 3DC08619C5;
        Mon, 28 Jun 2021 01:12:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1624842747;
        bh=jHVvl6fcFfg+IVQ3lBpd7cBJiC21/SiQ2M2n/J/aDeQ=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=aus9ryL+DgdKH4ZNAJ5wqeFEe6w9+xkQn3TmuhatvYPqjRvTfTCqQsNQm3nJrmYD/
         X3DX2v1FqasZlVOaBS1sW/lXxvheF8cEwJVuOjRQZm7cTjQNhBT3i/tCFbtBeIq3yj
         bupVyrvJDARUQXHC8Ly6sHJgcxIsv6qUTNCdNM7w=
Date:   Sun, 27 Jun 2021 18:12:26 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Christophe Leroy <christophe.leroy@csgroup.eu>
Cc:     Steven Price <steven.price@arm.com>, linux-mm@kvack.org,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>, dja@axtens.net,
        "Oliver O'Halloran" <oohall@gmail.com>, linux-arch@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] mm: pagewalk: Fix walk for hugepage tables
Message-Id: <20210627181226.983d899cc30c02420e1a6af5@linux-foundation.org>
In-Reply-To: <38d04410700c8d02f28ba37e020b62c55d6f3d2c.1624597695.git.christophe.leroy@csgroup.eu>
References: <38d04410700c8d02f28ba37e020b62c55d6f3d2c.1624597695.git.christophe.leroy@csgroup.eu>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Fri, 25 Jun 2021 05:10:12 +0000 (UTC) Christophe Leroy <christophe.leroy@csgroup.eu> wrote:

> Pagewalk ignores hugepd entries and walk down the tables
> as if it was traditionnal entries, leading to crazy result.
> 
> Add walk_hugepd_range() and use it to walk hugepage tables.

More details, please?  I assume "crazy result" is userspace visible? 
For how long has this bug existed?  Is a -stable backport needed?  Has
a Fixes: commit been identified?  etcetera!
