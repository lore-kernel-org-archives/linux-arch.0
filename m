Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail-pd0-f171.google.com ([209.85.192.171]:49081 "EHLO
	mail-pd0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750962AbbAJKpI (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Sat, 10 Jan 2015 05:45:08 -0500
Date: Sat, 10 Jan 2015 19:44:58 +0900
From: Namhyung Kim <namhyung@kernel.org>
Subject: Re: [PATCH 4/5] perf tools: [uclibc] don't rely on glibc malloc
 working for sz 0
Message-ID: <20150110104458.GC29697@danjae>
References: <1420552335-26886-1-git-send-email-vgupta@synopsys.com>
 <1420552335-26886-5-git-send-email-vgupta@synopsys.com>
 <20150108075125.GF7268@sejong>
 <C2D7FE5348E1B147BCA15975FBA2307565BCA731@IN01WEMBXA.internal.synopsys.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <C2D7FE5348E1B147BCA15975FBA2307565BCA731@IN01WEMBXA.internal.synopsys.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Vineet Gupta <Vineet.Gupta1@synopsys.com>
Cc: "acme@redhat.com" <acme@redhat.com>, "peterz@infradead.org" <peterz@infradead.org>, "jolsa@kernel.org" <jolsa@kernel.org>, "mingo@kernel.org" <mingo@kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-perf-users@vger.kernel.org" <linux-perf-users@vger.kernel.org>, "bp@suse.de" <bp@suse.de>, "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>, "Alexey.Brodkin@synopsys.com" <Alexey.Brodkin@synopsys.com>
Message-ID: <20150110104458.B1jDdzp0BELr2GLfZpFky7YV61tSD8xuAuz1ZtAk2hQ@z>

On Sat, Jan 10, 2015 at 10:16:06AM +0000, Vineet Gupta wrote:
> On Thursday 08 January 2015 01:23 PM, Namhyung Kim wrote:
> > Hmm.. okay.  I think we don't need to allocate the id arrays when size
> > is 0.  So perf_event__process_attr() will have the same problem IMHO.
> > How about this?
> >
> >
> > diff --git a/tools/perf/util/evsel.c b/tools/perf/util/evsel.c
> > index 1e90c8557ede..1d826d63bc20 100644
> > --- a/tools/perf/util/evsel.c
> > +++ b/tools/perf/util/evsel.c
> > @@ -797,6 +797,9 @@ int perf_evsel__enable(struct perf_evsel *evsel, int ncpus, int nthreads)
> >  
> >  int perf_evsel__alloc_id(struct perf_evsel *evsel, int ncpus, int nthreads)
> >  {
> > +	if (ncpus == 0 || nthreads == 0)
> > +		return 0;
> > +
> >  	if (evsel->system_wide)
> >  		nthreads = 1;
> 
> Fine by me as I'm not too familiar with perf tools internals.
> So I need to spin a v2 for this or would you rather create a patch with me as
> Reported-by:

Please include this in your v2 and adds me as Suggested-by:

Thanks,
Namhyung
