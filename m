From: Peter Zijlstra <a.p.zijlstra@chello.nl>
Subject: Re: [PATCH v2 2/3] mutex: add support for reservation style locks,
 v2
Date: Tue, 02 Apr 2013 12:56:14 +0200
Message-ID: <1364900174.18374.19.camel@laptop>
References: <20130228102452.15191.22673.stgit@patser>
	 <20130228102502.15191.14146.stgit@patser>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20130228102502.15191.14146.stgit@patser>
Sender: linux-kernel-owner@vger.kernel.org
To: Maarten Lankhorst <maarten.lankhorst@canonical.com>
Cc: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, daniel.vetter@ffwll.ch, x86@kernel.org, dri-devel@lists.freedesktop.org, linaro-mm-sig@lists.linaro.org, robclark@gmail.com, tglx@linutronix.de, mingo@elte.hu, linux-media@vger.kernel.org
List-Id: linux-arch.vger.kernel.org

On Thu, 2013-02-28 at 11:25 +0100, Maarten Lankhorst wrote:
> +mutex_reserve_lock_slow and mutex_reserve_lock_intr_slow:
> +  Similar to mutex_reserve_lock, except it won't backoff with
> -EAGAIN.
> +  This is useful when mutex_reserve_lock failed with -EAGAIN, and you
> +  unreserved all reservation_locks so no deadlock can occur.
> +

I don't particularly like these function names, with lock
implementations the _slow post-fix is typically used for slow path
implementations, not API type interfaces.
