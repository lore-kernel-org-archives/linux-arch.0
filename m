From: Davidlohr Bueso <dave@stgolabs.net>
Subject: Re: [PATCH] locking/qspinlock: Use atomic_sub_return_release in
 queued_spin_unlock
Date: Mon, 13 Jun 2016 12:45:23 -0700
Message-ID: <20160613194523.GA2094@linux-80c1.suse>
References: <1464943094-3129-1-git-send-email-xinhui.pan@linux.vnet.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1464943094-3129-1-git-send-email-xinhui.pan@linux.vnet.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Pan Xinhui <xinhui.pan@linux.vnet.ibm.com>
Cc: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, arnd@arndb.de, peterz@infradead.org, waiman.long@hp.com
List-Id: linux-arch.vger.kernel.org

On Fri, 03 Jun 2016, Pan Xinhui wrote:

>The existing version uses a heavy barrier while only release semantics
>is required. So use atomic_sub_return_release instead.
>
>Suggested-by: Peter Zijlstra (Intel) <peterz@infradead.org>
>Signed-off-by: Pan Xinhui <xinhui.pan@linux.vnet.ibm.com>

I just noticed this change in -tip and, while I know that saving a barrier
in core spinlock paths is perhaps a worthy exception, I cannot help but
wonder if this is the begging of the end for smp__{before,after}_atomic().
