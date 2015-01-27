From: Vineet Gupta <Vineet.Gupta1@synopsys.com>
Subject: Re: [PATCH v3 0/5] Perf tool fixes for ARC + uClibc
Date: Tue, 27 Jan 2015 15:59:59 +0530
Message-ID: <54C768A7.8020505@synopsys.com>
References: <1421156604-30603-1-git-send-email-vgupta@synopsys.com> <20150114120000.GB11443@krava.brq.redhat.com> <20150114135930.GA2463@redhat.com> <54BC897C.7070309@synopsys.com> <20150119135843.GA2276@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from smtprelay.synopsys.com ([198.182.60.111]:39422 "EHLO
	smtprelay.synopsys.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752154AbbA0KaU (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Tue, 27 Jan 2015 05:30:20 -0500
In-Reply-To: <20150119135843.GA2276@redhat.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Arnaldo Carvalho de Melo <acme@redhat.com>
Cc: Jiri Olsa <jolsa@redhat.com>, namhyung@kernel.org, jolsa@kernel.org, peterz@infradead.org, mingo@kernel.org, linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, linux-arch@vger.kernel.org, Alexey.Brodkin@synopsys.com

Hi Arnaldo,

On Monday 19 January 2015 07:28 PM, Arnaldo Carvalho de Melo wrote:
>>>>> Acked-by: Jiri Olsa <jolsa@kernel.org>
>>> > > Most are already in my perf/urgent branch.
>> > Are you planning to add {4,5}/5 for next window or did u drop/miss them ?
> I will, IIRC those were not that trivial, so could wait, I'll make sure
> I review them and merge for perf/core if I find no issues.

Sorry for annoying pestering on this. I don't see the patches in ur perf/core yet
and given that we are so close to next window, I fear that we will miss them if we
don't add them soon.

We need them to be able to use perf on ARC - fixing build issue (5/5) as well as
run time issue (4/5)

Thx,
-Vineet
