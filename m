Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:50984 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726784AbeJSTxH (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Fri, 19 Oct 2018 15:53:07 -0400
Subject: Re: [PATCH v5 11/17] arm64: docs: document pointer authentication
References: <20181005084754.20950-1-kristina.martsenko@arm.com>
 <20181005084754.20950-12-kristina.martsenko@arm.com>
 <9acb0cd2-66b0-1c41-b1a8-7c70608e9a9b@foss.arm.com>
 <7b0de19b-45b9-f4df-25d1-c7e80fab49dc@arm.com>
 <20181019113556.ljbdmjo5pdw7muvz@mbp>
From: Marc Zyngier <marc.zyngier@arm.com>
Message-ID: <05738017-5886-fe4d-e8fd-a834da6b1576@arm.com>
Date: Fri, 19 Oct 2018 12:47:16 +0100
MIME-Version: 1.0
In-Reply-To: <20181019113556.ljbdmjo5pdw7muvz@mbp>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Catalin Marinas <catalin.marinas@arm.com>, Kristina Martsenko <kristina.martsenko@arm.com>
Cc: Ramana Radhakrishnan <ramana.radhakrishnan@foss.arm.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, Mark Rutland <Mark.Rutland@arm.com>, "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>, Andrew Jones <drjones@redhat.com>, Jacob Bramley <Jacob.Bramley@arm.com>, Arnd Bergmann <arnd@arndb.de>, Ard Biesheuvel <ard.biesheuvel@linaro.org>, Adam Wallis <awallis@codeaurora.org>, Suzuki Poulose <Suzuki.Poulose@arm.com>, Will Deacon <Will.Deacon@arm.com>, Christoffer Dall <Christoffer.Dall@arm.com>, "kvmarm@lists.cs.columbia.edu" <kvmarm@lists.cs.columbia.edu>, Amit Kachhap <Amit.Kachhap@arm.com>, Dave P Martin <Dave.Martin@arm.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Kees Cook <keescook@chromium.org>
Message-ID: <20181019114716.O4C3h6BdEnv_Pb2EkGU07_0_EBb77KRcG1LCmzmmaaw@z>

On 19/10/18 12:35, Catalin Marinas wrote:
> On Tue, Oct 16, 2018 at 05:14:39PM +0100, Kristina Martsenko wrote:
>> On 05/10/2018 10:04, Ramana Radhakrishnan wrote:
>>> On 05/10/2018 09:47, Kristina Martsenko wrote:

[...]

>> The other option is to turn off trapping entirely. However then on a
>> big.LITTLE system with mismatched pointer authentication support
>> instructions will work intermittently on some CPUs but not others.
> 
> That's another case but let's assume we never see such configurations ;).

I'd like to put it on the record that I'm not willing to support such a
configuration. So my ask is that if we detect a system where only some
of the CPUs have pointer authentication support, we either:

1) prevent some of the CPUs from booting (that's harsh)
2) disable KVM (that's easy)

I'm perfectly happy with (2).

Thanks,

	M.
-- 
Jazz is not dead. It just smells funny...
