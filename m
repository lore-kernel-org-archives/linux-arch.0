Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from Galois.linutronix.de ([146.0.238.70]:58656 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729926AbeISBuO (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 18 Sep 2018 21:50:14 -0400
Date: Tue, 18 Sep 2018 22:16:00 +0200 (CEST)
From: Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [REVIEW][PATCH 02/20] signal/x86: Inline fill_sigtrap_info in
 it's only caller send_sigtrap
In-Reply-To: <20180918000546.12552-2-ebiederm@xmission.com>
Message-ID: <alpine.DEB.2.21.1809182215450.1468@nanos.tec.linutronix.de>
References: <87y3bzk6yv.fsf@xmission.com> <20180918000546.12552-2-ebiederm@xmission.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: "Eric W. Biederman" <ebiederm@xmission.com>
Cc: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, Ingo Molnar <mingo@redhat.com>, x86@kernel.org
Message-ID: <20180918201600.k3WU6By-hvXX71acgdSx5nSl-5HR6JyFw5_twY3bKHk@z>

On Tue, 18 Sep 2018, Eric W. Biederman wrote:

> The function fill_sigtrap_info now only has one caller so remove
> it and put it's contents in it's caller.
> 
> Signed-off-by: "Eric W. Biederman" <ebiederm@xmission.com>

Reviewed-by: Thomas Gleixner <tglx@linutronix.de>
