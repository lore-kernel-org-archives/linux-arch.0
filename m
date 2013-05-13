Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:42836 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750830Ab3EMJma (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Mon, 13 May 2013 05:42:30 -0400
From: David Howells <dhowells@redhat.com>
In-Reply-To: <1368293689-16410-3-git-send-email-jiang.liu@huawei.com>
References: <1368293689-16410-3-git-send-email-jiang.liu@huawei.com> <1368293689-16410-1-git-send-email-jiang.liu@huawei.com>
Subject: Re: [PATCH v6, part3 02/16] mm: enhance free_reserved_area() to support poisoning memory with zero
Date: Mon, 13 May 2013 10:41:17 +0100
Message-ID: <15961.1368438077@warthog.procyon.org.uk>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Jiang Liu <liuj97@gmail.com>
Cc: dhowells@redhat.com, Andrew Morton <akpm@linux-foundation.org>, Jiang Liu <jiang.liu@huawei.com>, David Rientjes <rientjes@google.com>, Wen Congyang <wency@cn.fujitsu.com>, Mel Gorman <mgorman@suse.de>, Minchan Kim <minchan@kernel.org>, KAMEZAWA Hiroyuki <kamezawa.hiroyu@jp.fujitsu.com>, Michal Hocko <mhocko@suse.cz>, James Bottomley <James.Bottomley@HansenPartnership.com>, Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>, Mark Salter <msalter@redhat.com>, Jianguo Wu <wujianguo@huawei.com>, linux-mm@kvack.org, linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org, Geert Uytterhoeven <geert@linux-m68k.org>
Message-ID: <20130513094117.djHG6tMUya4zNIMUyAY7FSotVMfCrR8XSMdNMs1YqE8@z>

Jiang Liu <liuj97@gmail.com> wrote:

> +	free_reserved_area((void *)start, (void *)end, -1, "initrd");

Do you mean -1 or ULONG_MAX?

David
