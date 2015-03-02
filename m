From: Mark Rutland <mark.rutland@arm.com>
Subject: Re: [PATCH V4 0/6] RCU get_user_pages_fast and __get_user_pages_fast
Date: Mon, 2 Mar 2015 14:16:04 +0000
Message-ID: <20150302141604.GB16779@leverpostej>
References: <1411740233-28038-1-git-send-email-steve.capper@linaro.org>
 <54F06636.6080905@redhat.com>
 <20150227132000.GD9011@leverpostej>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from foss.arm.com ([217.140.101.70]:47208 "EHLO foss.arm.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753722AbbCBOQe (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Mon, 2 Mar 2015 09:16:34 -0500
Content-Disposition: inline
In-Reply-To: <20150227132000.GD9011@leverpostej>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: "jcm@redhat.com" <jcm@redhat.com>
Cc: "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>, "dann.frazier@canonical.com" <dann.frazier@canonical.com>, Steve Capper <steve.capper@linaro.org>, "peterz@infradead.org" <peterz@infradead.org>, Catalin Marinas <Catalin.Marinas@arm.com>, "anders.roxell@linaro.org" <anders.roxell@linaro.org>, Will Deacon <Will.Deacon@arm.com>, "linux-mm@kvack.org" <linux-mm@kvack.org>, "hughd@google.com" <hughd@google.com>, "christoffer.dall@linaro.org" <christoffer.dall@linaro.org>, "gary.robertson@linaro.org" <gary.robertson@linaro.org>, "linux@arm.linux.org.uk" <linux@arm.linux.org.uk>, "akpm@linux-foundation.org" <akpm@linux-foundation.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "mgorman@suse.de" <mgorman@suse.de>

> > Head's up: these patches are currently implicated in a rare-to-trigger
> > hang that we are seeing on an internal kernel. An extensive effort is
> > underway to confirm whether these are the cause. Will followup.
> 
> I'm currently investigating an intermittent memory corruption issue in
> v4.0-rc1 I'm able to trigger on Seattle with 4K pages and 48-bit VA,
> which may or may not be related. Sometimes it results in a hang (when
> the vectors get corrupted and the CPUs get caught in a recursive
> exception loop).

FWIW my issue appears to be a bug in the old firmware I'm running.
Sorry for the noise!

Mark.
