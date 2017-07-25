Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail-db5eur01on0075.outbound.protection.outlook.com ([104.47.2.75]:5825
        "EHLO EUR01-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1750860AbdGYLcR (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Tue, 25 Jul 2017 07:32:17 -0400
Subject: Re: [PATCH 00/11] ARMv8.3 pointer authentication userspace support
References: <1500480092-28480-1-git-send-email-mark.rutland@arm.com>
From: Yao Qi <yao.qi@arm.com>
Message-ID: <bb507ee1-c7ba-4c73-0d0f-058c4821793c@arm.com>
Date: Tue, 25 Jul 2017 12:32:10 +0100
MIME-Version: 1.0
In-Reply-To: <1500480092-28480-1-git-send-email-mark.rutland@arm.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: quoted-printable
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Mark Rutland <mark.rutland@arm.com>, linux-arm-kernel@lists.infradead.org
Cc: arnd@arndb.de, catalin.marinas@arm.com, christoffer.dall@linaro.org, Dave.Martin@arm.com, jiong.wang@arm.com, kvmarm@lists.cs.columbia.edu, linux-arch@vger.kernel.org, marc.zyngier@arm.com, suzuki.poulose@arm.com, will.deacon@arm.com, linux-kernel@vger.kernel.org, kernel-hardening@lists.openwall.com
Message-ID: <20170725113210.bydG98RGW6kBunA9r8fIOQYKxo3_KMyUoFI3jNqPRyg@z>

On 19/07/17 17:01, Mark Rutland wrote:
> If authentication fails, bits are set in the pointer such that it is guar=
anteed
> to cause a fault if used.

How does user space know the fault is caused by authentication fail?
When GDB is debugging a program, and it failed in pointer
authentication, I assume GDB only knows that the program receives signal
SIGSEGV, but how does GDB or user know why does the program get SIGSEGV?
IMPORTANT NOTICE: The contents of this email and any attachments are confid=
ential and may also be privileged. If you are not the intended recipient, p=
lease notify the sender immediately and do not disclose the contents to any=
 other person, use it for any purpose, or store or copy the information in =
any medium. Thank you.
