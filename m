From: Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [REVIEW][PATCH 18/20] signal/x86: Replace force_sig_info_fault
 with force_sig_fault
Date: Tue, 18 Sep 2018 22:51:30 +0200 (CEST)
Message-ID: <alpine.DEB.2.21.1809182251100.1468@nanos.tec.linutronix.de>
References: <87y3bzk6yv.fsf@xmission.com> <20180918000546.12552-18-ebiederm@xmission.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180918000546.12552-18-ebiederm@xmission.com>
Sender: linux-kernel-owner@vger.kernel.org
To: "Eric W. Biederman" <ebiederm@xmission.com>
Cc: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, Ingo Molnar <mingo@redhat.com>, x86@kernel.org
List-Id: linux-arch.vger.kernel.org

On Tue, 18 Sep 2018, Eric W. Biederman wrote:

> Now that the pkey handling has been removed force_sig_info_fault and
> force_sig_fault perform identical work.  Just the type of the address
> paramter is different.  So replace calls to force_sig_info_fault with
> calls to force_sig_fault, and remove force_sig_info_fault.
> 
> Signed-off-by: "Eric W. Biederman" <ebiederm@xmission.com>

Reviewed-by: Thomas Gleixner <tglx@linutronix.de>
