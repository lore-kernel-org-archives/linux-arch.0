Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from Galois.linutronix.de ([146.0.238.70]:58687 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729732AbeISB5M (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 18 Sep 2018 21:57:12 -0400
Date: Tue, 18 Sep 2018 22:22:56 +0200 (CEST)
From: Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [REVIEW][PATCH 05/20] signal/x86: In trace_mpx_bounds_register_exception
 add __user annotations
In-Reply-To: <20180918000546.12552-5-ebiederm@xmission.com>
Message-ID: <alpine.DEB.2.21.1809182222290.1468@nanos.tec.linutronix.de>
References: <87y3bzk6yv.fsf@xmission.com> <20180918000546.12552-5-ebiederm@xmission.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: "Eric W. Biederman" <ebiederm@xmission.com>
Cc: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, Ingo Molnar <mingo@redhat.com>, x86@kernel.org
Message-ID: <20180918202256.eLZ-nWSOYpfOBLK3Iz2sPSBV2_ScEHf6b0EmPtIreIA@z>

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
