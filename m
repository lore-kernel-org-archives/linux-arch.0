From: Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [PATCH] [RFC] mutex: w/w mutex slowpath debugging
Date: Tue, 30 Apr 2013 15:29:39 -0400
Message-ID: <1367350179.30667.70.camel@gandalf.local.home>
References: <20130428165914.17075.57751.stgit@patser>
	 <1367347549-8022-1-git-send-email-daniel.vetter@ffwll.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-media-owner@vger.kernel.org>
In-Reply-To: <1367347549-8022-1-git-send-email-daniel.vetter@ffwll.ch>
Sender: linux-media-owner@vger.kernel.org
To: Daniel Vetter <daniel.vetter@ffwll.ch>
Cc: LKML <linux-kernel@vger.kernel.org>, linux-arch@vger.kernel.org, peterz@infradead.org, x86@kernel.org, dri-devel@lists.freedesktop.org, linaro-mm-sig@lists.linaro.org, robclark@gmail.com, daniel@ffwll.ch, tglx@linutronix.de, mingo@elte.hu, linux-media@vger.kernel.org
List-Id: linux-arch.vger.kernel.org

On Tue, 2013-04-30 at 20:45 +0200, Daniel Vetter wrote:
> /**
> diff --git a/kernel/mutex.c b/kernel/mutex.c
> index 66807c7..1cc3487 100644
> --- a/kernel/mutex.c
> +++ b/kernel/mutex.c
> @@ -827,6 +827,35 @@ int __sched mutex_trylock(struct mutex *lock)
>  EXPORT_SYMBOL(mutex_trylock);
>  
>  #ifndef CONFIG_DEBUG_LOCK_ALLOC
> +
> +#ifdef CONFIG_DEBUG_WW_MUTEX_SLOWPATH
> +static int __sched
> +ww_mutex_deadlock_injection(struct ww_mutex *lock, struct ww_acquire_ctx *ctx)
> +{
> +	if (ctx->deadlock_inject_countdown-- == 0) {
> +		tmp = ctx->deadlock_inject_interval;
> +		if (tmp > UINT_MAX/4)
> +			tmp = UINT_MAX;
> +		else
> +			tmp = tmp*2 + tmp + tmp/2;
> +
> +		ctx->deadlock_inject_interval = tmp;
> +		ctx->deadlock_inject_countdown = tmp;
> +
> +		ww_mutex_unlock(lock);
> +
> +		return -EDEADLK;
> +	}
> +
> +	return 0;
> +}
> +#else
> +static int __sched
> +ww_mutex_deadlock_injection(struct ww_mutex *lock, struct ww_acquire_ctx *ctx)
> +{
> +	return 0;
> +}

This should be a static inline, and remove the __sched. There's no
reason to make this anything but a nop when disabled.

-- Steve
