From: Vineet Gupta <Vineet.Gupta1@synopsys.com>
Subject: Re: [arc-linux-dev] [PATCH v2 0/8] ARCv2 port to Linux - (C) perf
Date: Fri, 14 Aug 2015 07:41:22 +0000
Message-ID: <C2D7FE5348E1B147BCA15975FBA23075665B2BD5@IN01WEMBXB.internal.synopsys.com>
References: <1438787614-14074-1-git-send-email-abrodkin@synopsys.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from us01smtprelay-2.synopsys.com ([198.182.47.9]:32843 "EHLO
	smtprelay.synopsys.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752126AbbHNHl1 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Fri, 14 Aug 2015 03:41:27 -0400
Content-Language: en-US
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: "peterz@infradead.org" <peterz@infradead.org>
Cc: "arc-linux-dev@synopsys.com" <arc-linux-dev@synopsys.com>, "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Alexey Brodkin <Alexey.Brodkin@synopsys.com>

On Wednesday 05 August 2015 08:44 PM, Alexey Brodkin wrote:
> Hi Peter,
>
> This mini-series adds perf support for ARCv2 based cores, which brings in
> overflow interupts and SMP. Additionally now raw events are supported as well.
>
> Please review !
>
> Compared to v1 this series has:
>  [1] Addressed review comments
>  [2] More verbose commit messages and comments in sources
>  [3] Minor cosmetics
>
> Thanks,
> Alexey

Hi Peter,

Can u please skim thru these any time soon. Merge window is drawing nearer and it
would be nice to have perf for ARCv2 based cores in there.

Thx,
-Vineet
