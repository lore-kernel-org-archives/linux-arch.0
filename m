From: Jiang Liu <liuj97@gmail.com>
Subject: [PATCH, v2 0/5] clean stale VALID_PAGE() related code and comments
Date: Wed, 29 May 2013 23:08:51 +0800
Message-ID: <1369840136-1491-1-git-send-email-jiang.liu@huawei.com>
Return-path: <owner-linux-mm@kvack.org>
Sender: owner-linux-mm@kvack.org
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Jiang Liu <jiang.liu@huawei.com>, David Rientjes <rientjes@google.com>, Wen Congyang <wency@cn.fujitsu.com>, Mel Gorman <mgorman@suse.de>, Minchan Kim <minchan@kernel.org>, KAMEZAWA Hiroyuki <kamezawa.hiroyu@jp.fujitsu.com>, Michal Hocko <mhocko@suse.cz>, James Bottomley <James.Bottomley@HansenPartnership.com>, Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>, David Howells <dhowells@redhat.com>, Mark Salter <msalter@redhat.com>, Jianguo Wu <wujianguo@huawei.com>, linux-mm@kvack.org, linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-arch.vger.kernel.org

This is a trivial patchset to remove stale VALID_PAGE() related code
and comments.

It applies on top of:
git://git.cmpxchg.org/linux-mmotm.git v3.10-rc2-mmotm-2013-05-22-16-40

Jiang Liu (5):
  mm/ALPHA: clean up unused VALID_PAGE()
  mm/ARM: fix stale comment about VALID_PAGE()
  mm/CRIS: clean up unused VALID_PAGE()
  mm/microblaze: clean up unused VALID_PAGE()
  mm/unicore32: fix stale comment about VALID_PAGE()

 arch/alpha/include/asm/mmzone.h     | 2 --
 arch/arm/include/asm/memory.h       | 6 ------
 arch/cris/include/asm/page.h        | 1 -
 arch/microblaze/include/asm/page.h  | 1 -
 arch/unicore32/include/asm/memory.h | 6 ------
 5 files changed, 16 deletions(-)

-- 
1.8.1.2

--
To unsubscribe, send a message with 'unsubscribe linux-mm' in
the body to majordomo@kvack.org.  For more info on Linux MM,
see: http://www.linux-mm.org/ .
Don't email: <a href=mailto:"dont@kvack.org"> email@kvack.org </a>
