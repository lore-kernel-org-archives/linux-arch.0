From: Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH v2 2/3] mutex: add support for reservation style locks,
 v2
Date: Thu, 04 Apr 2013 18:43:06 +0200
Message-ID: <1365093786.2609.113.camel@laptop>
References: <20130228102452.15191.22673.stgit@patser>
	 <20130228102502.15191.14146.stgit@patser>
	 <1364900432.18374.24.camel@laptop> <515AF1C1.7080508@canonical.com>
	 <1364921954.20640.22.camel@laptop> <1365076908.2609.94.camel@laptop>
	 <20130404133123.GW2228@phenom.ffwll.local>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-media-owner@vger.kernel.org>
In-Reply-To: <20130404133123.GW2228@phenom.ffwll.local>
Sender: linux-media-owner@vger.kernel.org
To: Daniel Vetter <daniel@ffwll.ch>
Cc: Maarten Lankhorst <maarten.lankhorst@canonical.com>, linux-arch@vger.kernel.org, daniel.vetter@ffwll.ch, x86@kernel.org, linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org, linaro-mm-sig@lists.linaro.org, robclark@gmail.com, tglx@linutronix.de, mingo@elte.hu, linux-media@vger.kernel.org
List-Id: linux-arch.vger.kernel.org

On Thu, 2013-04-04 at 15:31 +0200, Daniel Vetter wrote:
> Another big reason for having a start/end marker like you've describe
> is
> lockdep support.

Yeah, I saw how you did that.. but there's other ways of making it work
too, you could for instance create a new validation state for this type
of lock.

That said, I didn't consider lockdep too much, I first want the regular
semantics clear.
