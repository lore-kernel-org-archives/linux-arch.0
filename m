From: Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH v3 2/3] mutex: add support for wound/wait style locks, v3
Date: Wed, 22 May 2013 13:37:36 +0200
Message-ID: <20130522113736.GO18810@twins.programming.kicks-ass.net>
References: <20130428165914.17075.57751.stgit@patser>
 <20130428170407.17075.80082.stgit@patser>
 <20130430191422.GA5763@phenom.ffwll.local>
 <519CA976.9000109@canonical.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <519CA976.9000109@canonical.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Maarten Lankhorst <maarten.lankhorst@canonical.com>
Cc: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, x86@kernel.org, dri-devel@lists.freedesktop.org, linaro-mm-sig@lists.linaro.org, robclark@gmail.com, rostedt@goodmis.org, tglx@linutronix.de, mingo@elte.hu, linux-media@vger.kernel.org, Dave Airlie <airlied@redhat.com>
List-Id: linux-arch.vger.kernel.org

> Are there any issues left? I included the patch you wrote for injecting -EDEADLK too
> in my tree. The overwhelming silence makes me think there are either none, or
> nobody cared enough to review it. :(

It didn't manage to reach my inbox it seems,.. I can only find a debug
patch in this thread.
