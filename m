Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from Galois.linutronix.de ([146.0.238.70]:58729 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729693AbeISCI7 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 18 Sep 2018 22:08:59 -0400
Date: Tue, 18 Sep 2018 22:34:40 +0200 (CEST)
From: Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [REVIEW][PATCH 10/20] signal/x86/traps: Use force_sig instead
 of open coding it.
In-Reply-To: <20180918000546.12552-10-ebiederm@xmission.com>
Message-ID: <alpine.DEB.2.21.1809182234280.1468@nanos.tec.linutronix.de>
References: <87y3bzk6yv.fsf@xmission.com> <20180918000546.12552-10-ebiederm@xmission.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: "Eric W. Biederman" <ebiederm@xmission.com>
Cc: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, Ingo Molnar <mingo@redhat.com>, x86@kernel.org
Message-ID: <20180918203440.vi_qxkB7tqjpO0MWOTJNnecmiy7HOOBlEe02GjrPxPE@z>

On Tue, 18 Sep 2018, Eric W. Biederman wrote:

> The function "force_sig(sig, tsk)" is equivalent to "
> force_sig_info(sig, SEND_SIG_PRIV, tsk)".  Using the siginfo variants can
> be error prone so use the simpler old fashioned force_sig variant,
> and with luck the force_sig_info variant can go away.
> 
> Signed-off-by: "Eric W. Biederman" <ebiederm@xmission.com>

Reviewed-by: Thomas Gleixner <tglx@linutronix.de>
