Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail-pa0-f52.google.com ([209.85.220.52]:37477 "EHLO
	mail-pa0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756008Ab3EHPxz (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Wed, 8 May 2013 11:53:55 -0400
From: Jiang Liu <liuj97@gmail.com>
Subject: [PATCH v5, part4 05/41] score: normalize global variables exported by vmlinux.lds
Date: Wed,  8 May 2013 23:51:02 +0800
Message-ID: <1368028298-7401-6-git-send-email-jiang.liu@huawei.com>
In-Reply-To: <1368028298-7401-1-git-send-email-jiang.liu@huawei.com>
References: <1368028298-7401-1-git-send-email-jiang.liu@huawei.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Jiang Liu <jiang.liu@huawei.com>, David Rientjes <rientjes@google.com>, Wen Congyang <wency@cn.fujitsu.com>, Mel Gorman <mgorman@suse.de>, Minchan Kim <minchan@kernel.org>, KAMEZAWA Hiroyuki <kamezawa.hiroyu@jp.fujitsu.com>, Michal Hocko <mhocko@suse.cz>, James Bottomley <James.Bottomley@HansenPartnership.com>, Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>, David Howells <dhowells@redhat.com>, Mark Salter <msalter@redhat.com>, Jianguo Wu <wujianguo@huawei.com>, linux-mm@kvack.org, linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org, Chen Liqin <liqin.chen@sunplusct.com>, Lennox Wu <lennox.wu@gmail.com>
Message-ID: <20130508155102.N1m4k7u1lCjFe2t2FNIoF82R_LgbMd0NPo2OSa9PQdg@z>

Generate mandatory global variables _sdata in file vmlinux.lds.

Signed-off-by: Jiang Liu <jiang.liu@huawei.com>
Cc: Chen Liqin <liqin.chen@sunplusct.com>
Cc: Lennox Wu <lennox.wu@gmail.com>
Cc: linux-kernel@vger.kernel.org
---
 arch/score/kernel/vmlinux.lds.S |    1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/score/kernel/vmlinux.lds.S b/arch/score/kernel/vmlinux.lds.S
index eebcbaa..7274b5c 100644
--- a/arch/score/kernel/vmlinux.lds.S
+++ b/arch/score/kernel/vmlinux.lds.S
@@ -49,6 +49,7 @@ SECTIONS
 	}
 
 	. = ALIGN(16);
+	_sdata =  .;			/* Start of data section */
 	RODATA
 
 	EXCEPTION_TABLE(16)
-- 
1.7.9.5

