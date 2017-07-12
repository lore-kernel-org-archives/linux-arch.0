From: James Morse <james.morse@arm.com>
Subject: Re: [PATCH 1/2] arm64: mm: abort uaccess retries upon fatal signal
Date: Wed, 12 Jul 2017 18:18:55 +0100
Message-ID: <596659FF.7070605@arm.com>
References: <1499782763-31418-1-git-send-email-mark.rutland@arm.com> <1499782763-31418-2-git-send-email-mark.rutland@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:57248 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932076AbdGLRT4 (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Wed, 12 Jul 2017 13:19:56 -0400
In-Reply-To: <1499782763-31418-2-git-send-email-mark.rutland@arm.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Mark Rutland <mark.rutland@arm.com>, linux-arch@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, catalin.marinas@arm.com, labbott@redhat.com, linux@armlinux.org.uk, stable@vger.kernel.org, steve.capper@arm.com, will.deacon@arm.com, viro@zeniv.linux.org.uk, peterz@infradead.org, luto@amacapital.net

Hi Mark,

On 11/07/17 15:19, Mark Rutland wrote:
> When there's a fatal signal pending, arm64's do_page_fault()
> implementation returns 0. The intent is that we'll return to the
> faulting userspace instruction, delivering the signal on the way.
> 
> However, if we take a fatal signal during fixing up a uaccess, this
> results in a return to the faulting kernel instruction, which will be
> instantly retried, resulting in the same fault being taken forever. As
> the task never reaches userspace, the signal is not delivered, and the
> task is left unkillable. While the task is stuck in this state, it can
> inhibit the forward progress of the system.
> 
> To avoid this, we must ensure that when a fatal signal is pending, we
> apply any necessary fixup for a faulting kernel instruction. Thus we
> will return to an error path, and it is up to that code to make forward
> progress towards delivering the fatal signal.

VM_FAULT_RETRY's 'I released your locks' behaviour is pretty nasty, but this
looks right. FWIW:
Reviewed-by: James Morse <james.morse@arm.com>

I also gave this a spin through LTP on Juno, based on v4.12-defconfig:
Tested-by: James Morse <james.morse@arm.com>


Thanks,

James
