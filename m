From: Vincenzo Frascino <vincenzo.frascino@arm.com>
Subject: Re: [PATCH 3/4] arm64: compat: Refactor aarch32_alloc_vdso_pages()
Date: Tue, 2 Apr 2019 11:06:32 +0100
Message-ID: <5d16a629-d77a-2a98-6ea0-5a6d66dc8057@arm.com>
References: <20190401112025.40807-1-vincenzo.frascino@arm.com>
 <20190401112025.40807-4-vincenzo.frascino@arm.com>
 <20190401144355.GI14874@arrakis.emea.arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20190401144355.GI14874@arrakis.emea.arm.com>
Content-Language: en-US
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Catalin Marinas <catalin.marinas@arm.com>
Cc: linux-arch@vger.kernel.org, Mark Rutland <mark.rutland@arm.com>, Will Deacon <will.deacon@arm.com>, linux-arm-kernel@lists.infradead.org
List-Id: linux-arch.vger.kernel.org


On 01/04/2019 15:43, Catalin Marinas wrote:
> On Mon, Apr 01, 2019 at 12:20:24PM +0100, Vincenzo Frascino wrote:
>> +static int __init aarch32_alloc_vdso_pages(void)
>> +{
>> +	return aarch32_alloc_kuser_vdso_page() &
>> +	       aarch32_alloc_sigreturn_vdso_page();
>>  }
>>  arch_initcall(aarch32_alloc_vdso_pages);
> 
> It probably doesn't matter much but I'd rather not bit-and two error
> codes. Just return the non-zero one or pick the first (your choice) if
> both are wrong.
> 
> (normally, if you want a non-zero random value if any of them failed,
> you'd use bit-or)
> 

Actually this is a good advice, I will change the code accordingly in v2.

-- 
Regards,
Vincenzo
