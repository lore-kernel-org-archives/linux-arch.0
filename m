Return-Path: <davem@redhat.com>
Received: from mx1.redhat.com ([66.187.233.31]:63718 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S261689AbUDIXso (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Fri, 9 Apr 2004 19:48:44 -0400
Date: Fri, 9 Apr 2004 16:45:06 -0700
From: "David S. Miller" <davem@redhat.com>
Subject: Re: posix message queues
Message-Id: <20040409164506.0611846a.davem@redhat.com>
In-Reply-To: <40745360.6000709@colorfullife.com>
References: <20040407120720.6b937deb.akpm@osdl.org>
	<40745360.6000709@colorfullife.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
To: Manfred Spraul <manfred@colorfullife.com>
Cc: akpm@osdl.org, linux-arch@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>

On Wed, 07 Apr 2004 21:15:44 +0200
Manfred Spraul <manfred@colorfullife.com> wrote:

> No. The unix spec mandates 'long' for the final C-library api. Using u32 
> would mean that glibc would have to add an emulation layer in user space 
> for 64-bit archs. In the long run, 64-bit kernels running 64-bit apps 
> will be the common case. I don't want to add an emulation layer to the 
> common case.

We need to support this stuff when running 32-bit apps, you cannot
avoid this Manfred.  So we'll need kernel compat layer code to
translate these structures containing 'long'.  Please code up the
necessary compat.c code for this posix message queues feature.

Thanks.
