Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from smtp17.cstnet.cn ([159.226.251.17]:54712 "EHLO cstnet.cn"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727409AbeGaM1f (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Tue, 31 Jul 2018 08:27:35 -0400
From: Pu Wen <puwen@hygon.cn>
Subject: Re: [PATCH v2 16/17] driver/edac: enable Hygon support to AMD64 EDAC
 driver
References: <1532352037-7151-1-git-send-email-puwen@hygon.cn>
 <1532352037-7151-17-git-send-email-puwen@hygon.cn>
 <b24739e8-0833-8509-0850-815758accaee@redhat.com>
 <c8f53708-bd57-fb41-8300-115ac5083094@hygon.cn>
 <1360de2a-5aae-bfd7-ced1-f707b29e7b1f@redhat.com>
Message-ID: <62003623-b4ee-9ddd-261a-d48b7cf2ce36@hygon.cn>
Date: Tue, 31 Jul 2018 18:46:54 +0800
MIME-Version: 1.0
In-Reply-To: <1360de2a-5aae-bfd7-ced1-f707b29e7b1f@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Paolo Bonzini <pbonzini@redhat.com>, tglx@linutronix.de, bp@alien8.de, thomas.lendacky@amd.com, mingo@redhat.com, hpa@zytor.com, peterz@infradead.org, tony.luck@intel.com, rkrcmar@redhat.com, boris.ostrovsky@oracle.com, jgross@suse.com, rjw@rjwysocki.net, lenb@kernel.org, viresh.kumar@linaro.org, mchehab@kernel.org, trenn@suse.com, shuah@kernel.org, x86@kernel.org
Cc: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, kvm@vger.kernel.org
Message-ID: <20180731104654.VRX17QgnMKp-ZnRyi04gUQ7sDn2w0ys7lJlmQhOv1hE@z>

On 2018/7/31 15:38, Paolo Bonzini wrote:
> But if that's the case, it doesn't make sense to have a new vendor!  If
> AMD's 17h and Hygon's 18h ever diverge, you could always choose the
> right behavior based on the family, without checking the vendor.
> 
> However, if the x86 maintainers prefer to have a new X86_VENDOR_*
> constant, I'd just ignore the fact that AMD will skip family 18h, and
> introduce vendor checks along the lines below.  This has the advantage
> that it's not an issue if AMD ends up _not_ skipping family 18h.

Thanks for the suggestion. It's reasonable for the fully consideration.
For code consistency, will check explicitly for Hygon before testing
family 18h in next patch set.

Thanks,
Pu Wen
