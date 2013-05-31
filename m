From: Jiang Liu <liuj97@gmail.com>
Subject: Re: [PATCH v8, part3 06/14] mm, acornfb: use free_reserved_area()
 to simplify code
Date: Fri, 31 May 2013 12:31:15 +0800
Message-ID: <51A82793.4080204@gmail.com>
References: <1369575522-26405-1-git-send-email-jiang.liu@huawei.com> <1369575522-26405-7-git-send-email-jiang.liu@huawei.com> <20130530145844.902b3a947c1f7430c1c2ecf5@linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <owner-linux-mm@kvack.org>
In-Reply-To: <20130530145844.902b3a947c1f7430c1c2ecf5@linux-foundation.org>
Sender: owner-linux-mm@kvack.org
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Jiang Liu <jiang.liu@huawei.com>, David Rientjes <rientjes@google.com>, Wen Congyang <wency@cn.fujitsu.com>, Mel Gorman <mgorman@suse.de>, Minchan Kim <minchan@kernel.org>, KAMEZAWA Hiroyuki <kamezawa.hiroyu@jp.fujitsu.com>, Michal Hocko <mhocko@suse.cz>, James Bottomley <james.bottomley@hansenpartnership.com>, Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>, David Howells <dhowells@redhat.com>, Mark Salter <msalter@redhat.com>, Jianguo Wu <wujianguo@huawei.com>, linux-mm@kvack.org, linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org, Florian Tobias Schandinat <florianschandinat@gmx.de>, linux-fbdev@vger.kernel.org
List-Id: linux-arch.vger.kernel.org

On Fri 31 May 2013 05:58:44 AM CST, Andrew Morton wrote:
> On Sun, 26 May 2013 21:38:34 +0800 Jiang Liu <liuj97@gmail.com> wrote:
>
>> Use common help function free_reserved_area() to simplify code.
>
> http://ozlabs.org/~akpm/mmots/broken-out/drivers-video-acornfbc-remove-dead-code.patch
> removes all the code which your patch alters.
Thanks Andrew, please just drop that patch.

--
To unsubscribe, send a message with 'unsubscribe linux-mm' in
the body to majordomo@kvack.org.  For more info on Linux MM,
see: http://www.linux-mm.org/ .
Don't email: <a href=mailto:"dont@kvack.org"> email@kvack.org </a>
