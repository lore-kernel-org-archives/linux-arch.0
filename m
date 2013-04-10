From: Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH v2 2/3] mutex: add support for reservation style locks,
 v2
Date: Wed, 10 Apr 2013 09:34:30 +0200
Message-ID: <1365579270.30071.25.camel@laptop>
References: <20130228102452.15191.22673.stgit@patser>
	 <20130228102502.15191.14146.stgit@patser>
	 <1364900432.18374.24.camel@laptop> <515AF1C1.7080508@canonical.com>
	 <1364921954.20640.22.camel@laptop> <1365076908.2609.94.camel@laptop>
	 <20130404133123.GW2228@phenom.ffwll.local>
	 <CAKMK7uG_qLQrZUdE_LRANm7qXPvGUisBx-k=+y=F2gA3=odkrQ@mail.gmail.com>
	 <20130409224223.GD20739@home.goodmis.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from 173-166-109-252-newengland.hfc.comcastbusiness.net ([173.166.109.252]:52075
	"EHLO bombadil.infradead.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751287Ab3DJHen (ORCPT
	<rfc822;linux-arch@vger.kernel.org>);
	Wed, 10 Apr 2013 03:34:43 -0400
Received: from dhcp-089-099-019-018.chello.nl ([89.99.19.18] helo=dyad.programming.kicks-ass.net)
	by bombadil.infradead.org with esmtpsa (Exim 4.80.1 #2 (Red Hat Linux))
	id 1UPpYI-0007Ac-H6
	for linux-arch@vger.kernel.org; Wed, 10 Apr 2013 07:34:42 +0000
In-Reply-To: <20130409224223.GD20739@home.goodmis.org>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Daniel Vetter <daniel.vetter@ffwll.ch>, Maarten Lankhorst <maarten.lankhorst@canonical.com>, linux-arch@vger.kernel.org, x86@kernel.org, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, dri-devel <dri-devel@lists.freedesktop.org>, "linaro-mm-sig@lists.linaro.org" <linaro-mm-sig@lists.linaro.org>, rob clark <robclark@gmail.com>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@elte.hu>, "linux-media@vger.kernel.org" <linux-media@vger.kernel.org>

On Tue, 2013-04-09 at 18:42 -0400, Steven Rostedt wrote:
> What about setting an age as soon as it starts the process
> of grabbing one of these locks? And it keeps the age until it
> successfully grabs and releases all the locks again. It wont reset if
> it
> had to drop the locks and start over.


That is indeed the proposed mechanism. It ensures FIFO fairness between
the various threads that try to acquire a set.
