From: Steve Capper <steve.capper@linaro.org>
Subject: Re: [PATH V2 5/6] arm64: mm: Enable HAVE_RCU_TABLE_FREE logic
Date: Wed, 27 Aug 2014 14:08:25 +0100
Message-ID: <20140827130824.GB8210@linaro.org>
References: <1408635812-31584-1-git-send-email-steve.capper@linaro.org>
 <1408635812-31584-6-git-send-email-steve.capper@linaro.org>
 <20140827104840.GH6968@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mail-wg0-f42.google.com ([74.125.82.42]:46140 "EHLO
	mail-wg0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933592AbaH0NIa (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Wed, 27 Aug 2014 09:08:30 -0400
Received: by mail-wg0-f42.google.com with SMTP id l18so191494wgh.1
        for <linux-arch@vger.kernel.org>; Wed, 27 Aug 2014 06:08:28 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20140827104840.GH6968@arm.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Catalin Marinas <catalin.marinas@arm.com>
Cc: "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "linux@arm.linux.org.uk" <linux@arm.linux.org.uk>, "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>, "linux-mm@kvack.org" <linux-mm@kvack.org>, Will Deacon <Will.Deacon@arm.com>, "gary.robertson@linaro.org" <gary.robertson@linaro.org>, "christoffer.dall@linaro.org" <christoffer.dall@linaro.org>, "peterz@infradead.org" <peterz@infradead.org>, "anders.roxell@linaro.org" <anders.roxell@linaro.org>, "akpm@linux-foundation.org" <akpm@linux-foundation.org>, "dann.frazier@canonical.com" <dann.frazier@canonical.com>, Mark Rutland <Mark.Rutland@arm.com>, "mgorman@suse.de" <mgorman@suse.de>

On Wed, Aug 27, 2014 at 11:48:41AM +0100, Catalin Marinas wrote:
> On Thu, Aug 21, 2014 at 04:43:31PM +0100, Steve Capper wrote:
> > In order to implement fast_get_user_pages we need to ensure that the
> > page table walker is protected from page table pages being freed from
> > under it.
> > 
> > This patch enables HAVE_RCU_TABLE_FREE, any page table pages belonging
> > to address spaces with multiple users will be call_rcu_sched freed.
> > Meaning that disabling interrupts will block the free and protect the
> > fast gup page walker.
> > 
> > Signed-off-by: Steve Capper <steve.capper@linaro.org>
> 
> I'm happy to take this patch independently of this series. But if the
> whole series goes in via some other tree (mm):
> 
> Acked-by: Catalin Marinas <catalin.marinas@arm.com>

Thanks. If patch #1 looks okay to the mm folks, I'm hoping this patch
can be merged via the same tree.
