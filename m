Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from gmmr5.centrum.cz ([46.255.225.250]:44941 "EHLO gmmr5.centrum.cz"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754361Ab3IPPFq (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Mon, 16 Sep 2013 11:05:46 -0400
Subject: =?utf-8?q?Re=3A_=5Bpatch_0=2F7=5D_improve_memcg_oom_killer_robustness_v2?=
Date: Mon, 16 Sep 2013 17:05:43 +0200
From: "azurIt" <azurit@pobox.sk>
References: <20130911180327.GL856@cmpxchg.org>, <20130911205448.656D9D7C@pobox.sk>, <20130911191150.GN856@cmpxchg.org>, <20130911214118.7CDF2E71@pobox.sk>, <20130911200426.GO856@cmpxchg.org>, <20130914124831.4DD20346@pobox.sk>, <20130916134014.GA3674@dhcp22.suse.cz>, <20130916160119.2E76C2A1@pobox.sk>, <20130916140607.GC3674@dhcp22.suse.cz>, <20130916161316.5113F6E7@pobox.sk> <20130916145744.GE3674@dhcp22.suse.cz>
In-Reply-To: <20130916145744.GE3674@dhcp22.suse.cz>
MIME-Version: 1.0
Message-ID: <20130916170543.77F1ECB4@pobox.sk>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: =?utf-8?q?Michal_Hocko?= <mhocko@suse.cz>
Cc: =?utf-8?q?Johannes_Weiner?= <hannes@cmpxchg.org>, =?utf-8?q?Andrew_Morton?= <akpm@linux-foundation.org>, =?utf-8?q?David_Rientjes?= <rientjes@google.com>, =?utf-8?q?KAMEZAWA_Hiroyuki?= <kamezawa.hiroyu@jp.fujitsu.com>, =?utf-8?q?KOSAKI_Motohiro?= <kosaki.motohiro@jp.fujitsu.com>, linux-mm@kvack.org, cgroups@vger.kernel.org, x86@kernel.org, linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org
Message-ID: <20130916150543.8hakwDmQa3m2s7N_F2YosaFPVvPoEX3nORBSQqO_yAo@z>

> CC: "Johannes Weiner" <hannes@cmpxchg.org>, "Andrew Morton" <akpm@linux-foundation.org>, "David Rientjes" <rientjes@google.com>, "KAMEZAWA Hiroyuki" <kamezawa.hiroyu@jp.fujitsu.com>, "KOSAKI Motohiro" <kosaki.motohiro@jp.fujitsu.com>, linux-mm@kvack.org, cgroups@vger.kernel.org, x86@kernel.org, linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org
>On Mon 16-09-13 16:13:16, azurIt wrote:
>[...]
>> >You can use sysrq+l via serial console to see tasks hogging the CPU or
>> >sysrq+t to see all the existing tasks.
>> 
>> 
>> Doesn't work here, it just prints 'l' resp. 't'.
>
>I am using telnet for accessing my serial consoles exported by
>the multiplicator or KVM and it can send sysrq via ctrl+t (Send
>Break). Check your serial console setup.



I'm using Raritan KVM and i created keyboard macro 'sysrq + l' resp. 'sysrq + t'. I'm also unable to use it on my local PC. Maybe it needs to be enabled somehow?

azur
