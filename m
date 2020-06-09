From: "Michael Kerrisk (man-pages)" <mtk.manpages@gmail.com>
Subject: Re: [PATCH v2 5/6] prctl.2: Add PR_PAC_RESET_KEYS (arm64)
Date: Tue, 9 Jun 2020 20:11:18 +0200
Message-ID: <0dce173d-25f9-fcce-cfa6-b4d8d96c906c@gmail.com>
References: <1590614258-24728-1-git-send-email-Dave.Martin@arm.com>
 <1590614258-24728-6-git-send-email-Dave.Martin@arm.com>
 <1084d017-54f3-475c-be1b-aabc801d9a71@gmail.com>
 <20200609141620.GC25945@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44690 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388145AbgFISLW (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 9 Jun 2020 14:11:22 -0400
In-Reply-To: <20200609141620.GC25945@arm.com>
Content-Language: en-US
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Dave Martin <Dave.Martin@arm.com>
Cc: mtk.manpages@gmail.com, linux-man@vger.kernel.org, linux-arch@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Will Deacon <will@kernel.org>, Catalin Marinas <catalin.marinas@arm.com>, Amit Daniel Kachhap <amit.kachhap@arm.com>, Mark Rutland <mark.rutland@arm.com>

>> I applied the following change after your patch; is it okay?
>>
>>  .IP
>>  .B Warning:
>>  Because the compiler or run-time environment
>>  may be using some or all of the keys,
>>  a successful
> 
> Looks fine, execpt that I think you need to move the
> 
> 	.B PR_PAC_RESET_KEYS
> 
> line here also.

Thanks. Fixed. But, the fix will be in the 5.08 man-pages release,
I'm sorry. I cut 5.07 a few hours ago.

Cheers,

Michael


-- 
Michael Kerrisk
Linux man-pages maintainer; http://www.kernel.org/doc/man-pages/
Linux/UNIX System Programming Training: http://man7.org/training/
