Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from gmmr4.centrum.cz ([46.255.227.253]:40781 "EHLO gmmr4.centrum.cz"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754069Ab3IBKtE (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Mon, 2 Sep 2013 06:49:04 -0400
Subject: =?utf-8?q?Re=3A_=5Bpatch_0=2F7=5D_improve_memcg_oom_killer_robustness_v2?=
Date: Mon, 02 Sep 2013 12:38:02 +0200
From: "azurIt" <azurit@pobox.sk>
References: <1375549200-19110-1-git-send-email-hannes@cmpxchg.org>, <20130803170831.GB23319@cmpxchg.org> <20130830215852.3E5D3D66@pobox.sk>
In-Reply-To: <20130830215852.3E5D3D66@pobox.sk>
MIME-Version: 1.0
Message-ID: <20130902123802.5B8E8CB1@pobox.sk>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: azurIt <azurit@pobox.sk>, =?utf-8?q?Johannes_Weiner?= <hannes@cmpxchg.org>
Cc: =?utf-8?q?Andrew_Morton?= <akpm@linux-foundation.org>, =?utf-8?q?Michal_Hocko?= <mhocko@suse.cz>, =?utf-8?q?David_Rientjes?= <rientjes@google.com>, =?utf-8?q?KAMEZAWA_Hiroyuki?= <kamezawa.hiroyu@jp.fujitsu.com>, =?utf-8?q?KOSAKI_Motohiro?= <kosaki.motohiro@jp.fujitsu.com>, linux-mm@kvack.org, cgroups@vger.kernel.org, x86@kernel.org, linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org
Message-ID: <20130902103802.yWN1bsSo_u-zxlP0P5tHRGChZcvMR_a8xGLuo1UnDAE@z>

>>Hi azur,
>>
>>here is the x86-only rollup of the series for 3.2.
>>
>>Thanks!
>>Johannes
>>---
>
>
>Johannes,
>
>unfortunately, one problem arises: I have (again) cgroup which cannot be deleted :( it's a user who had very high memory usage and was reaching his limit very often. Do you need any info which i can gather now?
>
>azur
>


Now i can definitely confirm that problem is NOT fixed :( it happened again but i don't have any data because i already disabled all debug output.

azur
