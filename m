Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from shards.monkeyblade.net ([184.105.139.130]:46908 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753407AbcHVX5O (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 22 Aug 2016 19:57:14 -0400
Date: Mon, 22 Aug 2016 16:57:10 -0700 (PDT)
Message-ID: <20160822.165710.1114970253560467646.davem@davemloft.net>
Subject: Re: [PATCH] ARC: uaccess: get_user to zero out dest in cause of
 fault
From: David Miller <davem@davemloft.net>
In-Reply-To: <CA+55aFzsk220hcPXpdsDN_jWhYHqf-zkyN=BxmvfK9q_jp6W4A@mail.gmail.com>
References: <CA+55aFzKkVDuizFBH66s8n0u=1FRSXGPNKun9G8rFHaXw5Lx4w@mail.gmail.com>
        <20F4A326-4107-452C-AF84-385136D9501F@zytor.com>
        <CA+55aFzsk220hcPXpdsDN_jWhYHqf-zkyN=BxmvfK9q_jp6W4A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: torvalds@linux-foundation.org
Cc: hpa@zytor.com, viro@zeniv.linux.org.uk, jakub@redhat.com, Vineet.Gupta1@synopsys.com, linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org, mingo@redhat.com
Message-ID: <20160822235710.5zSANkh0_pPk9F5bGbL9UygnQH0iFpxjDpLLY3Gim1A@z>

From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Mon, 22 Aug 2016 16:48:00 -0700

> How new is it? The whole point was that we'd not have to worry and
> wait for gcc features..

It's been around for a long time.

I'd say at least gcc-3.0 and later support it.
