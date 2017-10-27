Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from foss.arm.com ([217.140.101.70]:58460 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752412AbdJ0Mpz (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Fri, 27 Oct 2017 08:45:55 -0400
Date: Fri, 27 Oct 2017 13:45:51 +0100
From: Catalin Marinas <catalin.marinas@arm.com>
Subject: Re: [PATCH v4 11/28] arm64/sve: Core task context handling
Message-ID: <20171027124550.hul2skr5uxxwidbr@armageddon.cambridge.arm.com>
References: <1509101470-7881-1-git-send-email-Dave.Martin@arm.com>
 <1509101470-7881-12-git-send-email-Dave.Martin@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1509101470-7881-12-git-send-email-Dave.Martin@arm.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Dave Martin <Dave.Martin@arm.com>
Cc: linux-arm-kernel@lists.infradead.org, linux-arch@vger.kernel.org, Okamoto Takayuki <tokamoto@jp.fujitsu.com>, libc-alpha@sourceware.org, Ard Biesheuvel <ard.biesheuvel@linaro.org>, Szabolcs Nagy <szabolcs.nagy@arm.com>, Will Deacon <will.deacon@arm.com>, Alex =?iso-8859-1?Q?Benn=E9e?= <alex.bennee@linaro.org>, kvmarm@lists.cs.columbia.edu
Message-ID: <20171027124551.R13yJMffcZEQrekVpIYKlfyCfIn1giq9z-svps19mc8@z>

On Fri, Oct 27, 2017 at 11:50:53AM +0100, Dave P Martin wrote:
> This patch adds the core support for switching and managing the SVE
> architectural state of user tasks.
> 
> Calls to the existing FPSIMD low-level save/restore functions are
> factored out as new functions task_fpsimd_{save,load}(), since SVE
> now dynamically may or may not need to be handled at these points
> depending on the kernel configuration, hardware features discovered
> at boot, and the runtime state of the task.  To make these
> decisions as fast as possible, const cpucaps are used where
> feasible, via the system_supports_sve() helper.
> 
> The SVE registers are only tracked for threads that have explicitly
> used SVE, indicated by the new thread flag TIF_SVE.  Otherwise, the
> FPSIMD view of the architectural state is stored in
> thread.fpsimd_state as usual.
> 
> When in use, the SVE registers are not stored directly in
> thread_struct due to their potentially large and variable size.
> Because the task_struct slab allocator must be configured very
> early during kernel boot, it is also tricky to configure it
> correctly to match the maximum vector length provided by the
> hardware, since this depends on examining secondary CPUs as well as
> the primary.  Instead, a pointer sve_state in thread_struct points
> to a dynamically allocated buffer containing the SVE register data,
> and code is added to allocate and free this buffer at appropriate
> times.
> 
> TIF_SVE is set when taking an SVE access trap from userspace, if
> suitable hardware support has been detected.  This enables SVE for
> the thread: a subsequent return to userspace will disable the trap
> accordingly.  If such a trap is taken without sufficient system-
> wide hardware support, SIGILL is sent to the thread instead as if
> an undefined instruction had been executed: this may happen if
> userspace tries to use SVE in a system where not all CPUs support
> it for example.
> 
> The kernel will clear TIF_SVE and disable SVE for the thread
> whenever an explicit syscall is made by userspace.  For backwards
> compatibility reasons and conformance with the spirit of the base
> AArch64 procedure call standard, the subset of the SVE register
> state that aliases the FPSIMD registers is still preserved across a
> syscall even if this happens.  The remainder of the SVE register
> state logically becomes zero at syscall entry, though the actual
> zeroing work is currently deferred until the thread next tries to
> use SVE, causing another trap to the kernel.  This implementation
> is suboptimal: in the future, the fastpath case may be optimised
> to zero the registers in-place and leave SVE enabled for the task,
> where beneficial.
> 
> TIF_SVE is also cleared in the following slowpath cases, which are
> taken as reasonable hints that the task may no longer use SVE:
>  * exec
>  * fork and clone
> 
> Code is added to sync data between thread.fpsimd_state and
> thread.sve_state whenever enabling/disabling SVE, in a manner
> consistent with the SVE architectural programmer's model.
> 
> Signed-off-by: Dave Martin <Dave.Martin@arm.com>
> Cc: Ard Biesheuvel <ard.biesheuvel@linaro.org>
> Cc: Alex Bennée <alex.bennee@linaro.org>

Reviewed-by: Catalin Marinas <catalin.marinas@arm.com>
