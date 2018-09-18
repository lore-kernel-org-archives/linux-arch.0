Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from Galois.linutronix.de ([146.0.238.70]:58738 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729732AbeISCLW (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 18 Sep 2018 22:11:22 -0400
Date: Tue, 18 Sep 2018 22:37:02 +0200 (CEST)
From: Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [REVIEW][PATCH 11/20] signal/x86/traps: Simplify trap
 generation
In-Reply-To: <20180918000546.12552-11-ebiederm@xmission.com>
Message-ID: <alpine.DEB.2.21.1809182236170.1468@nanos.tec.linutronix.de>
References: <87y3bzk6yv.fsf@xmission.com> <20180918000546.12552-11-ebiederm@xmission.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: "Eric W. Biederman" <ebiederm@xmission.com>
Cc: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, Ingo Molnar <mingo@redhat.com>, x86@kernel.org
Message-ID: <20180918203702.iA1qZGS8IH9PBMFlx7gm0198g8AOHE6PSewuQK9_n9s@z>

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
