From: Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [REVIEW][PATCH 01/20] signal: Simplify
 tracehook_report_syscall_exit
Date: Tue, 18 Sep 2018 22:15:12 +0200 (CEST)
Message-ID: <alpine.DEB.2.21.1809182214380.1468@nanos.tec.linutronix.de>
References: <87y3bzk6yv.fsf@xmission.com> <20180918000546.12552-1-ebiederm@xmission.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180918000546.12552-1-ebiederm@xmission.com>
Sender: linux-kernel-owner@vger.kernel.org
To: "Eric W. Biederman" <ebiederm@xmission.com>
Cc: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, Ingo Molnar <mingo@redhat.com>, x86@kernel.org
List-Id: linux-arch.vger.kernel.org

On Tue, 18 Sep 2018, Eric W. Biederman wrote:

> Replace user_single_step_siginfo with user_single_step_report
> that allocates siginfo structure on the stack and sends it.
> 
> This allows tracehook_report_syscall_exit to become a simple
> if statement that calls user_single_step_report or ptrace_report_syscall
> depending on the value of step.
> 
> Update the default helper function now called user_single_step_report
> to explicitly set si_code to SI_USER and to set si_uid and si_pid to 0.
> The default helper has always been doing this (using memset) but it
> was far from obvious.
> 
> The powerpc helper can now just call force_sig_fault.
> The x86 helper can now just call send_sigtrap.
> 
> Unfortunately the default implementation of user_single_step_report
> can not use force_sig_fault as it does not use a SIGTRAP si_code.
> So it has to carefully setup the siginfo and use use force_sig_info.
> 
> The net result is code that is easier to understand and simpler
> to maintain.
> 
> Ref: 85ec7fd9f8e5 ("ptrace: introduce user_single_step_siginfo() helper")
> Signed-off-by: "Eric W. Biederman" <ebiederm@xmission.com>

Reviewed-by: Thomas Gleixner <tglx@linutronix.de>
