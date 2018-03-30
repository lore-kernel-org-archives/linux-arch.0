Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from smtp.codeaurora.org ([198.145.29.96]:59500 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751254AbeC3OqI (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 30 Mar 2018 10:46:08 -0400
Subject: Re: [PATCH] io: prevent compiler reordering on the default writeX()
 implementation
References: <1522420199-23548-1-git-send-email-okaya@codeaurora.org>
From: Sinan Kaya <okaya@codeaurora.org>
Message-ID: <4e3acc1a-0c06-5b1b-1b87-91bef2daae38@codeaurora.org>
Date: Fri, 30 Mar 2018 10:46:05 -0400
MIME-Version: 1.0
In-Reply-To: <1522420199-23548-1-git-send-email-okaya@codeaurora.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: arnd@arndb.de, timur@codeaurora.org, sulrich@codeaurora.org
Cc: linux-arm-msm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org
Message-ID: <20180330144605.9i685Oi4SuHfemHZg8RR3t27-o6sUMSOU7zOYIMEjXE@z>

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
