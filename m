Return-Path: <linux-arch-owner@vger.kernel.org>
Date: Tue, 25 Jan 2005 22:41:12 -0800
From: "David S. Miller" <davem@davemloft.net>
Subject: Re: TASK_SIZE is variable.
Message-Id: <20050125224112.306cd1ea.davem@davemloft.net>
In-Reply-To: <20050126063627.GA7198@wotan.suse.de>
References: <1106692012.6480.158.camel@localhost.localdomain>
	<20050125155239.4bc469e6.davem@davemloft.net>
	<20050126063627.GA7198@wotan.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
To: Andi Kleen <ak@suse.de>
Cc: dwmw2@infradead.org, linux-arch@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>

On Wed, 26 Jan 2005 07:36:27 +0100
Andi Kleen <ak@suse.de> wrote:

> I still don't get it. When exactly can a process have memory > 32bit 
> and not have the 32bit flag set that is checked by TASK_SIZE. IMHO that's 
> the bug that needs addressing, because it will likely break more code.

I think on some platforms they move over to the 32-bit setting
in the thread struct before the address space is cleared out
for exec.

And if that is the case, I agree with Andi, that is the real bug
that needs to be fixed.

I recall that at one point Al Viro put some fix into binfmt_elf.c
that caused the thread compat type to change too early like that
and it made sparc64 explode so I knew to correct it immediately
and this happened years ago.

I just checked and ia64 sets thread.task_size in SET_PERSONALITY()
which is just fine, similarly for ppc64.  So I really wonder how
this problem can arise.
