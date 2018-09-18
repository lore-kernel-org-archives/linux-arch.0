Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from Galois.linutronix.de ([146.0.238.70]:58705 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729200AbeISCCT (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 18 Sep 2018 22:02:19 -0400
Date: Tue, 18 Sep 2018 22:28:02 +0200 (CEST)
From: Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [REVIEW][PATCH 07/20] signal/x86/traps: Factor out show_signal
In-Reply-To: <20180918000546.12552-7-ebiederm@xmission.com>
Message-ID: <alpine.DEB.2.21.1809182227410.1468@nanos.tec.linutronix.de>
References: <87y3bzk6yv.fsf@xmission.com> <20180918000546.12552-7-ebiederm@xmission.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: "Eric W. Biederman" <ebiederm@xmission.com>
Cc: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, Ingo Molnar <mingo@redhat.com>, x86@kernel.org
Message-ID: <20180918202802.h3FsOLucmoiFE0cd56i5FNlCseBW-URRN5ODX0O0zNQ@z>

On Tue, 18 Sep 2018, Eric W. Biederman wrote:

> The code for conditionally printing unhanded signals is duplicated twice
> in arch/x86/kernel/traps.c.  Factor it out into it's own subroutine
> called show_signal to make the code clearer and easier to maintain.
>
> Signed-off-by: "Eric W. Biederman" <ebiederm@xmission.com>

Reviewed-by: Thomas Gleixner <tglx@linutronix.de>
