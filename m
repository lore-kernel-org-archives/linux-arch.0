Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.126.188]:56304 "EHLO
	moutng.kundenserver.de") by vger.kernel.org with ESMTP
	id S1759438AbWLBKrw convert rfc822-to-8bit (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Sat, 2 Dec 2006 05:47:52 -0500
From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [RFC] timers, pointers to functions and type safety
Date: Sat, 2 Dec 2006 11:47:38 +0100
References: <20061201172149.GC3078@ftp.linux.org.uk>
In-Reply-To: <20061201172149.GC3078@ftp.linux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
Message-Id: <200612021147.40505.arnd@arndb.de>
Sender: linux-arch-owner@vger.kernel.org
To: Al Viro <viro@ftp.linux.org.uk>
Cc: Linus Torvalds <torvalds@osdl.org>, linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org, gcc@gcc.gnu.org
List-ID: <linux-arch.vger.kernel.org>

On Friday 01 December 2006 18:21, Al Viro wrote:
>  There is a tempting
> possibility to do that gradually, with all intermediates still in working
> state, provided that on all platforms currently supported by the kernel
> unsigned long and void * are indeed passed the same way (again, only for
> current kernel targets and existing gcc versions).  Namely, we could
>         * introduce SETUP_TIMER variant with cast to void (*)(unsigned long)
>         * switch to its use, converting callback instances to take pointers
> at the same time.  That would be done in reasonably sized groups.
>         * once it's over, flip ->function to void (*)(void *), ->data to
> void * and update SETUP_TIMER accordingly; deal with remaining few instances
> of ->function.

Another alternative might be to define an intermediate version of
timer_list that avoids adding new macros, like

struct timer_list {
	struct list_head entry;
­	unsigned long expires;

­	void (*function)(union { unsigned long l; void *p; }
				 __attribute__((transparent_union)));
­	union {
		unsigned long data __deprecated;
		void *obj;
	};

­	struct tvec_t_base_s *base;
};

Unfortunately, this relies more on gcc specific behavior than we
may want, and it makes it possible to abuse in new ways, like defining
a function to take an unsigned long argument, but passing the data
as void *obj.

	Arnd <><
