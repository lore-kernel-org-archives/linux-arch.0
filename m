From: Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [REVIEW][PATCH 02/20] signal/x86: Inline fill_sigtrap_info in
 it's only caller send_sigtrap
Date: Tue, 18 Sep 2018 22:16:00 +0200 (CEST)
Message-ID: <alpine.DEB.2.21.1809182215450.1468@nanos.tec.linutronix.de>
References: <87y3bzk6yv.fsf@xmission.com> <20180918000546.12552-2-ebiederm@xmission.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180918000546.12552-2-ebiederm@xmission.com>
Sender: linux-kernel-owner@vger.kernel.org
To: "Eric W. Biederman" <ebiederm@xmission.com>
Cc: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, Ingo Molnar <mingo@redhat.com>, x86@kernel.org
List-Id: linux-arch.vger.kernel.org

On Tue, 18 Sep 2018, Eric W. Biederman wrote:

> The function fill_sigtrap_info now only has one caller so remove
> it and put it's contents in it's caller.
> 
> Signed-off-by: "Eric W. Biederman" <ebiederm@xmission.com>

Reviewed-by: Thomas Gleixner <tglx@linutronix.de>
