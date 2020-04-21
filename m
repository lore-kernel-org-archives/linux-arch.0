Return-Path: <SRS0=BI31=6F=vger.kernel.org=linux-arch-owner@kernel.org>
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42788 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726067AbgDUQyG (ORCPT
        <rfc822;linux-arch@vger.kernel.org>);
        Tue, 21 Apr 2020 12:54:06 -0400
Date: Tue, 21 Apr 2020 09:53:46 -0700
From: Christoph Hellwig <hch@infradead.org>
Subject: Re: [PATCH v1 1/6] arm64: Detect the ARMv8.4 TTL feature
Message-ID: <20200421165346.GA11171@infradead.org>
References: <20200403090048.938-1-yezhenyu2@huawei.com>
 <20200403090048.938-2-yezhenyu2@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200403090048.938-2-yezhenyu2@huawei.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Zhenyu Ye <yezhenyu2@huawei.com>
Cc: peterz@infradead.org, mark.rutland@arm.com, will@kernel.org, catalin.marinas@arm.com, aneesh.kumar@linux.ibm.com, akpm@linux-foundation.org, npiggin@gmail.com, arnd@arndb.de, rostedt@goodmis.org, maz@kernel.org, suzuki.poulose@arm.com, tglx@linutronix.de, yuzhao@google.com, Dave.Martin@arm.com, steven.price@arm.com, broonie@kernel.org, guohanjun@huawei.com, linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org, xiexiangyou@huawei.com, zhangshaokun@hisilicon.com, linux-mm@kvack.org, arm@kernel.org, prime.zeng@hisilicon.com, kuhn.chenqun@huawei.com, linux-arm-kernel@lists.infradead.org
Message-ID: <20200421165346.-YfauCW6hA5g04O62QS4dA5DpMVWaIhEgKkDwmvot60@z>

On Fri, Apr 03, 2020 at 05:00:43PM +0800, Zhenyu Ye wrote:
> From: Marc Zyngier <maz@kernel.org>
> 
> In order to reduce the cost of TLB invalidation, the ARMv8.4 TTL
> feature allows TLBs to be issued with a level allowing for quicker
> invalidation.

What does "issued with a level" mean?
