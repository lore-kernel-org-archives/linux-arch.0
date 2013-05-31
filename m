Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail-pb0-f43.google.com ([209.85.160.43]:45092 "EHLO
	mail-pb0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750873Ab3EaEbU (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Fri, 31 May 2013 00:31:20 -0400
Message-ID: <51A82793.4080204@gmail.com>
Date: Fri, 31 May 2013 12:31:15 +0800
From: Jiang Liu <liuj97@gmail.com>
MIME-Version: 1.0
Subject: Re: [PATCH v8, part3 06/14] mm, acornfb: use free_reserved_area()
 to simplify code
References: <1369575522-26405-1-git-send-email-jiang.liu@huawei.com> <1369575522-26405-7-git-send-email-jiang.liu@huawei.com> <20130530145844.902b3a947c1f7430c1c2ecf5@linux-foundation.org>
In-Reply-To: <20130530145844.902b3a947c1f7430c1c2ecf5@linux-foundation.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Jiang Liu <jiang.liu@huawei.com>, David Rientjes <rientjes@google.com>, Wen Congyang <wency@cn.fujitsu.com>, Mel Gorman <mgorman@suse.de>, Minchan Kim <minchan@kernel.org>, KAMEZAWA Hiroyuki <kamezawa.hiroyu@jp.fujitsu.com>, Michal Hocko <mhocko@suse.cz>, James Bottomley <james.bottomley@hansenpartnership.com>, Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>, David Howells <dhowells@redhat.com>, Mark Salter <msalter@redhat.com>, Jianguo Wu <wujianguo@huawei.com>, linux-mm@kvack.org, linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org, Florian Tobias Schandinat <florianschandinat@gmx.de>, linux-fbdev@vger.kernel.org
Message-ID: <20130531043115.hrV-gMhOhjgNw6nHWHmen6dhAW_X5c94PgIZYoqqes8@z>

On Fri 31 May 2013 05:58:44 AM CST, Andrew Morton wrote:
> On Sun, 26 May 2013 21:38:34 +0800 Jiang Liu <liuj97@gmail.com> wrote:
>
>> Use common help function free_reserved_area() to simplify code.
>
> http://ozlabs.org/~akpm/mmots/broken-out/drivers-video-acornfbc-remove-dead-code.patch
> removes all the code which your patch alters.
Thanks Andrew, please just drop that patch.

