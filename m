Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail-pa0-f53.google.com ([209.85.220.53]:34019 "EHLO
	mail-pa0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752608AbcDSLdD (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Tue, 19 Apr 2016 07:33:03 -0400
Subject: Re: [PATCH] arch/defconfig: remove CONFIG_RESOURCE_COUNTERS
References: <146105442758.18940.2792564159961963110.stgit@zurg>
From: Balbir Singh <bsingharora@gmail.com>
Message-ID: <5716175F.9030001@gmail.com>
Date: Tue, 19 Apr 2016 21:32:47 +1000
MIME-Version: 1.0
In-Reply-To: <146105442758.18940.2792564159961963110.stgit@zurg>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Konstantin Khlebnikov <koct9i@gmail.com>, Andrew Morton <akpm@linux-foundation.org>
Cc: linux-arch@vger.kernel.org, linux-mips@linux-mips.org, linux-am33-list@redhat.com, linux-sh@vger.kernel.org, linux-xtensa@linux-xtensa.org, x86@kernel.org, linux-kernel@vger.kernel.org, linux-mm@kvack.org, linux-arm-kernel@lists.infradead.org
Message-ID: <20160419113247.GAjIJtD7Wgj9jknAysB5wzATTWFfe8HojJF84XJkm2c@z>



On 19/04/16 18:27, Konstantin Khlebnikov wrote:
> This option replaced by PAGE_COUNTER which is selected by MEMCG.
> 
> Signed-off-by: Konstantin Khlebnikov <koct9i@gmail.com>

Acked-by: Balbir Singh <bsingharora@gmail.com>
