From: Daniel Vetter <daniel.vetter@ffwll.ch>
Subject: Re: [Linaro-mm-sig] [PATCH v3 2/3] mutex: add support for wound/wait
 style locks, v3
Date: Thu, 23 May 2013 12:45:00 +0200
Message-ID: <CAKMK7uF=0aW4dY_0bmUox1N-kmQvXRr2-x3NBjL2VGO4grW6fQ@mail.gmail.com>
References: <20130428165914.17075.57751.stgit@patser>
	<20130428170407.17075.80082.stgit@patser>
	<20130430191422.GA5763@phenom.ffwll.local>
	<519CA976.9000109@canonical.com>
	<20130522161831.GQ18810@twins.programming.kicks-ass.net>
	<519CFF56.90600@canonical.com>
	<519DDDB2.80800@canonical.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <519DDDB2.80800@canonical.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Maarten Lankhorst <maarten.lankhorst@canonical.com>
Cc: Peter Zijlstra <peterz@infradead.org>, linux-arch@vger.kernel.org, x86@kernel.org, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, dri-devel <dri-devel@lists.freedesktop.org>, "linaro-mm-sig@lists.linaro.org" <linaro-mm-sig@lists.linaro.org>, rob clark <robclark@gmail.com>, Steven Rostedt <rostedt@goodmis.org>, Dave Airlie <airlied@redhat.com>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@elte.hu>, "linux-media@vger.kernel.org" <linux-media@vger.kernel.org>
List-Id: linux-arch.vger.kernel.org

On Thu, May 23, 2013 at 11:13 AM, Maarten Lankhorst
<maarten.lankhorst@canonical.com> wrote:
>> 2. Do you really want to drop the *_slow variants?
>> Doing so might reduce debugging slightly. I like method #2 in ww-mutex-design.txt, it makes it very clear why you
>> would handle the *_slow case differently anyway.
> As you pointed out, we wouldn't lose much debugging information.
> The same checks could be done in the normal variant with
> WARN_ON(ctx->lock && ctx->lock != lock);
> WARN_ON(ctx->lock && ctx->acquired > 0);

s/lock/contending_lock/ I guess. But yeah, I should have more
carefully read Peter's suggestion to fold in some of the ww_slow debug
checks, we can indeed keep the important debug checks even when
dropping slow. Silly me should be less sloppy.

> But it boils down to ww_mutex_lock_slow returning void instead of int __must_check from ww_mutex_lock.
>
> Maybe add inlines for *_slow, that use the ww_mutex_lock functions, and check ctx->lock == lock in debugging mode?

So either we keep the _slow versions or drop the __must_check for
ww_mutex_lock. In both cases the ww mutex user needs to think a bit
what to do, and I don't there's much we can do in the implementation
(beside all the existing debug support we have) to help. So now I'm
leaning more towards dropping the _slow variants to avoid interface
proliferation.
-Daniel
--
Daniel Vetter
Software Engineer, Intel Corporation
+41 (0) 79 365 57 48 - http://blog.ffwll.ch
