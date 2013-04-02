From: Peter Zijlstra <a.p.zijlstra@chello.nl>
Subject: Re: [PATCH v2 2/3] mutex: add support for reservation style locks,
 v2
Date: Tue, 02 Apr 2013 12:57:54 +0200
Message-ID: <1364900274.18374.21.camel@laptop>
References: <20130228102452.15191.22673.stgit@patser>
	 <20130228102502.15191.14146.stgit@patser>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from merlin.infradead.org ([205.233.59.134]:40918 "EHLO
	merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932330Ab3DBK54 (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Tue, 2 Apr 2013 06:57:56 -0400
Received: from dhcp-089-099-019-018.chello.nl ([89.99.19.18] helo=dyad.programming.kicks-ass.net)
	by merlin.infradead.org with esmtpsa (Exim 4.80.1 #2 (Red Hat Linux))
	id 1UMyua-0003bu-7Y
	for linux-arch@vger.kernel.org; Tue, 02 Apr 2013 10:57:56 +0000
In-Reply-To: <20130228102502.15191.14146.stgit@patser>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Maarten Lankhorst <maarten.lankhorst@canonical.com>
Cc: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, daniel.vetter@ffwll.ch, x86@kernel.org, dri-devel@lists.freedesktop.org, linaro-mm-sig@lists.linaro.org, robclark@gmail.com, tglx@linutronix.de, mingo@elte.hu, linux-media@vger.kernel.org

On Thu, 2013-02-28 at 11:25 +0100, Maarten Lankhorst wrote:
> +struct ticket_mutex {
> +       struct mutex base;
> +       atomic_long_t reservation_id;
> +};

I'm not sure this is a good name, esp. due to the potential confusion
vs the ticket spinlocks we have. 
