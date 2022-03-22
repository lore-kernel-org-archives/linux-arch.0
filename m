Return-Path: <linux-arch-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81003C433EF
	for <linux-arch@archiver.kernel.org>; Tue, 22 Mar 2022 17:24:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239576AbiCVR0F (ORCPT <rfc822;linux-arch@archiver.kernel.org>);
        Tue, 22 Mar 2022 13:26:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46492 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239572AbiCVR0E (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 22 Mar 2022 13:26:04 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 558373EA95;
        Tue, 22 Mar 2022 10:24:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=qYXsicOZSjgl5ohKK5E1ZuJbpsruLDa/pvOZWrwipTE=; b=DyoOoVdYB6oYCjvrmtRIcgoUpQ
        T0Yvuslgm/EFQM/MuVZIuvEkWDKsaM+yRLbFKOZk8LJHYbSvGyN+zIW6SZGGtlDD+hDQMYnMp/6Zl
        sGSB+zc5HOzQplv+CTNGd6c8cdpHQBZuf0LsnW80ej1BPbVDaOXGJH+jwULH0JeubiUt+nnUszlqc
        9MJlM/YypEag2SAgnF/9LLh83QovEebxI5d4NhK5Zgcl+GfQhA5QTWZpgFco3II6sqPt2Jyc1JwG0
        tT1F8rK5k/UVQPCosWt56otYcw+Y+/11PJTtrfdIX0beKIrO7r0lgRKrD8+e0WqgB/w9UMCits73u
        BqRShRWQ==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nWiFF-00BinQ-3R; Tue, 22 Mar 2022 17:24:33 +0000
Date:   Tue, 22 Mar 2022 10:24:33 -0700
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     Christophe Leroy <christophe.leroy@csgroup.eu>
Cc:     Aaron Tomlin <atomlin@redhat.com>, linux-kernel@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org,
        kgdb-bugreport@lists.sourceforge.net, linux-mm@kvack.org,
        linux-arch@vger.kernel.org, linux-modules@vger.kernel.org
Subject: Re: [PATCH v6 0/6] Allocate module text and data separately
Message-ID: <YjoGUfHa1WgYWiR1@bombadil.infradead.org>
References: <cover.1645607143.git.christophe.leroy@csgroup.eu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1645607143.git.christophe.leroy@csgroup.eu>
Sender: Luis Chamberlain <mcgrof@infradead.org>
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Wed, Feb 23, 2022 at 01:02:10PM +0100, Christophe Leroy wrote:
> This series applies on top of my series "miscellanuous cleanups" v4.

Queued onto modules-testing! BTW I just had to rebase the change
with the kdb changes, it was a trivial change.

  Luis
