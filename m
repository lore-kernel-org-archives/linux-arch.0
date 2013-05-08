From: Sam Ravnborg <sam@ravnborg.org>
Subject: Re: [PATCH v5, part4 35/41] mm/SPARC: prepare for removing
	num_physpages and simplify mem_init()
Date: Wed, 8 May 2013 21:02:08 +0200
Message-ID: <20130508190208.GA13601@merkur.ravnborg.org>
References: <1368028298-7401-1-git-send-email-jiang.liu@huawei.com> <1368028298-7401-36-git-send-email-jiang.liu@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from smtp.snhosting.dk ([87.238.248.203]:14304 "EHLO
	smtp.domainteam.dk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752243Ab3EHTCL (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Wed, 8 May 2013 15:02:11 -0400
Content-Disposition: inline
In-Reply-To: <1368028298-7401-36-git-send-email-jiang.liu@huawei.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Jiang Liu <liuj97@gmail.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, Jiang Liu <jiang.liu@huawei.com>, David Rientjes <rientjes@google.com>, Wen Congyang <wency@cn.fujitsu.com>, Mel Gorman <mgorman@suse.de>, Minchan Kim <minchan@kernel.org>, KAMEZAWA Hiroyuki <kamezawa.hiroyu@jp.fujitsu.com>, Michal Hocko <mhocko@suse.cz>, James Bottomley <James.Bottomley@HansenPartnership.com>, Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>, David Howells <dhowells@redhat.com>, Mark Salter <msalter@redhat.com>, Jianguo Wu <wujianguo@huawei.com>, linux-mm@kvack.org, linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org, "David S. Miller" <davem@davemloft.net>, Yasuaki Ishimatsu <isimatu.yasuaki@jp.fujitsu.com>, Tang Chen <tangchen@cn.fujitsu.com>, sparclinux@vger.kernel.org

On Wed, May 08, 2013 at 11:51:32PM +0800, Jiang Liu wrote:
> Prepare for removing num_physpages and simplify mem_init().
> 
> Signed-off-by: Jiang Liu <jiang.liu@huawei.com>
> Cc: "David S. Miller" <davem@davemloft.net>
> Cc: Sam Ravnborg <sam@ravnborg.org>
> Cc: Yasuaki Ishimatsu <isimatu.yasuaki@jp.fujitsu.com>
> Cc: Tang Chen <tangchen@cn.fujitsu.com>
> Cc: sparclinux@vger.kernel.org
> Cc: linux-kernel@vger.kernel.org

Acked-by: Sam Ravnborg <sam@ravnborg.org>
