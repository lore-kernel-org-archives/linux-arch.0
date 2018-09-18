Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from Galois.linutronix.de ([146.0.238.70]:58806 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729872AbeISCZx (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 18 Sep 2018 22:25:53 -0400
Date: Tue, 18 Sep 2018 22:51:30 +0200 (CEST)
From: Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [REVIEW][PATCH 18/20] signal/x86: Replace force_sig_info_fault
 with force_sig_fault
In-Reply-To: <20180918000546.12552-18-ebiederm@xmission.com>
Message-ID: <alpine.DEB.2.21.1809182251100.1468@nanos.tec.linutronix.de>
References: <87y3bzk6yv.fsf@xmission.com> <20180918000546.12552-18-ebiederm@xmission.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: "Eric W. Biederman" <ebiederm@xmission.com>
Cc: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, Ingo Molnar <mingo@redhat.com>, x86@kernel.org
Message-ID: <20180918205130.-nicS08FIKXCNHGJuF4jF_Xagi55dhAa7akaxXLEJZA@z>

On Tue, 18 Sep 2018, Eric W. Biederman wrote:

> Now that the pkey handling has been removed force_sig_info_fault and
> force_sig_fault perform identical work.  Just the type of the address
> paramter is different.  So replace calls to force_sig_info_fault with
> calls to force_sig_fault, and remove force_sig_info_fault.
> 
> Signed-off-by: "Eric W. Biederman" <ebiederm@xmission.com>

Reviewed-by: Thomas Gleixner <tglx@linutronix.de>
