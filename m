From: Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [REVIEW][PATCH 09/20] signal/x86/traps: Use force_sig_bnderr
Date: Tue, 18 Sep 2018 22:34:03 +0200 (CEST)
Message-ID: <alpine.DEB.2.21.1809182233510.1468@nanos.tec.linutronix.de>
References: <87y3bzk6yv.fsf@xmission.com> <20180918000546.12552-9-ebiederm@xmission.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180918000546.12552-9-ebiederm@xmission.com>
Sender: linux-kernel-owner@vger.kernel.org
To: "Eric W. Biederman" <ebiederm@xmission.com>
Cc: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, Ingo Molnar <mingo@redhat.com>, x86@kernel.org
List-Id: linux-arch.vger.kernel.org

On Tue, 18 Sep 2018, Eric W. Biederman wrote:

> Instead of generating the siginfo in x86 specific code use the new
> helper function force_sig_bnderr to separate the concerns of
> collecting the information and generating a proper siginfo.
> 
> Making the code easier to understand and maintain.

Reviewed-by: Thomas Gleixner <tglx@linutronix.de>
