Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mout.kundenserver.de ([212.227.126.130]:58279 "EHLO
	mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753054AbcDSK5j (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Tue, 19 Apr 2016 06:57:39 -0400
From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH] arch/defconfig: remove CONFIG_RESOURCE_COUNTERS
Date: Tue, 19 Apr 2016 12:56:55 +0200
Message-ID: <4214150.v1WFzl5UmK@wuerfel>
In-Reply-To: <146105442758.18940.2792564159961963110.stgit@zurg>
References: <146105442758.18940.2792564159961963110.stgit@zurg>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Konstantin Khlebnikov <koct9i@gmail.com>, x86@kernel.org
Cc: Andrew Morton <akpm@linux-foundation.org>, linux-arch@vger.kernel.org, linux-mips@linux-mips.org, linux-am33-list@redhat.com, linux-sh@vger.kernel.org, linux-kernel@vger.kernel.org, linux-mm@kvack.org, linux-arm-kernel@lists.infradead.org
Message-ID: <20160419105655.0GQ3Vku3i4ALra3FiSKDhF1-8heCvRKNFuOtGALt05I@z>

On Tuesday 19 April 2016 11:27:07 Konstantin Khlebnikov wrote:
> This option replaced by PAGE_COUNTER which is selected by MEMCG.
> 
> Signed-off-by: Konstantin Khlebnikov <koct9i@gmail.com>
> 
Acked-by: Arnd Bergmann <arnd@arndb.de>
