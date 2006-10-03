Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from palinux.external.hp.com ([192.25.206.14]:47786 "EHLO
	mail.parisc-linux.org") by vger.kernel.org with ESMTP
	id S1030190AbWJCPVO (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Tue, 3 Oct 2006 11:21:14 -0400
Date: Tue, 3 Oct 2006 09:21:13 -0600
From: Matthew Wilcox <matthew@wil.cx>
Subject: Re: epoll_pwait
Message-ID: <20061003152112.GS16272@parisc-linux.org>
References: <20061003002728.01133537.akpm@osdl.org> <1159862233.3438.45.camel@pmac.infradead.org> <1159864949.3438.55.camel@pmac.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1159864949.3438.55.camel@pmac.infradead.org>
Sender: linux-arch-owner@vger.kernel.org
To: David Woodhouse <dwmw2@infradead.org>
Cc: Andrew Morton <akpm@osdl.org>, linux-arch@vger.kernel.org, Davide Libenzi <davidel@xmailserver.org>, Michael Kerrisk <mtk-manpages@gmx.net>, Ulrich Drepper <drepper@redhat.com>, Roland McGrath <roland@redhat.com>, paulus@samba.org
List-ID: <linux-arch.vger.kernel.org>

On Tue, Oct 03, 2006 at 09:42:29AM +0100, David Woodhouse wrote:
> --- a/include/linux/eventpoll.h
> +++ b/include/linux/eventpoll.h
> @@ -29,8 +29,11 @@ #define EPOLLONESHOT (1 << 30)
>  #define EPOLLET (1 << 31)
>  
>  /* 
> - * On x86-64 make the 64bit structure have the same alignment as the
> - * 32bit structure. This makes 32bit emulation easier.
> + * On i386, the u64 won't be aligned to 64-bits. So on x86_64 we pack
> + * the structure to be compatible. It seems that other 32-bit architectures
> + * will align the u64 naturally anyway, so we don't have to worry there.
> + * For example, both ppc and ppc64 put an extra 32 bits of padding in 
> + * between the fields.
>   */
>  #ifdef __x86_64__
>  #define EPOLL_PACKED __attribute__((packed))

Obviously, this should be

#if (defined(__x86_64__) || defined(__ia64))

since they both COMPAT i386.
