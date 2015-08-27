From: Alexey Brodkin <Alexey.Brodkin@synopsys.com>
Subject: Re: [arc-linux-dev] Re: [PATCH v3 0/6] ARCv2 port to Linux - (C)
 perf
Date: Thu, 27 Aug 2015 06:58:03 +0000
Message-ID: <1440658683.15478.59.camel@synopsys.com>
References: <1440426023-2792-1-git-send-email-abrodkin@synopsys.com>
	 <1440590824.15478.38.camel@synopsys.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-7"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from us01smtprelay-2.synopsys.com ([198.182.60.111]:56798 "EHLO
	smtprelay.synopsys.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751404AbbH0G6L convert rfc822-to-8bit (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Thu, 27 Aug 2015 02:58:11 -0400
In-Reply-To: <1440590824.15478.38.camel@synopsys.com>
Content-Language: en-US
Content-ID: <C14F64975F7722419BACCC9E44912A68@internal.synopsys.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: "peterz@infradead.org" <peterz@infradead.org>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>, Vineet Gupta <Vineet.Gupta1@synopsys.com>, "arc-linux-dev@synopsys.com" <arc-linux-dev@synopsys.com>

Hi Peter,

On Wed, 2015-08-26 at 12:07 +-0000, Alexey Brodkin wrote:
+AD4- Hi Peter,
+AD4- 
+AD4- On Mon, 2015-08-24 at 17:20 +-0300, Alexey Brodkin wrote:
+AD4- +AD4- Hi Peter,
+AD4- +AD4- 
+AD4- +AD4- This mini-series adds perf support for ARCv2 based cores, which brings in
+AD4- +AD4- overflow interupts and SMP. Additionally now raw events are supported as well.
+AD4- +AD4- 
+AD4- +AD4- Please review +ACE-
+AD4- +AD4- 
+AD4- +AD4- Compared to v2 this series has:
+AD4- +AD4-  +AFs-1+AF0- Removed patch with raw-events support.
+AD4- +AD4-      It needs some rework and let's then discuss it separately.
+AD4- +AD4-      Still I plan to send it shortly.
+AD4- +AD4-  +AFs-2+AF0- Merged +ACI-set usable max period as a half of real max period+ACI- into
+AD4- +AD4-      +ACI-implement +ACI-event+AF8-set+AF8-period+ACI-.
+AD4- +AD4-  +AFs-3+AF0- Fixed arc+AF8-pmu+AF8-event+AF8-set+AF8-period() in regard of incorrect
+AD4- +AD4-      +ACI-hwc-+AD4-period+AF8-left+ACI- setup.
+AD4- +AD4-  +AFs-4+AF0- Moved interrupts enabling from arc+AF8-pmu+AF8-add() to arc+AF8-pmu+AF8-start()
+AD4- +AD4- 
+AD4- +AD4- Compared to v1 this series has:
+AD4- +AD4-  +AFs-1+AF0- Addressed review comments
+AD4- +AD4-  +AFs-2+AF0- More verbose commit messages and comments in sources
+AD4- +AD4-  +AFs-3+AF0- Minor cosmetics
+AD4- +AD4- 
+AD4- +AD4- Thanks,
+AD4- +AD4- Alexey

I'm wondering if you have any other comments on this series,
otherwise please consider it for applying.

-Alexey