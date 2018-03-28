From: Chintan Pandya <cpandya@codeaurora.org>
Subject: Re: [PATCH v5 1/4] ioremap: Update pgtable free interfaces with addr
Date: Wed, 28 Mar 2018 17:52:53 +0530
Message-ID: <37565406-dc0d-b23a-a8e8-27767590c9f1@codeaurora.org>
References: <1522157100-16879-2-git-send-email-cpandya@codeaurora.org>
 <201803281954.xld7X6dW%fengguang.wu@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <201803281954.xld7X6dW%fengguang.wu@intel.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: kbuild test robot <lkp@intel.com>
Cc: kbuild-all@01.org, catalin.marinas@arm.com, will.deacon@arm.com, mark.rutland@arm.com, toshi.kani@hpe.com, arnd@arndb.de, ard.biesheuvel@linaro.org, marc.zyngier@arm.com, james.morse@arm.com, kristina.martsenko@arm.com, takahiro.akashi@linaro.org, gregkh@linuxfoundation.org, tglx@linutronix.de, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, akpm@linux-foundation.org
List-Id: linux-arch.vger.kernel.org



On 3/28/2018 5:20 PM, kbuild test robot wrote:
>   @725  		if (!pmd_free_pte_page(&pmd[i]))
My bad ! Will fix this in v7

Chintan
-- 
Qualcomm India Private Limited, on behalf of Qualcomm Innovation Center,
Inc. is a member of the Code Aurora Forum, a Linux Foundation
Collaborative Project
