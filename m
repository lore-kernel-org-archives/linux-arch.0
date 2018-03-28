Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from smtp.codeaurora.org ([198.145.29.96]:52648 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751207AbeC1MXD (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 28 Mar 2018 08:23:03 -0400
Subject: Re: [PATCH v5 1/4] ioremap: Update pgtable free interfaces with addr
References: <1522157100-16879-2-git-send-email-cpandya@codeaurora.org>
 <201803281954.xld7X6dW%fengguang.wu@intel.com>
From: Chintan Pandya <cpandya@codeaurora.org>
Message-ID: <37565406-dc0d-b23a-a8e8-27767590c9f1@codeaurora.org>
Date: Wed, 28 Mar 2018 17:52:53 +0530
MIME-Version: 1.0
In-Reply-To: <201803281954.xld7X6dW%fengguang.wu@intel.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: kbuild test robot <lkp@intel.com>
Cc: kbuild-all@01.org, catalin.marinas@arm.com, will.deacon@arm.com, mark.rutland@arm.com, toshi.kani@hpe.com, arnd@arndb.de, ard.biesheuvel@linaro.org, marc.zyngier@arm.com, james.morse@arm.com, kristina.martsenko@arm.com, takahiro.akashi@linaro.org, gregkh@linuxfoundation.org, tglx@linutronix.de, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, akpm@linux-foundation.org
Message-ID: <20180328122253.JobLpkD3xcE15Nje3khD6UL4n_mUcbdjVXDVNyK9fw0@z>



On 3/28/2018 5:20 PM, kbuild test robot wrote:
>   @725  		if (!pmd_free_pte_page(&pmd[i]))
My bad ! Will fix this in v7

Chintan
-- 
Qualcomm India Private Limited, on behalf of Qualcomm Innovation Center,
Inc. is a member of the Code Aurora Forum, a Linux Foundation
Collaborative Project
