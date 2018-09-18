Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from Galois.linutronix.de ([146.0.238.70]:58693 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729200AbeISB7k (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 18 Sep 2018 21:59:40 -0400
Date: Tue, 18 Sep 2018 22:25:23 +0200 (CEST)
From: Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [REVIEW][PATCH 06/20] signal/x86: Move mpx siginfo generation
 into do_bounds
In-Reply-To: <20180918000546.12552-6-ebiederm@xmission.com>
Message-ID: <alpine.DEB.2.21.1809182225040.1468@nanos.tec.linutronix.de>
References: <87y3bzk6yv.fsf@xmission.com> <20180918000546.12552-6-ebiederm@xmission.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: "Eric W. Biederman" <ebiederm@xmission.com>
Cc: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, Ingo Molnar <mingo@redhat.com>, x86@kernel.org
Message-ID: <20180918202523.c444Wk9KM748RWdPEKbSL93LcLBaUcB2Yyb0gcs7Vqc@z>

On Tue, 18 Sep 2018, Eric W. Biederman wrote:

> This separates the logic of generating the signal from the logic of
> gathering the information about the bounds violation.
> 
> Signed-off-by: "Eric W. Biederman" <ebiederm@xmission.com>

Reviewed-by: Thomas Gleixner <tglx@linutronix.de>
