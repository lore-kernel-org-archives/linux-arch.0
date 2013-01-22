From: Vineet Gupta <Vineet.Gupta1@synopsys.com>
Subject: Re: [PATCH v2 29/76] ARC: Boot #1: low-level, setup_arch(), /proc/cpuinfo,
 mem init
Date: Tue, 22 Jan 2013 14:01:42 +0530
Message-ID: <50FE4E6E.3090708@synopsys.com>
References: <1358511930-7424-1-git-send-email-vgupta@synopsys.com> <201301181445.39050.arnd@arndb.de> <50FE4497.3050306@synopsys.com> <201301220823.44872.arnd@arndb.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-15"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from alvesta.synopsys.com ([198.182.60.77]:50548 "EHLO
	alvesta.synopsys.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753864Ab3AVIbz (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Tue, 22 Jan 2013 03:31:55 -0500
In-Reply-To: <201301220823.44872.arnd@arndb.de>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Arnd Bergmann <arnd@arndb.de>
Cc: linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org

On Tuesday 22 January 2013 01:53 PM, Arnd Bergmann wrote:
> On Tuesday 22 January 2013, Vineet Gupta wrote:
>> How does the following look like. This is RFC only and I'll squash it into Boot #1
>> patch.
>>
>> From: Vineet Gupta <vgupta@synopsys.com>
>> Date: Tue, 22 Jan 2013 13:03:50 +0530
>> Subject: [PATCH] RFC: Convert ARC port from bootmem to memblock
>>
>> Signed-off-by: Vineet Gupta <vgupta@synopsys.com>
>> ---
> 
> Looks good to me, although I might be missing some details.
> 
> Given that everything still seems to work for you,
> 
> Acked-by: Arnd Bergmann <arnd@arndb.de>
> 
> on the combined patch.
> 

I haven't done heavy testing on this (just basic boot) and no_bootmem/memblock is
not a well-known turf form me yet. But should be sufficient for now ;-)

Thx,
-Vineet
