Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail-wi0-f178.google.com ([209.85.212.178]:52507 "EHLO
	mail-wi0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933257AbaH0NBT (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Wed, 27 Aug 2014 09:01:19 -0400
Received: by mail-wi0-f178.google.com with SMTP id hi2so384995wib.5
        for <linux-arch@vger.kernel.org>; Wed, 27 Aug 2014 06:01:15 -0700 (PDT)
Date: Wed, 27 Aug 2014 14:01:08 +0100
From: Steve Capper <steve.capper@linaro.org>
Subject: Re: [PATH V2 4/6] arm: mm: Enable RCU fast_gup
Message-ID: <20140827130107.GA8210@linaro.org>
References: <1408635812-31584-1-git-send-email-steve.capper@linaro.org>
 <1408635812-31584-5-git-send-email-steve.capper@linaro.org>
 <20140827115137.GK6968@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20140827115137.GK6968@arm.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Catalin Marinas <catalin.marinas@arm.com>
Cc: "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "linux@arm.linux.org.uk" <linux@arm.linux.org.uk>, "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>, "linux-mm@kvack.org" <linux-mm@kvack.org>, Will Deacon <Will.Deacon@arm.com>, "gary.robertson@linaro.org" <gary.robertson@linaro.org>, "christoffer.dall@linaro.org" <christoffer.dall@linaro.org>, "peterz@infradead.org" <peterz@infradead.org>, "anders.roxell@linaro.org" <anders.roxell@linaro.org>, "akpm@linux-foundation.org" <akpm@linux-foundation.org>, "dann.frazier@canonical.com" <dann.frazier@canonical.com>, Mark Rutland <Mark.Rutland@arm.com>, "mgorman@suse.de" <mgorman@suse.de>
Message-ID: <20140827130108.qXg1vPD5C5UFrZ1vqL8sCFFXT8RDmIgArdHwvuXliPo@z>

On Wed, Aug 27, 2014 at 12:51:37PM +0100, Catalin Marinas wrote:
> On Thu, Aug 21, 2014 at 04:43:30PM +0100, Steve Capper wrote:
> > Activate the RCU fast_gup for ARM. We also need to force THP splits to
> > broadcast an IPI s.t. we block in the fast_gup page walker. As THP
> > splits are comparatively rare, this should not lead to a noticeable
> > performance degradation.
> > 
> > Some pre-requisite functions pud_write and pud_page are also added.
> > 
> > Signed-off-by: Steve Capper <steve.capper@linaro.org>
> 
> Reviewed-by: Catalin Marinas <catalin.marinas@arm.com>

Thanks.
