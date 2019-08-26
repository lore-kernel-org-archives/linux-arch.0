From: Cristian Marussi <cristian.marussi@arm.com>
Subject: Re: [RFC PATCH 0/7] Unify SMP stop generic logic to common code
Date: Mon, 26 Aug 2019 20:33:23 +0100
Message-ID: <2b4a744c-ea20-00e6-828f-7be125326792@arm.com>
References: <20190823115720.605-1-cristian.marussi@arm.com>
 <20190826153401.GB9591@infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190826153401.GB9591@infradead.org>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Christoph Hellwig <hch@infradead.org>
Cc: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, mark.rutland@arm.com, peterz@infradead.org, catalin.marinas@arm.com, takahiro.akashi@linaro.org, james.morse@arm.com, hidehiro.kawai.ez@hitachi.com, tglx@linutronix.de, will@kernel.org, dave.martin@arm.com, linux-arm-kernel@lists.infradead.org
List-Id: linux-arch.vger.kernel.org

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
