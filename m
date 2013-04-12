From: Chris Metcalf <cmetcalf@tilera.com>
Subject: Re: [PATCH v4, part3 36/41] mm/tile: prepare for removing num_physpages
 and simplify mem_init()
Date: Fri, 12 Apr 2013 16:56:24 -0400
Message-ID: <516874F8.6030907@tilera.com>
References: <1365258760-30821-1-git-send-email-jiang.liu@huawei.com> <1365258760-30821-37-git-send-email-jiang.liu@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from usmamail.tilera.com ([12.216.194.151]:46958 "EHLO
	USMAMAIL.TILERA.COM" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755109Ab3DLU4Z (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Fri, 12 Apr 2013 16:56:25 -0400
In-Reply-To: <1365258760-30821-37-git-send-email-jiang.liu@huawei.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Jiang Liu <liuj97@gmail.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, Jiang Liu <jiang.liu@huawei.com>, David Rientjes <rientjes@google.com>, Wen Congyang <wency@cn.fujitsu.com>, Mel Gorman <mgorman@suse.de>, Minchan Kim <minchan@kernel.org>, KAMEZAWA Hiroyuki <kamezawa.hiroyu@jp.fujitsu.com>, Michal Hocko <mhocko@suse.cz>, James Bottomley <James.Bottomley@HansenPartnership.com>, Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>, David Howells <dhowells@redhat.com>, Mark Salter <msalter@redhat.com>, Jianguo Wu <wujianguo@huawei.com>, linux-mm@kvack.org, linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>, "David S. Miller" <davem@davemloft.net>

On 4/6/2013 10:32 AM, Jiang Liu wrote:
> Prepare for removing num_physpages and simplify mem_init().
>
> Signed-off-by: Jiang Liu <jiang.liu@huawei.com>
> Cc: Chris Metcalf <cmetcalf@tilera.com>
> Cc: Bjorn Helgaas <bhelgaas@google.com>
> Cc: "David S. Miller" <davem@davemloft.net>
> Cc: Wen Congyang <wency@cn.fujitsu.com>
> Cc: linux-kernel@vger.kernel.org
> ---
>  arch/tile/kernel/setup.c |   16 ++++++++--------
>  arch/tile/mm/init.c      |   15 +--------------
>  2 files changed, 9 insertions(+), 22 deletions(-)

Acked-by: Chris Metcalf <cmetcalf@tilera.com>

-- 
Chris Metcalf, Tilera Corp.
http://www.tilera.com
