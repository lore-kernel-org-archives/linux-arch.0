Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from foss.arm.com ([217.140.110.172]:34418 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729780AbfHZTd2 (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Mon, 26 Aug 2019 15:33:28 -0400
Subject: Re: [RFC PATCH 0/7] Unify SMP stop generic logic to common code
References: <20190823115720.605-1-cristian.marussi@arm.com>
 <20190826153401.GB9591@infradead.org>
From: Cristian Marussi <cristian.marussi@arm.com>
Message-ID: <2b4a744c-ea20-00e6-828f-7be125326792@arm.com>
Date: Mon, 26 Aug 2019 20:33:23 +0100
MIME-Version: 1.0
In-Reply-To: <20190826153401.GB9591@infradead.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Christoph Hellwig <hch@infradead.org>
Cc: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, mark.rutland@arm.com, peterz@infradead.org, catalin.marinas@arm.com, takahiro.akashi@linaro.org, james.morse@arm.com, hidehiro.kawai.ez@hitachi.com, tglx@linutronix.de, will@kernel.org, dave.martin@arm.com, linux-arm-kernel@lists.infradead.org
Message-ID: <20190826193323.ZFhxlwkZt86bq4mOnBl2c7RbUh5h5Z3P2ko5t4JZXx8@z>

Hi Christoph

thanks for the review.

On 8/26/19 4:34 PM, Christoph Hellwig wrote:
> On Fri, Aug 23, 2019 at 12:57:13PM +0100, Cristian Marussi wrote:
>> An architecture willing to rely on this SMP common logic has to define its
>> own helpers and set CONFIG_ARCH_USE_COMMON_SMP_STOP=y.
>> The series wire this up for arm64.
>>
>> Behaviour is not changed for architectures not adopting this new common
>> logic.
> 
> Seens like this common code only covers arm64.  I think we should
> generally have at least two users for common code.
> 

Yes absolutely, but this RFC was an attempt at first to explore if this
approach was deemed sensible upstream or not, so I wired up only arm64 for now.

Thanks

Cristian
