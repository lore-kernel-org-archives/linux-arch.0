Return-Path: <linux-arch-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 903A0C433EF
	for <linux-arch@archiver.kernel.org>; Tue, 12 Oct 2021 08:59:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 76AB86101D
	for <linux-arch@archiver.kernel.org>; Tue, 12 Oct 2021 08:59:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235061AbhJLJBW (ORCPT <rfc822;linux-arch@archiver.kernel.org>);
        Tue, 12 Oct 2021 05:01:22 -0400
Received: from verein.lst.de ([213.95.11.211]:40590 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232578AbhJLJBV (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Tue, 12 Oct 2021 05:01:21 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id B4F5B68AFE; Tue, 12 Oct 2021 10:59:16 +0200 (CEST)
Date:   Tue, 12 Oct 2021 10:59:15 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Ramji Jiyani <ramjiyani@google.com>
Cc:     arnd@arndb.de, viro@zeniv.linux.org.uk, bcrl@kvack.org, hch@lst.de,
        kernel-team@android.com, linux-aio@kvack.org,
        linux-arch@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, oleg@redhat.com, ebiggers@kernel.org,
        Jeff Moyer <jmoyer@redhat.com>, stable@vger.kernel.org
Subject: Re: [PATCH v4] aio: Add support for the POLLFREE
Message-ID: <20211012085915.GA25069@lst.de>
References: <20211007002507.42501-1-ramjiyani@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211007002507.42501-1-ramjiyani@google.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Looks good,

Reviewed-by: Christoph Hellwig <hch@lst.de>
