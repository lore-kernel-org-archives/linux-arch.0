From: Yao Qi <yao.qi@arm.com>
Subject: Re: [PATCH 07/11] arm64: add basic pointer authentication support
Date: Fri, 11 Aug 2017 08:46:28 +0100
Message-ID: <5a919df5-7f6d-2c6c-9c8e-e28fcebd4920@arm.com>
References: <1500480092-28480-1-git-send-email-mark.rutland@arm.com>
 <1500480092-28480-8-git-send-email-mark.rutland@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mail-ve1eur01on0042.outbound.protection.outlook.com ([104.47.1.42]:40770
        "EHLO EUR01-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751521AbdHKHqd (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Fri, 11 Aug 2017 03:46:33 -0400
In-Reply-To: <1500480092-28480-8-git-send-email-mark.rutland@arm.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Mark Rutland <mark.rutland@arm.com>, linux-arm-kernel@lists.infradead.org
Cc: arnd@arndb.de, catalin.marinas@arm.com, christoffer.dall@linaro.org, Dave.Martin@arm.com, jiong.wang@arm.com, kvmarm@lists.cs.columbia.edu, linux-arch@vger.kernel.org, marc.zyngier@arm.com, suzuki.poulose@arm.com, will.deacon@arm.com, linux-kernel@vger.kernel.org, kernel-hardening@lists.openwall.com

Hi Mark,

On 19/07/17 17:01, Mark Rutland wrote:
> +#define HWCAP_APIA           (1 << 16)

Can you rename it to HWCAP_ARM64_APIA or HWCAP_ARM_APIA?  When we
use it in user space, at least in GDB, we usually do this,

#ifndef HWCAP_APIA
#define HWCAP_APIA (1 << 16)
#endif

However, the code use this macro can be compiled on !arm64 host.
If HWCAP_APIA is defined on other !arm64 host and its value is not
(1 << 16), the program "aarch64_hwcap & HWCAP_APIA ? XXX : XXX;" is
wrong, and compiler doesn't complain.

I notice that mips, mn10300, sparc, and s390 define their HWCAP this
way, like HWCAP_SPARC_FLUSH, HWCAP_MIPS_R6, HWCAP_S390_DFP, etc.
IMPORTANT NOTICE: The contents of this email and any attachments are confid=
ential and may also be privileged. If you are not the intended recipient, p=
lease notify the sender immediately and do not disclose the contents to any=
 other person, use it for any purpose, or store or copy the information in =
any medium. Thank you.
