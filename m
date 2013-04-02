From: Peter Zijlstra <a.p.zijlstra@chello.nl>
Subject: Re: [PATCH v2 2/3] mutex: add support for reservation style locks,
 v2
Date: Tue, 02 Apr 2013 13:04:47 +0200
Message-ID: <1364900687.18374.28.camel@laptop>
References: <20130228102452.15191.22673.stgit@patser>
	 <20130228102502.15191.14146.stgit@patser>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-media-owner@vger.kernel.org>
In-Reply-To: <20130228102502.15191.14146.stgit@patser>
Sender: linux-media-owner@vger.kernel.org
To: Maarten Lankhorst <maarten.lankhorst@canonical.com>
Cc: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, daniel.vetter@ffwll.ch, x86@kernel.org, dri-devel@lists.freedesktop.org, linaro-mm-sig@lists.linaro.org, robclark@gmail.com, tglx@linutronix.de, mingo@elte.hu, linux-media@vger.kernel.org, Steven Rostedt <rostedt@goodmis.org>
List-Id: linux-arch.vger.kernel.org

On Thu, 2013-02-28 at 11:25 +0100, Maarten Lankhorst wrote:
> +The algorithm that TTM came up with for dealing with this problem is
> +quite simple.  For each group of buffers (execbuf) that need to be
> +locked, the caller would be assigned a unique reservation_id, from a
> +global counter.  In case of deadlock while locking all the buffers
> +associated with a execbuf, the one with the lowest reservation_id
> +wins, and the one with the higher reservation_id unlocks all of the
> +buffers that it has already locked, and then tries again.

So the thing that made me cringe inside when I read this was making it
all work on -rt, where we also need to take PI into account and ensure
the entire thing is deterministic.

It _might_ be 'easy' and we could fall back to PI mutex behaviour in
the case the reservation IDs match; however the entire for-all-bufs
retry loops do worry me still.

Head hurts, needs more time to ponder. It would be good if someone else
(this would probably be you maarten) would also consider this and
explore
this 'interesting' problem space :-)
