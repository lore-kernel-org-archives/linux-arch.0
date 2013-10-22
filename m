From: Vineet Gupta <Vineet.Gupta1@synopsys.com>
Subject: Re: [RFC PATCH v2 02/25] smp, alpha: kill SMP single function call
 interrupt
Date: Tue, 22 Oct 2013 15:37:58 +0530
Message-ID: <52664E7E.6090504@synopsys.com>
References: <1378915649-16395-1-git-send-email-liuj97@gmail.com> <1378915649-16395-3-git-send-email-liuj97@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from us01smtp2.synopsys.com ([198.182.44.80]:37265 "EHLO
	kiruna.synopsys.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751372Ab3JVKIP (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Tue, 22 Oct 2013 06:08:15 -0400
In-Reply-To: <1378915649-16395-3-git-send-email-liuj97@gmail.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Jiang Liu <jiang.liu@huawei.com>
Cc: "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>, lkml <linux-kernel@vger.kernel.org>

Hi Jiang,

On 09/11/2013 09:37 PM, Jiang Liu wrote:
> From: Jiang Liu <jiang.liu@huawei.com>
> 
> Commit 9a46ad6d6df3b54 "smp: make smp_call_function_many() use logic
> similar to smp_call_function_single()" has unified the way to handle
> single and multiple cross-CPU function calls. Now only one interrupt
> is needed for architecture specific code to support generic SMP function
> call interfaces, so kill the redundant single function call interrupt.
> 
> Signed-off-by: Jiang Liu <jiang.liu@huawei.com>

What's the status of this series - seemed useful to me. Are you planning to get it
merged in 3.13

-Vineet
