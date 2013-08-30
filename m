Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from gmmr1.centrum.cz ([46.255.225.252]:54759 "EHLO gmmr1.centrum.cz"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751616Ab3H3T6z (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Fri, 30 Aug 2013 15:58:55 -0400
Subject: =?utf-8?q?Re=3A_=5Bpatch_0=2F7=5D_improve_memcg_oom_killer_robustness_v2?=
Date: Fri, 30 Aug 2013 21:58:52 +0200
From: "azurIt" <azurit@pobox.sk>
References: <1375549200-19110-1-git-send-email-hannes@cmpxchg.org> <20130803170831.GB23319@cmpxchg.org>
In-Reply-To: <20130803170831.GB23319@cmpxchg.org>
MIME-Version: 1.0
Message-ID: <20130830215852.3E5D3D66@pobox.sk>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: =?utf-8?q?Johannes_Weiner?= <hannes@cmpxchg.org>
Cc: =?utf-8?q?Andrew_Morton?= <akpm@linux-foundation.org>, =?utf-8?q?Michal_Hocko?= <mhocko@suse.cz>, =?utf-8?q?David_Rientjes?= <rientjes@google.com>, =?utf-8?q?KAMEZAWA_Hiroyuki?= <kamezawa.hiroyu@jp.fujitsu.com>, =?utf-8?q?KOSAKI_Motohiro?= <kosaki.motohiro@jp.fujitsu.com>, linux-mm@kvack.org, cgroups@vger.kernel.org, x86@kernel.org, linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org
Message-ID: <20130830195852.Wra05RhqYsHmBZqymZ406FFqWu0Qohj2G3r18qfGe4E@z>

>Hi azur,
>
>here is the x86-only rollup of the series for 3.2.
>
>Thanks!
>Johannes
>---


Johannes,

unfortunately, one problem arises: I have (again) cgroup which cannot be deleted :( it's a user who had very high memory usage and was reaching his limit very often. Do you need any info which i can gather now?

azur
