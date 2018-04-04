Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from smtp.codeaurora.org ([198.145.29.96]:58382 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750915AbeDDRsi (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 4 Apr 2018 13:48:38 -0400
Subject: Re: [PATCH v2 2/2] io: prevent compiler reordering on the default
 readX() implementation
References: <mhng-fe49c525-788d-4ce7-9703-95e2b3eaeca6@palmer-si-x1c4>
 <691b903c-e97d-0a25-28c5-690318bb215a@codeaurora.org>
 <CAK8P3a2pGQb7TqQtuw0ZpQ=8CwXiRmRKKc1GwvEgKDgofxJ3nA@mail.gmail.com>
From: Sinan Kaya <okaya@codeaurora.org>
Message-ID: <9b0d7db3-0830-9661-6dc8-39523daa8f32@codeaurora.org>
Date: Wed, 4 Apr 2018 13:48:35 -0400
MIME-Version: 1.0
In-Reply-To: <CAK8P3a2pGQb7TqQtuw0ZpQ=8CwXiRmRKKc1GwvEgKDgofxJ3nA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Arnd Bergmann <arnd@arndb.de>
Cc: Palmer Dabbelt <palmer@sifive.com>, Mark Rutland <mark.rutland@arm.com>, Timur Tabi <timur@codeaurora.org>, sulrich@codeaurora.org, linux-arm-msm@vger.kernel.org, Linux ARM <linux-arm-kernel@lists.infradead.org>, linux-arch <linux-arch@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Message-ID: <20180404174835.qOJpxCt2qNC0WOKbS1m569oyNFg_yRhfdhzbxJzzm3U@z>

On 4/4/2018 11:55 AM, Arnd Bergmann wrote:
> Yes, exactly, plus the same for write and in/out of course.

I was looking at this...

inb() and outb() seem to be calling writeb(). It gets the wmb/barrier automatically
when we fix writeb().

Did I miss something?

-- 
Sinan Kaya
Qualcomm Datacenter Technologies, Inc. as an affiliate of Qualcomm Technologies, Inc.
Qualcomm Technologies, Inc. is a member of the Code Aurora Forum, a Linux Foundation Collaborative Project.
