From: Liu Jiang <liuj97@gmail.com>
Subject: Re: [PATCH v5, part4 20/41] mm/h8300: prepare for removing num_physpages
 and simplify mem_init()
Date: Sun, 12 May 2013 23:17:14 +0800
Message-ID: <518FB27A.4070903@gmail.com>
References: <1368028298-7401-1-git-send-email-jiang.liu@huawei.com> <1368028298-7401-21-git-send-email-jiang.liu@huawei.com> <518A7CC0.1010606@cogentembedded.com> <518AA7A0.1020702@cogentembedded.com> <518AE13A.2060204@linux.vnet.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <owner-linux-mm@kvack.org>
In-Reply-To: <518AE13A.2060204@linux.vnet.ibm.com>
Sender: owner-linux-mm@kvack.org
To: Cody P Schafer <cody@linux.vnet.ibm.com>
Cc: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>, Andrew Morton <akpm@linux-foundation.org>, Jiang Liu <jiang.liu@huawei.com>, David Rientjes <rientjes@google.com>, Wen Congyang <wency@cn.fujitsu.com>, Mel Gorman <mgorman@suse.de>, Minchan Kim <minchan@kernel.org>, KAMEZAWA Hiroyuki <kamezawa.hiroyu@jp.fujitsu.com>, Michal Hocko <mhocko@suse.cz>, James Bottomley <James.Bottomley@HansenPartnership.com>, David Howells <dhowells@redhat.com>, Mark Salter <msalter@redhat.com>, Jianguo Wu <wujianguo@huawei.com>, linux-mm@kvack.org, linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org, Yoshinori Sato <ysato@users.sourceforge.jp>, Geert Uytterhoeven <geert@linux-m68k.org>
List-Id: linux-arch.vger.kernel.org

On 05/09/2013 07:35 AM, Cody P Schafer wrote:
> On 05/08/2013 12:29 PM, Sergei Shtylyov wrote:
>>
>>      Although, not necessarily: it also supports CONFIG_DYNAMIC_DEBUG --
>> look at how pr_debug() is defined.
>> So this doesn't seem to be an equivalent change, and I suggest not doing
>> it at all.
>>
>> WBR, Sergei
>
> pr_devel() should get the same behavior: no code emitted unless debug 
> is defined, if it is, output at KERN_DEBUG level.
>
Thanks Cody and Sergei, will use pr_devel() instead in next version.
Gerry

--
To unsubscribe, send a message with 'unsubscribe linux-mm' in
the body to majordomo@kvack.org.  For more info on Linux MM,
see: http://www.linux-mm.org/ .
Don't email: <a href=mailto:"dont@kvack.org"> email@kvack.org </a>
