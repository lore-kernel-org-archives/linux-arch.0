From: Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [REVIEW][PATCH 05/20] signal/x86: In trace_mpx_bounds_register_exception
 add __user annotations
Date: Tue, 18 Sep 2018 22:22:56 +0200 (CEST)
Message-ID: <alpine.DEB.2.21.1809182222290.1468@nanos.tec.linutronix.de>
References: <87y3bzk6yv.fsf@xmission.com> <20180918000546.12552-5-ebiederm@xmission.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180918000546.12552-5-ebiederm@xmission.com>
Sender: linux-kernel-owner@vger.kernel.org
To: "Eric W. Biederman" <ebiederm@xmission.com>
Cc: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, Ingo Molnar <mingo@redhat.com>, x86@kernel.org
List-Id: linux-arch.vger.kernel.org

On Tue, 18 Sep 2018, Eric W. Biederman wrote:

> The value passed in to addr_referenced is of type void __user *, so update
> the addr_referenced parameter in trace_mpx_bounds_register_exception to match.
> 
> Also update the addr_referenced paramater in TP_STRUCT__entry as it again
> holdes the same value.
> 
> I don't know why this was missed earlier but sparse was complaining when
> testing test branch so fix this now.

Good question.

> Signed-off-by: "Eric W. Biederman" <ebiederm@xmission.com>

Reviewed-by: Thomas Gleixner <tglx@linutronix.de>
