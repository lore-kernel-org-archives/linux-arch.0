Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from Galois.linutronix.de ([146.0.238.70]:58724 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729693AbeISCIW (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 18 Sep 2018 22:08:22 -0400
Date: Tue, 18 Sep 2018 22:34:03 +0200 (CEST)
From: Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [REVIEW][PATCH 09/20] signal/x86/traps: Use force_sig_bnderr
In-Reply-To: <20180918000546.12552-9-ebiederm@xmission.com>
Message-ID: <alpine.DEB.2.21.1809182233510.1468@nanos.tec.linutronix.de>
References: <87y3bzk6yv.fsf@xmission.com> <20180918000546.12552-9-ebiederm@xmission.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: "Eric W. Biederman" <ebiederm@xmission.com>
Cc: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, Ingo Molnar <mingo@redhat.com>, x86@kernel.org
Message-ID: <20180918203403.SbVbP96Mq_X174lI94tkTDx6927zSjLckiWTi6k5IZU@z>

On Tue, 18 Sep 2018, Eric W. Biederman wrote:

> Instead of generating the siginfo in x86 specific code use the new
> helper function force_sig_bnderr to separate the concerns of
> collecting the information and generating a proper siginfo.
> 
> Making the code easier to understand and maintain.

Reviewed-by: Thomas Gleixner <tglx@linutronix.de>
