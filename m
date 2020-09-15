Return-Path: <SRS0=9PY8=CY=vger.kernel.org=linux-arch-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E793C43461
	for <linux-arch@archiver.kernel.org>; Tue, 15 Sep 2020 16:15:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C52B1206E6
	for <linux-arch@archiver.kernel.org>; Tue, 15 Sep 2020 16:15:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1600186540;
	bh=h8FrMLmRYTR7EG3ov+53gJbd++NMD57LcgsrZ+W8Sok=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=AM9RsEmPxb2f9X48MHKhekY36t2WrVh+2UM4d26uy2Qi091LhZjxesNMCg2z9lVvH
	 NmqQ/3EHvCkYb3qD4Ft9/mYmeg89mmrPe5sWdpNvEwzrPhEEKWPEKCWBGEx7WrLlQ/
	 cIUQpmhzH5mLsTosWY9SOrxcC/wqQsw9hOeIrjrM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727503AbgIOQPQ (ORCPT <rfc822;linux-arch@archiver.kernel.org>);
        Tue, 15 Sep 2020 12:15:16 -0400
Received: from mail.kernel.org ([198.145.29.99]:56778 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727587AbgIOQLK (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Tue, 15 Sep 2020 12:11:10 -0400
Received: from willie-the-truck (236.31.169.217.in-addr.arpa [217.169.31.236])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A5369206BE;
        Tue, 15 Sep 2020 16:10:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1600186258;
        bh=h8FrMLmRYTR7EG3ov+53gJbd++NMD57LcgsrZ+W8Sok=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=sO86BqljD5TTUSf3Do5Tr23UIE8zY6Bz1UDtpNwChPTIbD5+keIeFFrqnf8XsRJr0
         ojiIAWWGP4t8b9bz6D3u0TyrwIrYQfCa/vsL1qeBTtNKTpMduZ7SEC4jTL9i3luICh
         OrDt1j8SFI8DM7C/qo2V0n/aLixXUHY994PZbfUw=
Date:   Tue, 15 Sep 2020 17:10:48 +0100
From:   Will Deacon <will@kernel.org>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     LKML <linux-kernel@vger.kernel.org>, linux-arch@vger.kernel.org,
        Linus Torvalds <torvalds@linuxfoundation.org>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Valentin Schneider <valentin.schneider@arm.com>,
        Richard Henderson <rth@twiddle.net>,
        Ivan Kokshaysky <ink@jurassic.park.msu.ru>,
        Matt Turner <mattst88@gmail.com>, linux-alpha@vger.kernel.org,
        Jeff Dike <jdike@addtoit.com>,
        Richard Weinberger <richard@nod.at>,
        Anton Ivanov <anton.ivanov@cambridgegreys.com>,
        linux-um@lists.infradead.org, Brian Cain <bcain@codeaurora.org>,
        linux-hexagon@vger.kernel.org,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        linux-m68k@lists.linux-m68k.org, Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        Ingo Molnar <mingo@redhat.com>,
        Russell King <linux@armlinux.org.uk>,
        linux-arm-kernel@lists.infradead.org,
        Chris Zankel <chris@zankel.net>,
        Max Filippov <jcmvbkbc@gmail.com>,
        linux-xtensa@linux-xtensa.org,
        Jani Nikula <jani.nikula@linux.intel.com>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        intel-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Josh Triplett <josh@joshtriplett.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Shuah Khan <shuah@kernel.org>, rcu@vger.kernel.org,
        linux-kselftest@vger.kernel.org
Subject: Re: [patch 06/13] locking/bitspinlock: Clenaup PREEMPT_COUNT
 leftovers
Message-ID: <20200915161047.GA26745@willie-the-truck>
References: <20200914204209.256266093@linutronix.de>
 <20200914204441.579902354@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200914204441.579902354@linutronix.de>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Mon, Sep 14, 2020 at 10:42:15PM +0200, Thomas Gleixner wrote:
> CONFIG_PREEMPT_COUNT is now unconditionally enabled and will be
> removed. Cleanup the leftovers before doing so.
> 
> Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
> ---
>  include/linux/bit_spinlock.h |    4 +---
>  1 file changed, 1 insertion(+), 3 deletions(-)
> 
> --- a/include/linux/bit_spinlock.h
> +++ b/include/linux/bit_spinlock.h
> @@ -90,10 +90,8 @@ static inline int bit_spin_is_locked(int
>  {
>  #if defined(CONFIG_SMP) || defined(CONFIG_DEBUG_SPINLOCK)
>  	return test_bit(bitnum, addr);
> -#elif defined CONFIG_PREEMPT_COUNT
> -	return preempt_count();
>  #else
> -	return 1;
> +	return preempt_count();
>  #endif

Acked-by: Will Deacon <will@kernel.org>

Will
