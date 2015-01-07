From: Vineet Gupta <Vineet.Gupta1@synopsys.com>
Subject: Re: [PATCH 0/5] Perf fixes for ARC + uClibc
Date: Wed, 7 Jan 2015 07:38:47 +0000
Message-ID: <C2D7FE5348E1B147BCA15975FBA2307565BCA4D7@IN01WEMBXA.internal.synopsys.com>
References: <1420552335-26886-1-git-send-email-vgupta@synopsys.com>
 <20150106151329.GD2517@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from smtprelay.synopsys.com ([198.182.47.9]:39815 "EHLO
	smtprelay.synopsys.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755212AbbAGHix convert rfc822-to-8bit (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Wed, 7 Jan 2015 02:38:53 -0500
Content-Language: en-US
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Arnaldo Carvalho de Melo <acme@redhat.com>
Cc: "peterz@infradead.org" <peterz@infradead.org>, "jolsa@kernel.org" <jolsa@kernel.org>, "mingo@kernel.org" <mingo@kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-perf-users@vger.kernel.org" <linux-perf-users@vger.kernel.org>, "bp@suse.de" <bp@suse.de>, "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>, "Alexey.Brodkin@synopsys.com" <Alexey.Brodkin@synopsys.com>

On Tuesday 06 January 2015 08:43 PM, Arnaldo Carvalho de Melo wrote:

Em Tue, Jan 06, 2015 at 07:22:10PM +0530, Vineet Gupta escreveu:


> Hi,
>
> This series based off linux-next of 20150105 allows us to build/use perf
> for ARC with uClibc based userland.


Do you have some ready made ARC VM image with devel tools I could use with qemu?

- Arnaldo



FWIW, most of the issues I posted fixes for can be reproduced with building perf with ARC buildroot !

git://github.com:foss-for-synopsys-dwc-arc-processors/buildroot.git

Thx,
-Vineet
