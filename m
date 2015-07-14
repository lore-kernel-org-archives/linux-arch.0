From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: Re: "perf record" if BITS_PER_LONG != 64 &&
 !defined(HAVE_SYNC_COMPARE_AND_SWAP_SUPPORT)
Date: Tue, 14 Jul 2015 11:12:12 -0300
Message-ID: <20150714141212.GJ2885@kernel.org>
References: <1436875946.2839.22.camel@synopsys.com>
 <55A5023C.7020907@intel.com>
 <1436878329.2839.26.camel@synopsys.com>
 <55A50875.8060904@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:39866 "EHLO mail.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752069AbbGNOML (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Tue, 14 Jul 2015 10:12:11 -0400
Content-Disposition: inline
In-Reply-To: <55A50875.8060904@intel.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Adrian Hunter <adrian.hunter@intel.com>
Cc: Alexey Brodkin <Alexey.Brodkin@synopsys.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "peterz@infradead.org" <peterz@infradead.org>, "eranian@google.com" <eranian@google.com>, "jolsa@redhat.com" <jolsa@redhat.com>, "Vineet.Gupta1@synopsys.com" <Vineet.Gupta1@synopsys.com>, "namhyung@gmail.com" <namhyung@gmail.com>, "dsahern@gmail.com" <dsahern@gmail.com>, "fweisbec@gmail.com" <fweisbec@gmail.com>, "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>

Em Tue, Jul 14, 2015 at 04:02:45PM +0300, Adrian Hunter escreveu:
> On 14/07/15 15:52, Alexey Brodkin wrote:
> > Thanks a lot for your prompt response.
> > Feel free to add my Tested-by then.
 
> +Arnaldo
 
> Here is one for the urgent queue.

Applied, thanks!

- Arnaldo
