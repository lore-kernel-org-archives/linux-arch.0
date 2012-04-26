From: Martin Schwidefsky <schwidefsky@de.ibm.com>
Subject: Re: [RFC] TIF_NOTIFY_RESUME, arch/*/*/*signal*.c and all such
Date: Thu, 26 Apr 2012 16:31:19 +0200
Message-ID: <20120426163119.6c245d5e@de.ibm.com>
References: <20120425123746.GA15560@redhat.com>
	<20120425125042.GF6871@ZenIV.linux.org.uk>
	<20120425130329.GA16413@redhat.com>
	<20120425133238.GG6871@ZenIV.linux.org.uk>
	<20120425145239.GA21386@redhat.com>
	<20120425154611.GA23672@redhat.com>
	<20120425161002.GH6871@ZenIV.linux.org.uk>
	<20120425170230.GA24977@redhat.com>
	<20120425175113.GI6871@ZenIV.linux.org.uk>
	<20120426091519.49eef9aa@de.ibm.com>
	<20120426135255.GA15600@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20120426135255.GA15600@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Oleg Nesterov <oleg@redhat.com>
Cc: Al Viro <viro@ZenIV.linux.org.uk>, Linus Torvalds <torvalds@linux-foundation.org>, linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org, Russell King <linux@arm.linux.org.uk>, Tejun Heo <tj@kernel.org>, Arnd Bergmann <arnd@arndb.de>, Roland McGrath <roland@hack.frob.com>
List-Id: linux-arch.vger.kernel.org

On Thu, 26 Apr 2012 15:52:55 +0200
Oleg Nesterov <oleg@redhat.com> wrote:

> On 04/26, Martin Schwidefsky wrote:
> > You need to be careful with inferior calls there. gdb likes to play games
> > with the registers inside the get_signal_to_deliver call, it wants to be
> > able to jump out of an interrupted system call, do its inferior call in
> > the debugee and then return to the interrupted system call.
> 
> Ah.
> 
> > You would have to to read, modify & restore the NEED_RESTART flag in gdb
> > over an inferior call.
> 
> I am not sure, but perhaps this is not really needed...
> 
> But at least this means that "if (we have any business doing restarts)"
> above is meaningless before get_signal_to_deliver().
> 
> 
> And I am confused, off-topic question... How it is possible to
> "then return to the interrupted system call" if that system call
> returned -ERESTART_RESTARTBLOCK but the inferior call in turn
> does the system call which changes restart_block->fn/etc ?

Returning from an inferior gdb call to a system call that needs to be
restarted with -ERESTART_RESTARTBLOCK is broken on all architectures
as far as I can tell. And it would be hard to fix it, basically you
have to save and restore the restart block.

-- 
blue skies,
   Martin.

"Reality continues to ruin my life." - Calvin.
