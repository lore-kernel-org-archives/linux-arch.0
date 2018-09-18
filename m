From: Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [REVIEW][PATCH 11/20] signal/x86/traps: Simplify trap
 generation
Date: Tue, 18 Sep 2018 22:37:02 +0200 (CEST)
Message-ID: <alpine.DEB.2.21.1809182236170.1468@nanos.tec.linutronix.de>
References: <87y3bzk6yv.fsf@xmission.com> <20180918000546.12552-11-ebiederm@xmission.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180918000546.12552-11-ebiederm@xmission.com>
Sender: linux-kernel-owner@vger.kernel.org
To: "Eric W. Biederman" <ebiederm@xmission.com>
Cc: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, Ingo Molnar <mingo@redhat.com>, x86@kernel.org
List-Id: linux-arch.vger.kernel.org

On Tue, 18 Sep 2018, Eric W. Biederman wrote:

> Update the DO_ERROR macro to take si_code and si_addr values for a siginfo,
> removing the need for the fill_trap_info function.
> 
> Update do_trap to also take the sicode and si_addr values for a sigininfo
> and modify the code to call force_sig when a sicode is not passed in
> and to call force_sig_fault when all of the information is present.
> 
> Making this a more obvious, simpler and less error prone construction.
> 
> Signed-off-by: "Eric W. Biederman" <ebiederm@xmission.com>

Reviewed-by: Thomas Gleixner <tglx@linutronix.de>
