From: Sean Christopherson <sean.j.christopherson@intel.com>
Subject: Re: [patch V5 08/15] x86/entry: Move user return notifier out of loop
Date: Thu, 23 Jul 2020 16:41:11 -0700
Message-ID: <20200723234111.GJ21891@linux.intel.com>
References: <20200722215954.464281930@linutronix.de>
 <20200722220520.159112003@linutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mga12.intel.com ([192.55.52.136]:33453 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727783AbgGWXlN (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Thu, 23 Jul 2020 19:41:13 -0400
Content-Disposition: inline
In-Reply-To: <20200722220520.159112003@linutronix.de>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Thomas Gleixner <tglx@linutronix.de>
Cc: LKML <linux-kernel@vger.kernel.org>, x86@kernel.org, linux-arch@vger.kernel.org, Will Deacon <will@kernel.org>, Arnd Bergmann <arnd@arndb.de>, Mark Rutland <mark.rutland@arm.com>, Kees Cook <keescook@chromium.org>, Keno Fischer <keno@juliacomputing.com>, Paolo Bonzini <pbonzini@redhat.com>, kvm@vger.kernel.org, Gabriel Krisman Bertazi <krisman@collabora.com>

On Thu, Jul 23, 2020 at 12:00:02AM +0200, Thomas Gleixner wrote:
> From: Thomas Gleixner <tglx@linutronix.de>
> 
> Guests and user space share certain MSRs. KVM sets these MSRs to guest
> values once and does not set them back to user space values on every VM
> exit to spare the costly MSR operations.
> 
> User return notifiers ensure that these MSRs are set back to the correct
> values before returning to user space in exit_to_usermode_loop().
> 
> There is no reason to evaluate the TIF flag indicating that user return
> notifiers need to be invoked in the loop. The important point is that they
> are invoked before returning to user space.
> 
> Move the invocation out of the loop into the section which does the last
> preperatory steps before returning to user space. That section is not
> preemptible and runs with interrupts disabled until the actual return.
> 
> Signed-off-by: Thomas Gleixner <tglx@linutronix.de>

Reviewed-and-tested-by: Sean Christopherson <sean.j.christopherson@intel.com>
