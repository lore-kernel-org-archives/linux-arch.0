From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH 5/13] score - New architecure port to SunplusCT S+CORE processor
Date: Fri, 27 Mar 2009 21:53:05 +0100
Message-ID: <200903272153.05622.arnd@arndb.de>
References: <OFE9A5E3A2.37B73BA8-ON48257586.0008CFAC-48257586.00091B05@sunplusct.com> <200903272019.53689.arnd@arndb.de> <20090327202614.GA22054@uranus.ravnborg.org>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.126.186]:64194 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755436AbZC0UxP (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Fri, 27 Mar 2009 16:53:15 -0400
In-Reply-To: <20090327202614.GA22054@uranus.ravnborg.org>
Content-Disposition: inline
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Sam Ravnborg <sam@ravnborg.org>
Cc: liqin.chen@sunplusct.com, linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org, torvalds@linux-foundation.org

On Friday 27 March 2009, Sam Ravnborg wrote:

> Thats strange indeed.
> This structure will then change layout depending on the target bit-size
> of the compiler.
> 
> From x86:
> #ifdef __i386__
>         unsigned long           __unused1;
> #endif
>         __kernel_time_t         shm_dtime;      /* last detach time */
> #ifdef __i386__
>         unsigned long           __unused2;
> #endif
> 
> long is 64 bit in one case and 32 bit in another case.
> I'm confused..

The idea here is to have the same layout for both by adding
long (32 bit) padding between 32 bit members on i386 and not
having the padding along the __kernel_time_t (which is also
long) members on x86_64. The problem is that some architectures
copying this didn't understand the part about the padding,
while others (big-endian ones) put the padding in the wrong
place by copying from i386.

By now, most of the existing architectures copied the i386
file, which is at least consistent and we've learned to
deal with it. I recommend just using this one as the
asm-generic version and letting all new archs fall back
to that.

> I would expect it to be safer to be bit-size neutral in our
> exported headers.
> But the score people know there userlend best so let them decide.
 
> Still they should audit all their exported headers.
> They cannot assume it was right because they copied them from
> somewhere.

Yes, I agree. Hopefully I'll manage to get my patches into
shape to post the generic versions in the next days so we can use
them on microblaze and score as well as all future versions.

	Arnd <><
