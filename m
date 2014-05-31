From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [RFC 03/32] fs: introduce sys_utimens64at
Date: Sat, 31 May 2014 16:55:44 +0200
Message-ID: <4824036.97Kbggn7gm@wuerfel>
References: <1401480116-1973111-1-git-send-email-arnd@arndb.de> <1401480116-1973111-4-git-send-email-arnd@arndb.de> <m2ppiul2u9.fsf@linux-m68k.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <m2ppiul2u9.fsf@linux-m68k.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Andreas Schwab <schwab@linux-m68k.org>
Cc: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, joseph@codesourcery.com, john.stultz@linaro.org, hch@infradead.org, tglx@linutronix.de, geert@linux-m68k.org, lftan@altera.com, hpa@zytor.com, linux-fsdevel@vger.kernel.org
List-Id: linux-arch.vger.kernel.org

On Saturday 31 May 2014 11:22:38 Andreas Schwab wrote:
> Arnd Bergmann <arnd@arndb.de> writes:
> 
> > +asmlinkage long sys_utimens64at(int dfd, const char __user *filename,
> 
> All existing syscall names have the 64 suffix last, including the *at
> variants, so sys_utimensat64 would be more in line.

Ok, makes sense. I actually typed utimensat64 a few times myself and
couldn't really decide which one to use.

	Arnd
