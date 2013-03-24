Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.126.187]:63171 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754367Ab3CXJt0 (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Sun, 24 Mar 2013 05:49:26 -0400
From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [RFC PATCH v2, part4 01/39] vmlinux.lds: add comments for global variables and clean up useless declarations
Date: Sun, 24 Mar 2013 09:47:41 +0000
References: <1364109934-7851-1-git-send-email-jiang.liu@huawei.com> <1364109934-7851-2-git-send-email-jiang.liu@huawei.com>
In-Reply-To: <1364109934-7851-2-git-send-email-jiang.liu@huawei.com>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Message-ID: <201303240947.42085.arnd@arndb.de>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Jiang Liu <liuj97@gmail.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, David Rientjes <rientjes@google.com>, Jiang Liu <jiang.liu@huawei.com>, Wen Congyang <wency@cn.fujitsu.com>, Mel Gorman <mgorman@suse.de>, Minchan Kim <minchan@kernel.org>, KAMEZAWA Hiroyuki <kamezawa.hiroyu@jp.fujitsu.com>, Michal Hocko <mhocko@suse.cz>, Jianguo Wu <wujianguo@huawei.com>, linux-mm@kvack.org, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org
Message-ID: <20130324094741.6YU1CA181GYm8Lm5gLLzyk5vOirASo2_dWZvFWFSuks@z>

On Sunday 24 March 2013, Jiang Liu wrote:
> This patch documents global variables exported from vmlinux.lds.
> 1) Add comments about usage guidelines for global variables exported
>    from vmlinux.lds.S.
> 2) Remove unused __initdata_begin[] and __initdata_end[].
> 
> Signed-off-by: Jiang Liu <jiang.liu@huawei.com>
> Cc: Arnd Bergmann <arnd@arndb.de>
> Cc: linux-arch@vger.kernel.org
> Cc: linux-kernel@vger.kernel.org
> ---
>  include/asm-generic/sections.h |   21 ++++++++++++++++++++-
>  1 file changed, 20 insertions(+), 1 deletion(-)

for asm-generic:

Acked-by: Arnd Bergmann <arnd@arndb.de>
