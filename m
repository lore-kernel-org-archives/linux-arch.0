From: Sinan Kaya <okaya@codeaurora.org>
Subject: Re: [PATCH] io: prevent compiler reordering on the default writeX()
 implementation
Date: Fri, 30 Mar 2018 10:46:05 -0400
Message-ID: <4e3acc1a-0c06-5b1b-1b87-91bef2daae38@codeaurora.org>
References: <1522420199-23548-1-git-send-email-okaya@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1522420199-23548-1-git-send-email-okaya@codeaurora.org>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: arnd@arndb.de, timur@codeaurora.org, sulrich@codeaurora.org
Cc: linux-arm-msm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-arch.vger.kernel.org

On 3/30/2018 10:29 AM, Sinan Kaya wrote:
> In the abscence of a write barrier or when using a strongly ordered
> architecture, writeX() should at least have a compiler barrier in
> it to prevent commpiler from clobbering the execution order.

Same is true for readX(). I'll wait for review feedback on this before
posting another change for readX().

-- 
Sinan Kaya
Qualcomm Datacenter Technologies, Inc. as an affiliate of Qualcomm Technologies, Inc.
Qualcomm Technologies, Inc. is a member of the Code Aurora Forum, a Linux Foundation Collaborative Project.
