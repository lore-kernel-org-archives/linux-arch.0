Return-Path: <linux-arch-owner@vger.kernel.org>
Date: Fri, 18 Mar 2005 20:53:34 -0800
From: Andrew Morton <akpm@osdl.org>
Subject: Re: [PATCH] Remove spurious BUG from posix-cpu-timers
Message-Id: <20050318205334.087395d3.akpm@osdl.org>
In-Reply-To: <20050319044503.GK21986@parcelfarce.linux.theplanet.co.uk>
References: <20050319044503.GK21986@parcelfarce.linux.theplanet.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
To: Matthew Wilcox <matthew@wil.cx>
Cc: torvalds@osdl.org, linux-arch@vger.kernel.org, roland@redhat.com
List-ID: <linux-arch.vger.kernel.org>

Matthew Wilcox <matthew@wil.cx> wrote:
>
> 
> PA-RISC does not necessarily have interrupts disabled while timers are
> running.  This doesn't appear to be a requirement, but posix-cpu-timers
> seems to think it is.
> 

But a bit later on we do

        spin_lock(&tsk->sighand->siglock);

rather than spin_lock_irqsave()?
