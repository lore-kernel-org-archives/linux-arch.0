From: Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [REVIEW][PATCH 07/20] signal/x86/traps: Factor out show_signal
Date: Tue, 18 Sep 2018 22:28:02 +0200 (CEST)
Message-ID: <alpine.DEB.2.21.1809182227410.1468@nanos.tec.linutronix.de>
References: <87y3bzk6yv.fsf@xmission.com> <20180918000546.12552-7-ebiederm@xmission.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180918000546.12552-7-ebiederm@xmission.com>
Sender: linux-kernel-owner@vger.kernel.org
To: "Eric W. Biederman" <ebiederm@xmission.com>
Cc: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, Ingo Molnar <mingo@redhat.com>, x86@kernel.org
List-Id: linux-arch.vger.kernel.org

On Tue, 18 Sep 2018, Eric W. Biederman wrote:

> The code for conditionally printing unhanded signals is duplicated twice
> in arch/x86/kernel/traps.c.  Factor it out into it's own subroutine
> called show_signal to make the code clearer and easier to maintain.
>
> Signed-off-by: "Eric W. Biederman" <ebiederm@xmission.com>

Reviewed-by: Thomas Gleixner <tglx@linutronix.de>
