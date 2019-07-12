Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from shards.monkeyblade.net ([23.128.96.9]:34452 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727994AbfGLWqI (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 12 Jul 2019 18:46:08 -0400
Date: Fri, 12 Jul 2019 15:46:06 -0700 (PDT)
Message-ID: <20190712.154606.493382088615011132.davem@davemloft.net>
Subject: Re: [PATCH] be2net: fix adapter->big_page_size miscaculation
From: David Miller <davem@davemloft.net>
In-Reply-To: <1562959401-19815-1-git-send-email-cai@lca.pw>
References: <1562959401-19815-1-git-send-email-cai@lca.pw>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: cai@lca.pw
Cc: sathya.perla@broadcom.com, ajit.khaparde@broadcom.com, sriharsha.basavapatna@broadcom.com, somnath.kotur@broadcom.com, arnd@arndb.de, dhowells@redhat.com, hpa@zytor.com, netdev@vger.kernel.org, linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org
Message-ID: <20190712224606.C4hCS6cz2dNMqIdwQDw8VCRq-REDFPG9Umx-K12s76g@z>

From: Qian Cai <cai@lca.pw>
Date: Fri, 12 Jul 2019 15:23:21 -0400

> The commit d66acc39c7ce ("bitops: Optimise get_order()") introduced a
> problem for the be2net driver as "rx_frag_size" could be a module
> parameter that can be changed while loading the module.

Why is this a problem?

> That commit checks __builtin_constant_p() first in get_order() which
> cause "adapter->big_page_size" to be assigned a value based on the
> the default "rx_frag_size" value at the compilation time. It also
> generate a compilation warning,

rx_frag_size is not a constant, therefore the __builtin_constant_p()
test should not pass.

This explanation doesn't seem valid.
