From: Vineet Gupta <Vineet.Gupta1@synopsys.com>
Subject: Re: [PATCH 00/19] ARCv2 port to Linux - (A) prepratory patches
Date: Sun, 7 Jun 2015 08:47:59 +0000
Message-ID: <C2D7FE5348E1B147BCA15975FBA23075665A44F3@IN01WEMBXB.internal.synopsys.com>
References: <1433666303-26112-1-git-send-email-vgupta@synopsys.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from us01smtprelay-2.synopsys.com ([198.182.47.9]:56959 "EHLO
	smtprelay.synopsys.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751583AbbFGIsE convert rfc822-to-8bit (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Sun, 7 Jun 2015 04:48:04 -0400
Content-Language: en-US
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "arc-linux-dev@synopsys.com" <arc-linux-dev@synopsys.com>

On Sunday 07 June 2015 02:08 PM, Vineet Gupta wrote:
> Hi,
>
> ARCv2 is the next generation ISA from Synopsys and basis for the
> HS3{4,6,8} families of processors which retain the traditional ARC mantra of
> low power and configurability and are now more performant and feature rich.
>
> Linux has been ported to HS38x series, a 10 stage pipeline core which
> supports MMU (with huge pages) and SMP (upto 4 cores) among other features.
>
>  - www.synopsys.com/dw/ipdir.php?ds=arc-hs38-processor
>  - http://news.synopsys.com/2014-10-14-New-DesignWare-ARC-HS38-Processor-Doubles-Performance-for-Embedded-Linux-Applications
>  - http://www.embedded.com/electronics-news/4435975/Synopsys-ARC-HS38-core-gives-2X-boost-to-Linux-based-apps
>
> This sub-series introduces changes to existing in-tree port of ARC700 core
> (based on ARCompact ISA) to allow for better code sharing with new ARCv2 code.
>
> The actual ARCv2 port will follow as a seperate series.
>
> Please review !

The complete code is also available in git tree

git://git.kernel.org/pub/scm/linux/kernel/git/vgupta/arc.git  # for-HS-upstream

Thx,
-Vineet
