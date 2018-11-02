Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:58354 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727804AbeKBPII (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Fri, 2 Nov 2018 11:08:08 -0400
Subject: Re: [PATCH v5 11/17] arm64: docs: document pointer authentication
References: <20181005084754.20950-1-kristina.martsenko@arm.com>
 <20181005084754.20950-12-kristina.martsenko@arm.com>
 <9acb0cd2-66b0-1c41-b1a8-7c70608e9a9b@foss.arm.com>
 <7b0de19b-45b9-f4df-25d1-c7e80fab49dc@arm.com>
 <20181019113556.ljbdmjo5pdw7muvz@mbp>
 <e73035eb-2157-7a9c-3631-d4d2ad0b7d38@arm.com>
 <20181019151029.GD3985@arrakis.emea.arm.com>
 <20181019174524.GC4429@brain-police>
From: Jon Masters <jcm@redhat.com>
Message-ID: <d73e8824-bb8e-8172-4541-9be136453020@redhat.com>
Date: Fri, 2 Nov 2018 02:02:03 -0400
MIME-Version: 1.0
In-Reply-To: <20181019174524.GC4429@brain-police>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Will Deacon <will.deacon@arm.com>, Catalin Marinas <catalin.marinas@arm.com>
Cc: Kristina Martsenko <kristina.martsenko@arm.com>, Mark Rutland <Mark.Rutland@arm.com>, "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>, Andrew Jones <drjones@redhat.com>, Jacob Bramley <Jacob.Bramley@arm.com>, Arnd Bergmann <arnd@arndb.de>, Ard Biesheuvel <ard.biesheuvel@linaro.org>, Marc Zyngier <Marc.Zyngier@arm.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Adam Wallis <awallis@codeaurora.org>, Suzuki Poulose <Suzuki.Poulose@arm.com>, Christoffer Dall <Christoffer.Dall@arm.com>, Dave P Martin <Dave.Martin@arm.com>, Amit Kachhap <Amit.Kachhap@arm.com>, Ramana Radhakrishnan <ramana.radhakrishnan@foss.arm.com>, "kvmarm@lists.cs.columbia.edu" <kvmarm@lists.cs.columbia.edu>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, Kees Cook <keescook@chromium.org>
Message-ID: <20181102060203.mtDg15tpkKg3m3lLplDb-NN9EFd0PB2t4D3H_oO0ZHo@z>

On 10/19/18 1:45 PM, Will Deacon wrote:

>>> I think an alternative solution is to just disable trapping of pointer
>>> auth instructions in KVM. This will mean that the instructions will
>>> behave the same in the guest as they do in the host. HINT-space
>>> instructions (including XPACLRI) will behave as NOPs (or perform their
>>> function, if enabled by the guest), and will not trap.
>>
>> OK, so this means disabling the trap (during early EL2 setup) but still
>> sanitizing the CPUID not to report the feature to EL1 unless fully
>> supported on all CPUs.
> 
> ... which is perfectly sensible, but not actually my main concern here.
> I'm worried about the possibility of distributions shipping *now* with
> userspace that's built with these instructions. That stuff is going to
> break if/when it encounters v8.3 hardware, and I don't think we can do
> much about it other than alert them to the potential issue.

FYI tracking this for RHEL. It's not a problem currently. I'll alert our
tools teams to hold off on any PAC work until this is figured out.

Jon.

-- 
Computer Architect | Sent with my Fedora powered laptop
